//
//  TaskSectionViewModel.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 20.04.2022.
//

import Foundation

protocol TaskSectionViewModelProtocol {
    var title: String? { get }
    var rows: [ToDoTask] { get }
}

class TaskSectionViewModel: TaskSectionViewModelProtocol {
    var title: String?
    var rows: [ToDoTask] = []
}
