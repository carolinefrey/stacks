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
func formatDurationMetric(_ seconds: Int) -> String {
    let totalSeconds = max(0, seconds)
    if totalSeconds < 3600 {
        // mm:ss for durations under an hour
        let minutes = totalSeconds / 60
        let secondsPart = totalSeconds % 60
        return String(format: "%d:%02d", minutes, secondsPart)
    } else {
        // hh:mm for durations an hour or more
        let hours = totalSeconds / 3600
        let minutesPart = (totalSeconds % 3600) / 60
        return String(format: "%d:%02d", hours, minutesPart)
    }
}
