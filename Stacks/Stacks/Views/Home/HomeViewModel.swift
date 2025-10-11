//
//  HomeViewModel.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import Foundation
import UIKit

final class HomeViewModel {
    func calculateWeeklyStats(for workouts:[Workout]) -> WeeklyStats {
        var totalDuration: Int = 0
        
        for workout in workouts {
            totalDuration += workout.duration
        }
        let durationString = formatDurationMetric(totalDuration)
        return WeeklyStats(workouts: workouts.count, totalDuration: durationString)
    }
}

