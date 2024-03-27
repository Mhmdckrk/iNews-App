//
//  ButtonsCell.swift
//  News
//
//  Created by Mahmud CIKRIK on 4.03.2024.
//

import UIKit

class ButtonsCell: UICollectionViewCell {
    
    
    static let identifier = "SliderButtonCell"
    
    static func nib() -> UINib {
    
    return UINib(nibName: "ButtonsCell", bundle: nil)
    
    }
    
    var viewModel: HomeViewModelProtocol?

    @IBOutlet var sliderButtons: UIButton!
    
    @IBAction func sliderButtonTapped(_ sender: UIButton) {
        
        sliderButtons.isSelected.toggle()
        
        guard let viewModel = viewModel else { return }
        
        guard let category = sender.titleLabel?.text else { return }
        
        if !viewModel.selectedCategories.isEmpty {
            if viewModel.selectedCategories.count == viewModel.fetchedCategories.count {
                if sender.isSelected {
                    viewModel.selectedCategories = viewModel.selectedCategories.filter { $0 == category }
                } else {
                    viewModel.selectedCategories.removeAll { $0 == category }
                }
            } else {
                if viewModel.selectedCategories.contains(category) {
                    viewModel.selectedCategories.removeAll { $0 == category }
                    if viewModel.selectedCategories.isEmpty {
                        viewModel.selectedCategories = viewModel.fetchedCategories
                    }
                } else {
                    viewModel.selectedCategories.append(category)
                }
            }
        }
        else {
            viewModel.selectedCategories = viewModel.fetchedCategories
        }
        
        viewModel.filterData(categories: viewModel.selectedCategories)
        setSliderButton(item: viewModel.selectedCategories)
        
    }
    
    func configure(model: HomeViewModelProtocol) {
        self.viewModel = model
        guard let viewModel = viewModel else { return }
        print(viewModel.selectedCategories)
        setSliderButton(item: viewModel.selectedCategories)
        
    }
    
    func setSliderButton(item: [String]) {
        if  sliderButtons.isSelected && !item.contains((sliderButtons.titleLabel?.text!)!) {
            sliderButtons.isSelected = false
        } else if item.count != 7 && item.contains((sliderButtons.titleLabel?.text!)!) {
            sliderButtons.isSelected = true
        } else if item.count == 7 && !sliderButtons.isSelected {
            sliderButtons.isSelected = false
        }
    }
    
}
