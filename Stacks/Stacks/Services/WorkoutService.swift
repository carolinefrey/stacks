//
//  WorkoutService.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation

protocol WorkoutService {
    func fetchWorkouts(forWeekOf: Int) -> [Workout]
    //  Eventually you'll want to make the above function async
    //    func fetchWorkouts(forWeekOf: Int) async throws -> [Workout]
    func fetchWorkoutDetails(id: UUID)
}
