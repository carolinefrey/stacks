//
//  HomeViewModel.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation
import UIKit

struct HomeViewModel {
    private let workoutService: WorkoutService
    
    init(workoutService: WorkoutService = MockWorkoutService()) {
        self.workoutService = workoutService
    }
    
    var workouts: [Workout] {
        return workoutService.fetchWorkouts(forWeekOf: 1)
    }
    
    func fetchWeeklyStats() -> WeeklyStats {
        var durationMinutes: Double = 0.0
        var totalCals: Int = 0
        
        for workout in workouts {
            durationMinutes += workout.duration
            totalCals += workout.calories
        }
        
        let durationString = formatDurationMetric(durationMinutes)
        
        return WeeklyStats(workouts: workouts.count, totalDuration: durationString, totalCalories: totalCals)
    }
}
