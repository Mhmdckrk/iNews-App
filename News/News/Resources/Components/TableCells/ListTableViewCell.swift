//
//  ListTableViewCell.swift
//  News
//
//  Created by Mahmud CIKRIK on 23.02.2024.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    
    static let identifier = "customCells"
    
    var viewModel: NewsDetailViewModelProtocol?
    var currentItem: NewsDetailModel?
 
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel?.saveNews(selectedNews: currentItem!, completionHandler: { string in
            sender.setTitle(string, for: .normal)
        })

    }
    
    deinit {
        print("List Cell deallocated")
    }

    static func nib() -> UINib {
    return UINib(nibName: "ListTableViewCell", bundle: nil)
    
    }
    
    func configure(with model: NewsDetailModel) {
        currentItem = model
        guard let viewModel = viewModel else { return }
        viewModel.setButtons(selectedNews: currentItem!) { [weak self] title in
            self?.saveButton.setTitle(title, for: .normal)
        }
        viewModel.getImage(imgUrl: model.imgUrl, images: self.images)
    }
    
}
