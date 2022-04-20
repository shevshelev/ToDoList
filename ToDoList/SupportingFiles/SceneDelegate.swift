//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 13.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var storageManager: StorageManagerProtocol = StorageManager.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TaskListViewController())
//        window?.rootViewController = UINavigationController(rootViewController: NewTaskViewController())
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        storageManager.saveContext()
    }


}

