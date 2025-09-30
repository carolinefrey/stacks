//
//  Formatters.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import Foundation

/// Formats a duration in minutes into "hour:minute" (e.g., "1:05").
/// - Parameter minutes: The total duration in minutes.
/// - Returns: A string formatted as "H:MM".
func convertMinutesToHoursAndMinutes(_ minutes: Double) -> String {
    let totalMinutes = max(0, Int(minutes.rounded()))
    let hours = totalMinutes / 60
    let minutesPart = totalMinutes % 60
    return "\(hours):" + String(format: "%02d", minutesPart)
}
