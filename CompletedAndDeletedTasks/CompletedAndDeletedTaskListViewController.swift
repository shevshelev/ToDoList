//
//  CompletedAndDeletedTaskListViewController.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 20.04.2022.
//

import UIKit

protocol CompletedAndDeletedTaskListInputProtocol: AnyObject {

}

protocol CompletedAndDeletedTaskListOutputProtocol {
    init(view: CompletedAndDeletedTaskListInputProtocol)
    var sections: [TaskSectionViewModel] { get }
    func viewDidLoad()
    func repeatTask(at indexPath: IndexPath)
}

class CompletedAndDeletedTaskListViewController: UITableViewController {
    
    var presenter: CompletedAndDeletedTaskListOutputProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Completed/Deleted"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        presenter.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.sections.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = presenter.sections[indexPath.section].rows[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let repeatAction = UIContextualAction(style: .normal, title: "Repeat") {[unowned self] _, _, isDone in
            self.presenter.repeatTask(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        return UISwipeActionsConfiguration(actions: [repeatAction])
    }
}

extension CompletedAndDeletedTaskListViewController: CompletedAndDeletedTaskListInputProtocol {

}
