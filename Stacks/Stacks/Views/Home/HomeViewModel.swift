//
//  HomeViewModel.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation
import UIKit

struct HomeViewModel {
    func fetchWeeklyStats() -> WeeklyStats {
        // dummy data
        return WeeklyStats(workouts: 6, totalDuration: 8, totalCalories: 3021)
    }
    
    private let workoutList: [Workout] = [
        Workout(title: "Morning Run", type: .run, date: Date(), duration: 52.5, calories: 620),
        Workout(title: "Evening Ride", type: .bike, date: Date().addingTimeInterval(-86400), duration: 90.0, calories: 840),
        Workout(title: "CrossFit", type: .crossFit, date: Date().addingTimeInterval(-172800), duration: 60.0, calories: 700),
        Workout(title: "Walk", type: .walk, date: Date().addingTimeInterval(-259200), duration: 45.0, calories: 250)
    ]

    var workouts: [Workout] {
        return workoutList
    }
}
