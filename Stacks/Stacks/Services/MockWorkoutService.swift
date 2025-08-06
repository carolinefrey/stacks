//
//  MockWorkoutService.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation

class MockWorkoutService: WorkoutService {
    func fetchWorkouts(forWeekOf: Int) {
        let workout1 = Workout(title: "Morning CrossFit", type: .crossFit, date: .now, averageHR: 150, duration: 60, calories: 250)
        let workout2 = Workout(title: "Morning CrossFit", type: .crossFit, date: .now, averageHR: 124, duration: 60, calories: 350)
        let workout3 = Workout(title: "Morning Walk", type: .walk, date: .now, averageHR: 100, duration: 60, calories: 264)
        let workout4 = Workout(title: "Morning Lift", type: .strength, date: .now, averageHR: 150, duration: 60, calories: 104)
        let workout5 = Workout(title: "Morning CrossFit", type: .crossFit, date: .now, averageHR: 143, duration: 75, calories: 478)
        let workout6 = Workout(title: "Morning Run", type: .run, date: .now, averageHR: 161, duration: 90, calories: 605)
        let workout7 = Workout(title: "Morning Weighted Walk", type: .weightVestWalk, date: .now, averageHR: 105, duration: 30, calories: 118)

    }
    
    func fetchWorkoutDetails(id: UUID) {
        let workout = Workout(title: "Morning CrossFit", type: .crossFit, date: .now, averageHR: 135, duration: 60, calories: 250)
        print("Fake workout details for id \(id): \(workout)")
    }
}
