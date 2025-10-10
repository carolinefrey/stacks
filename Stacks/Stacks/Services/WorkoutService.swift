//
//  WorkoutService.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation

protocol WorkoutService {
    func fetchWorkouts(forWeekOf weekOfYear: Int) async throws -> [Workout]
    func fetchWorkoutDetails(id: UUID)
}
