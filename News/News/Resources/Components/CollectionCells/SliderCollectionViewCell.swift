//
//  SliderCollectionViewCell.swift
//  News
//
//  Created by Mahmud CIKRIK on 23.02.2024.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    var viewModel: NewsDetailViewModelProtocol?
    var currentItem: NewsDetailModel?
    var currentIndex: Int?
    
    static let identifier = "customCell"
        
    @IBOutlet weak var images: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if currentIndex == 1 { self.configure(with: currentItem!) }
        viewModel?.saveNews(selectedNews: currentItem!, completionHandler: { string in
            sender.setTitle(string, for: .normal)
        })
    }
    
    
    deinit {
        print("Slider Cell deallocated")
    }
    
    
    static func nib() -> UINib {
    return UINib(nibName: "SliderCollectionViewCell", bundle: nil)
    
    }
    

    
    func configure(with model: NewsDetailModel) {
        currentItem = model
        guard let viewModel = viewModel else { return }
        viewModel.setButtons(selectedNews: currentItem!) { [weak self] string in
            self?.saveButton.setTitle(string, for: .normal)
        }
        viewModel.getImage(imgUrl: model.imgUrl, images: self.images)
    }
    
}
