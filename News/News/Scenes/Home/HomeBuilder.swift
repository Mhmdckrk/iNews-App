//
//  HomeBuilder.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation
import UIKit

final class HomeBuilder {

    static func make() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        var viewController = HomeViewController()
        if #available(iOS 13.0, *) {
            viewController = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        }
        viewController.viewModel = HomeViewModel(service: service)
        return viewController
    }

}
