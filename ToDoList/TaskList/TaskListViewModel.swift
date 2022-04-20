//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 13.04.2022.
//

import RxCocoa
import RxDataSources

protocol TaskListViewModelProtocol {
    var taskList: BehaviorRelay<[ToDoTask]> { get set }
    func fetchIncompleteTasks()
    func editTask(from indexPath: IndexPath, and status: TaskStatus)
}

class TaskListViewModel: TaskListViewModelProtocol {
    var taskList = BehaviorRelay<[ToDoTask]>(value: [])
    
    
    
    private let storageManager: StorageManagerProtocol = StorageManager.shared

//    var taskList: BehaviorRelay<[ToDoTask]> {
//        BehaviorRelay<[ToDoTask]>(value: fetchIncompleteTasks())
//    }
    
    func fetchIncompleteTasks() {
        let tasks = storageManager.fetchData().filter { $0.status == .created }
        taskList.accept(tasks)
    }
    
    func editTask(from indexPath: IndexPath, and status: TaskStatus) {
        let task = taskList.value[indexPath.row]
        task.status = status
        print(task.title)
        storageManager.saveContext()
        fetchIncompleteTasks()
        print(task.title)
    }
}
