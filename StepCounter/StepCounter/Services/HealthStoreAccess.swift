import Foundation
import HealthKit

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completionHandler: @escaping (Bool) -> Void) {
        let steps: HKObjectType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        if healthStore?.authorizationStatus(for: steps) != HKAuthorizationStatus.notDetermined {
            healthStore?.enableBackgroundDelivery(for: steps, frequency: .immediate, withCompletion: { (worked, error) in
                    //registers for background data
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                })
        }
        
        guard let share = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {return}
        guard let read = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {return}
        guard let healthStore = healthStore else {
            return completionHandler(false) }
        healthStore.requestAuthorization(toShare: [share] , read: [read]) { (success, error) in
            completionHandler(success)
        }
    }
     
    func getWholeDate(date : Date) -> (startDate:Date, endDate: Date) {
            var startDate = date
            var length = TimeInterval()
            _ = Calendar.current.dateInterval(of: .day, start: &startDate, interval: &length, for: startDate)
            let endDate:Date = startDate.addingTimeInterval(length)
            return (startDate,endDate)
        }
    
    func CalculateStepsforAmonth(completionHandler: @escaping(HKStatisticsCollection?) -> Void) {
        
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {return}
        let startDate = Date().startOfDay()
        let anchorDate = Date.resetAtTheEndOfTheMonth()
        let interval = DateComponents(day: 1)
//        let (start, end) = self.getWholeDate(date: forSpecificDate)

//        let predicates = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: nil, options: .strictEndDate)
        
        query =  HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: anchorDate, intervalComponents: interval)
        
        if let query = query {
            query.initialResultsHandler = { query, staticticsCollection, errror in
                if errror != nil {
                    
                }
                else {
                    print(startDate, ":Date it is starting from ")
                    print(anchorDate, ":This is the anchor date")
                    completionHandler(staticticsCollection)
                    self.startObservingStepCountChanges()
                    
                }
            }
            if let healthStore = healthStore, let query = self.query {
                healthStore.execute(query)
            }
        }
    }

    func enableBackgroundDelivery(for type: HKObjectType,
                                  frequency: HKUpdateFrequency,
                                  withCompletion completion: @escaping (Bool, Error?) -> Void){
//        self.healthStore?.enableBackgroundDelivery(for: HKObjectType.workoutType(), frequency: .immediate, withCompletion: nil)
    }
    
    
    func startObservingStepCountChanges() {
        let sampleType =  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let query: HKObserverQuery = HKObserverQuery(sampleType: sampleType!, predicate: nil, updateHandler: self.stepChangeHandler)
        healthStore?.execute(query)
        healthStore?.enableBackgroundDelivery(for: sampleType!, frequency: .immediate, withCompletion: { (succeeded: Bool, error: Error!) in
            if succeeded{
                print("Enabled background delivery of stepcount changes")
            } else {
                if let theError = error{
                    print("Failed to enable background delivery of stepcount changes. ")
                    print("Error = \(theError.localizedDescription)")
                }
            }
        } as (Bool, Error?) -> Void)
    }

    private func stepChangeHandler(query: HKObserverQuery!, completionHandler: HKObserverQueryCompletionHandler!, error: Error!) {
        // Flag to check the background handler is working or not
        print("Backgound Mode activated")
//        fireTestPush()
//        completionHandler()
     }
    
}
