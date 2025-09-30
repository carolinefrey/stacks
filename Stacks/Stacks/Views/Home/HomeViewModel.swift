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
        // dummy data
        return WeeklyStats(workouts: 6, totalDuration: 8, totalCalories: 3021)
    }
}
