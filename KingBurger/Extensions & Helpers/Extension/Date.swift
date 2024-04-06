//
//  Date.swift
//  KingBurger
//
//  Created by Maxwell Farias on 11/09/23.
//

import Foundation

extension Date {
    
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "en_US_POSIX")
        dt.dateFormat = dateFormat
        return dt.string(from: self)
    }
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
}
