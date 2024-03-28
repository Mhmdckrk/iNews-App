//
//  SaveTableViewCell.swift
//  News
//
//  Created by Mahmud CIKRIK on 28.03.2024.
//

import UIKit

class SaveTableViewCell: UITableViewCell {

    static let identifier = "saveCell"
    
    static func nib() -> UINib {
    return UINib(nibName: "SaveCell", bundle: nil)
    
    }
    
    @IBOutlet var newsImage: UIImageView!
    
    @IBOutlet var newsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getImage(url: String) {
        let url = URL(string: url)
        self.newsImage.kf.setImage(with: url)
    }

}
