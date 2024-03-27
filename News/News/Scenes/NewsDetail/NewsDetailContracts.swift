//
//  NewsDetailContracts.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation
import UIKit

protocol NewsDetailViewModelProtocol: AnyObject {
    var delegateVC: NewsDetailViewModelDelegate? { get set }
    var  model: [NewsDetailModel] { get set }
    var  sliderList: [NewsDetailModel] { get set }
    var  tableList: [NewsDetailModel] { get set }
    func load()
    
    func saveNews(selectedNews: NewsDetailModel, completionHandler: @escaping ((String) -> Void))
    func setButtons(selectedNews: NewsDetailModel, completionHandler: @escaping ((String) -> Void))
    func getImage(imgUrl: String, images: UIImageView)
    var timer: Timer? { get set }
    
    
}

enum NewsDetailCustomCellOutput {
    
    case updateButton(String)
    
}

protocol NewsDetailViewModelDelegate: AnyObject {
    
    func handleViewModelOutput(_ output: NewsDetailViewModelOutput)
    
}

enum NewsDetailViewModelOutput: Equatable {
    static func == (lhs: NewsDetailViewModelOutput, rhs: NewsDetailViewModelOutput) -> Bool {
        return true
    }
    
    case updateTitle(String)
    case setLoading(Bool)
    case showSliderList([NewsDetailModel])
    case showTableList([NewsDetailModel])
    
}
