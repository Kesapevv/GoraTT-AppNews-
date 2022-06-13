//
//  SceneDelegate.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 11.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let viewController = MainScreenVC()
            let navViewController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navViewController
            self.window = window
            window.makeKeyAndVisible()
        }
        
    }
    
}

