//
//  CompletedAndDeletedTaskListPresenter.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 20.04.2022.
//

import Foundation

struct CompletedAndDeletedTaskDataStore {
    let completedTasks: [ToDoTask]
    let deletedTasks: [ToDoTask]
}

class CompletedAndDeletedTaskListPresenter: CompletedAndDeletedTaskListOutputProtocol {
    
    internal var sections: [TaskSectionViewModel] = []
    unowned let view: CompletedAndDeletedTaskListInputProtocol
    var interactor: CompletedAndDeletedTaskListInteractorInputProtocol!
    
    required init(view: CompletedAndDeletedTaskListInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchTasks()
    }
    
    func repeatTask(at indexPath: IndexPath) {
        let task = sections[indexPath.section].rows[indexPath.row]
        task.status = .created
        interactor.repeatTask(task)
        print(#function)
    }
}

extension CompletedAndDeletedTaskListPresenter: CompletedAndDeletedTaskListInteractorOutputProtocol {
    func tasksDidReceive(with dataStore: CompletedAndDeletedTaskDataStore) {
        sections = []
        let completedSection = TaskSectionViewModel()
        let deletedSections = TaskSectionViewModel()
        completedSection.title = "Complited"
        completedSection.rows = dataStore.completedTasks
        deletedSections.title = "Deleted"
        deletedSections.rows = dataStore.deletedTasks
        sections.insert(completedSection, at: 0)
        sections.insert(deletedSections, at: 1)
    }
}
