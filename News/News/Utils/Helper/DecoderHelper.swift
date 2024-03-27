//
//  Helper.swift
//  News
//
//  Created by Mahmud CIKRIK on 24.02.2024.
//

import Foundation

public enum Decoders {
    
    public static let plainDateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
// possible date strings: "2016-05-01",  "2016-07-04T17:37:21.119229Z", "2018-05-20T15:00:00Z"
                    let len = dateStr.count
                    var date: Date? = nil
                    if len == 10 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        date = dateFormatter.date(from:dateStr)
                    } else if len >= 20 && len <= 25 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        date = dateFormatter.date(from:dateStr)
                    } else {
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSZ"
                        date = dateFormatter.date(from:dateStr)
                    }
                    guard let date = date else {
                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
                    }
                    print("DATE DECODER \(dateStr) to \(date)")
                    return date
        })

        return decoder
    }()
    
}
