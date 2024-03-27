//
//  Formatter+Date.swift
//  News
//
//  Created by Mahmud CIKRIK on 13.03.2024.
//

import Foundation

extension Date {

    func convertDate(currentFormat: String, toFormat: String) -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = currentFormat
            let dateString = dateFormatter.string(from: self)
            dateFormatter.dateFormat = toFormat
            return dateFormatter.date(from: dateString)
        }
}
