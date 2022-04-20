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
    }, canEditRowAtIndexPath: {_,_ in
        return true
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        
        
        tableView.rx.itemSelected.asDriver()
            .drive(onNext:{ indexPath in
                self.viewModel.editTask(from: indexPath, and: .completed)
            }).disposed(by: bag)
        
        tableView.rx.itemDeleted.asDriver()
            .drive(onNext: { indexPath in
                self.viewModel.editTask(from: indexPath, and: .deleted)
            }).disposed(by: bag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = nil
        tableView.dataSource = nil
        viewModel.taskList.asDriver()
            .map{
                return [TaskListSectionModel(model: "", items: $0)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel.fetchIncompleteTasks()
    }
    
    private func setupNavBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Completed/Deleted",
            style: .plain,
            target: self,
            action: #selector(showCompletedTasks)
        )
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = nil
        tableView.dataSource = nil
    }
    
    @objc private func addNewTask() {
        let newTaskVC = NewTaskViewController()
        navigationController?.pushViewController(newTaskVC, animated: true)
    }
    
    @objc private func showCompletedTasks() {
        let completedAndDeletedVC = CompletedAndDeletedTaskListViewController()
        let configurator = CompletedAndDeletedTaskListConfigurator()
        configurator.configure(with: completedAndDeletedVC)
        navigationController?.pushViewController(completedAndDeletedVC, animated: true)
    }
}

extension TaskListViewController {
    private func showAlert(with message: String, to task: ToDoTask) {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok!", style: .default) { _ in
            if message == "Remove this task?" {
                task.status = .deleted
            } else {
                task.status = .completed
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
}

