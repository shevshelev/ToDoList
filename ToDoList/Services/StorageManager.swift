//
//  StorageManager.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 13.04.2022.
//

import CoreData

protocol StorageManagerProtocol {
    func saveContext()
    func createNewTask() -> ToDoTask
    func fetchData() -> [ToDoTask]
}

final class StorageManager: StorageManagerProtocol {
    
    static let shared: StorageManagerProtocol = StorageManager()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createNewTask() -> ToDoTask {
        let task = ToDoTask(context: context)
        saveContext()
        return task
    }
    
    func fetchData() -> [ToDoTask] {
        let fetchRequest = ToDoTask.fetchRequest()
        var taskList: [ToDoTask] = []
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return taskList
    }
}
