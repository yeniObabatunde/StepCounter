import Foundation
import CoreData

class PersistenceStore {
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return  persistentContainer.viewContext
    }
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "StepCountModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("failed to load the data \(error.localizedDescription)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("data has been saved successfuly\(context)")
            } catch {
                print("data couldn't be saved")
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
