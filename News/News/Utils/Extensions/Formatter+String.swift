//
//  Extensions.swift
//  News
//
//  Created by Mahmud CIKRIK on 4.03.2024.
//

import Foundation

extension String {
    
    func stringFormatter () -> String? {
            let words = self.components(separatedBy: CharacterSet.whitespaces)
            guard words.count >= 2 else {
                return self
            }
            
            let date = words[0]
            let time = words[1]
        
            let formatDate = date.components(separatedBy: "-")
            guard formatDate.count > 2 else {
                return self
            }
            
        
            let formatTime = time.components(separatedBy: ":")
            guard formatTime.count > 2 else {
                return self
            }
            
        return "\(formatTime[0]):\(formatTime[1]) \(formatDate[2])/\(formatDate[1])/\(formatDate[0])"
        }
            
}
