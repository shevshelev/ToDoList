//
//  CompletedAndDeletedTaskListConfigurator.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 20.04.2022.
//

import Foundation

protocol CompletedAndDeletedTaskListConfiguratorInputProtocol {
    func configure(with viewController: CompletedAndDeletedTaskListViewController)
}

class CompletedAndDeletedTaskListConfigurator: CompletedAndDeletedTaskListConfiguratorInputProtocol {
    func configure(with viewController: CompletedAndDeletedTaskListViewController) {
        let presenter = CompletedAndDeletedTaskListPresenter(view: viewController)
        let interactor = CompletedAndDeletedTaskListInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
