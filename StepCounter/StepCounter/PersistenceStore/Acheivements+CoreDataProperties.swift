//
//  Acheivements+CoreDataProperties.swift
//  StepCounter
//
//  Created by Decagon on 16/04/2022.
//
//

import Foundation
import CoreData


extension Acheivements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Acheivements> {
        return NSFetchRequest<Acheivements>(entityName: "Acheivements")
    }

    @NSManaged public var imageName: Data?
    @NSManaged public var achievementBadge: String?
    @NSManaged public var achievementMileStone: String?

}

extension Acheivements : Identifiable {

}
