//
//  CompletedAndDeletedTaskListInteractor.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 20.04.2022.
//

import Foundation

protocol CompletedAndDeletedTaskListInteractorInputProtocol {
    init(presenter: CompletedAndDeletedTaskListInteractorOutputProtocol)
    func fetchTasks()
    func repeatTask(_ task: ToDoTask)
}

protocol CompletedAndDeletedTaskListInteractorOutputProtocol: AnyObject {
    func tasksDidReceive(with dataStore: CompletedAndDeletedTaskDataStore)
}

class CompletedAndDeletedTaskListInteractor: CompletedAndDeletedTaskListInteractorInputProtocol {
    unowned let presenter: CompletedAndDeletedTaskListInteractorOutputProtocol
    required init(presenter: CompletedAndDeletedTaskListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    func fetchTasks() {
        let tasks = StorageManager.shared.fetchData()
        let dataStore = CompletedAndDeletedTaskDataStore(
            completedTasks: tasks.filter{ $0.status == .completed},
            deletedTasks: tasks.filter { $0.status == .deleted}
        )
        presenter.tasksDidReceive(with: dataStore)
        print(#function)
    }
    
    func repeatTask(_ task: ToDoTask) {
        StorageManager.shared.saveContext()
        fetchTasks()
        print(#function)
    }
    
}
