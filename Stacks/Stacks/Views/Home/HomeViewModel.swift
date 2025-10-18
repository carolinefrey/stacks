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
        var totalDistance: Double = 0
        
        for workout in workouts {
            totalDuration += workout.duration
            totalDistance += workout.distance ?? 0
        }
        
        let durationString = formatDurationMetric(totalDuration)
        let distanceString = formatDistanceMetric(fromMeters: totalDistance)
        return WeeklyStats(workouts: workouts.count, totalDuration: durationString, totalDistance: distanceString)
    }
}
