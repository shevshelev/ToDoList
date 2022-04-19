//
//  ToDoTask+CoreDataProperties.swift
//  
//
//  Created by Shevshelev Lev on 14.04.2022.
//
//

import Foundation
import CoreData


extension ToDoTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoTask> {
        return NSFetchRequest<ToDoTask>(entityName: "ToDoTask")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var explanation: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var statusValue: String?
    @NSManaged public var title: String
    @NSManaged public var id: UUID?

}
