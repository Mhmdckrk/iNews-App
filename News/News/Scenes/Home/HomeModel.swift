//
//  HomePresentation.swift
//  News
//
//  Created by Mahmud CIKRIK on 18.02.2024.
//

import Foundation

struct HomeModel {
    let title: String
    let detail: String
}

extension HomeModel {

    init(model: Source) {
        self.init(title: model.name ?? "Source Name",
                  detail: model.description ?? "Source Desc")

    }

}


