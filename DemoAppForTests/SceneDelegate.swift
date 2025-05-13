//
//  SceneDelegate.swift
//  DemoAppForTests
//
//  Created by Dmitriy Toropkin on 05.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create window with frame matching the screen size
        window = UIWindow(windowScene: windowScene)
        
        // Set ViewController as the root
        // Это плохая пратика, лучше использовать отдельную Assembly
        // Но чтобы упростить проект, оставлю это тут
        let coffeeService = CoffeeService()
        let presenter = CoffeeOrderPresenter(coffeeService: coffeeService)
        let viewController = CoffeeOrderViewController(presenter: presenter)
        presenter.view = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        
        // Make window visible
        window?.makeKeyAndVisible()
    }
}

