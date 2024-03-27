//
//  SliderButton.swift
//  News
//
//  Created by Mahmud CIKRIK on 13.03.2024.
//

import UIKit

class SliderButton: UIButton {
        
        override var isSelected: Bool {
            didSet {
                updateButtonAppearance()
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        private func commonInit() {
            // İlk durumu burada ayarlayabilirsiniz
            updateButtonAppearance()
        }

        private func updateButtonAppearance() {
            if isSelected {
                backgroundColor = .black
                tintColor = .white
                setTitleColor(.white, for: .normal)
            } else {
                backgroundColor = .white
                tintColor = .black
                setTitleColor(.black, for: .normal)
            }

            layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 8
        }

}
