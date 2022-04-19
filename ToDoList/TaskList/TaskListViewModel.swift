//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 13.04.2022.
//

import RxCocoa
import RxDataSources

protocol TaskListViewModelProtocol {
    var taskList: BehaviorRelay<[ToDoTask]> { get }
    func fetchIncompleteTasks() -> [ToDoTask]
}

class TaskListViewModel: TaskListViewModelProtocol {
    
    private let storageManager: StorageManagerProtocol = StorageManager.shared
    
//    var task1: ToDoTask {
//        let task = storageManager.createNewTask()
//        task.title = "Task1"
//        task.explanation = "DoDoDoDoDoDoDODODODoDODOododoDODoddo"
//        return task
//    }
//    var task2: ToDoTask {
//        let task = storageManager.createNewTask()
//        task.title = "Task1"
//        task.status = .completed
//        return task
//    }
//    var task3: ToDoTask {
//        let task = storageManager.createNewTask()
//        task.title = "Task1"
//        task.explanation = "JustDoIt"
//        return task
//    }

    
    var taskList: BehaviorRelay<[ToDoTask]> {
        BehaviorRelay<[ToDoTask]>(value: fetchIncompleteTasks())
    }
    
    func fetchIncompleteTasks() -> [ToDoTask] {
//        [task1, task2, task3].filter { $0.status == .created}
        storageManager.fetchData().filter { $0.status == .created }
    }
    
    
}
