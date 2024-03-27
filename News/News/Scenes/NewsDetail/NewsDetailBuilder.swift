//
//  NewsDetailBuilder.swift
//  News
//
//  Created by Mahmud CIKRIK on 19.02.2024.
//

import Foundation
import UIKit

final class NewsDetailBuilder {
    
    static func make(with viewModel: NewsDetailViewModelProtocol?) -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: "NewsDetail", bundle: nil)
        var viewController = NewsDetailViewController()
        if #available(iOS 13.0, *) {
            viewController = storyboard.instantiateViewController(identifier: "NewsDetailViewController") as! NewsDetailViewController
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController        }
        viewController.viewModel = viewModel
        return viewController
        
    }
    
}
