//
//  MuscleGroup+CoreDataProperties.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/25/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//
//

import Foundation
import CoreData


extension MuscleGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MuscleGroup> {
        return NSFetchRequest<MuscleGroup>(entityName: "MuscleGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var exercises: NSSet?

    public var wrappedName: String{
        name ?? "Unknown Name"
    }
    
    public var exerciseArray: [Exercise]{
        let set = exercises as? Set<Exercise> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for exercises
extension MuscleGroup {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
