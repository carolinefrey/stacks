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

private let stravaDayFormatter: DateFormatter = {
    let df = DateFormatter()
    df.calendar = Calendar(identifier: .iso8601)
    df.locale = Locale(identifier: "en_US_POSIX")
    df.timeZone = TimeZone(secondsFromGMT: 0)
    df.dateFormat = "yyyy-MM-dd"
    return df
}()

extension Date {
    /// Parses a Strava ISO 8601 start_date string (e.g., "2025-10-05T15:04:24Z")
    /// and returns a Date representing only the day (yyyy-MM-dd) in UTC.
    static func fromStravaDay(_ iso8601String: String?) -> Date? {
        guard let iso8601String = iso8601String,
              let dayComponent = iso8601String.split(separator: "T").first else {
            return nil
        }
        return stravaDayFormatter.date(from: String(dayComponent))
    }
}
