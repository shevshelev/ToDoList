//
//  ToDoTask+CoreDataClass.swift
//  
//
//  Created by Shevshelev Lev on 14.04.2022.
//

import Foundation
import CoreData
import RxDataSources

enum TaskStatus: String {
    case created
    case completed
    case deleted
}

@objc(ToDoTask)
public class ToDoTask: NSManagedObject {
    
    var status: TaskStatus {
        get {
            TaskStatus(rawValue: statusValue ?? "created") ?? .created
        }
        set {
            statusValue = newValue.rawValue
        }
    }
}

extension ToDoTask: IdentifiableType {
    public var identity: UUID {
        guard let id = id else {return UUID()}
        return id
    }
}
