//
//  Utilities.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import Foundation

struct Utilities {
    
    // MARK: - Handy functions
    func getDate(_ dateString:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  TimeZone.init(identifier: "SG")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        var date = dateFormatter.date(from: dateString)
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = dateFormatter.date(from: dateString)
        }
        return date
    }
}
