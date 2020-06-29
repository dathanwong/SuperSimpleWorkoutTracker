//
//  Exercise+CoreDataProperties.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/25/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var reps: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var muscleGroup: MuscleGroup?

    public var wrappedName: String{
        name ?? "Unknown Name"
    }
    
    
}
