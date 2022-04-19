//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 13.04.2022.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class TaskListViewController: UITableViewController {
    typealias TaskListSectionModel = AnimatableSectionModel<String, ToDoTask>
    
    private let viewModel: TaskListViewModelProtocol = TaskListViewModel()
    private let bag = DisposeBag()
    
    private var dataSource = RxTableViewSectionedAnimatedDataSource<TaskListSectionModel>(configureCell: {_,tableView,_,task in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell()}
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        content.secondaryText = task.explanation
        cell.contentConfiguration = content
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        
        viewModel.taskList.asDriver()
            .map{
                print($0[0].title)
                return [TaskListSectionModel(model: "", items: $0)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func setupNavBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = nil
        tableView.dataSource = nil
    }
    
    
}

