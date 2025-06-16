//
//  StepCountModel+CoreDataProperties.swift
//  StepCounter
//
//  Created by Omoyeni on 15/04/2022.
//
//

import Foundation
import CoreData


extension StepCountModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StepCountModel> {
        return NSFetchRequest<StepCountModel>(entityName: "StepCountModel")
    }

    @NSManaged public var stepCount: Double

    func addNewSteps(stepCount: Double, context: NSManagedObjectContext){
        let steps = StepCountModel(context: context)
        steps.stepCount = stepCount
        
        didSave()
    }
}

//extension StepCountModel : Identifiable {
//
//}
