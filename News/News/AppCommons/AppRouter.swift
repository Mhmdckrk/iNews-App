//
//  AppRouter.swift
//  News
//
//  Created by Mahmud CIKRIK on 22.02.2024.
//

import Foundation
import UIKit

final class AppRouter {
    
    var window = UIWindow()

    @available(iOS 13.0, *)
    func start ( windowScene: UIWindowScene) {
            
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            
            let viewController = HomeBuilder.make()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.windowScene = windowScene
            window.rootViewController?.present(navigationController, animated: true)
            window.makeKeyAndVisible()
        }
        
    func start() {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            
            let viewController = HomeBuilder.make()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController?.present(navigationController, animated: true)
            window.makeKeyAndVisible()
            
        }
}
