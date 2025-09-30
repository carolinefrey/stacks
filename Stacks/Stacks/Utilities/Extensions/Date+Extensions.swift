//
//  Date+Extensions.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import Foundation

extension Date {
    var fiveYearsAgo: Date? {
        return Calendar.current.date(byAdding: .year, value: -5, to: Date())
    }
    
    var today: Date? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)
    }
    
    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Full day name (e.g., Monday)
        return formatter.string(from: self)
    }
    
    /// Returns the current ISO week number for today's date.
    /// Note: ISO week numbering can be 1...53 depending on the year.
    static func currentWeekOfYear() -> Int {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.component(.weekOfYear, from: Date())
    }
}
