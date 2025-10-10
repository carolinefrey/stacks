//
//  StravaWorkoutService.swift
//  Stacks
//
//  Created by Caroline Frey on 10/1/25.
//

import Foundation

//final class StravaWorkoutService: WorkoutService {
//    private let strava: StravaService
//    private let refreshToken: String
//
//    init(refreshToken: String, strava: StravaService = StravaService()) {
//        self.refreshToken = refreshToken
//        self.strava = strava
//    }
//
//    func fetchWorkouts(forWeekOf weekOfYear: Int) async throws -> [Workout] {
//        // 1) Fetch raw activities
//        let accessToken = try await ensureAccessToken()
//        
//        let activities = try await strava.fetchActivities(accessToken: accessToken)
//        print("activities: \(activities)")
//        
//        // 2) Map to domain model
//        let workouts = activities.compactMap { mapActivityToWorkout($0) }
//        print("workouts: \(activities)")
//
//        // 3) Filter to requested ISO week
//        let calendar = Calendar(identifier: .iso8601)
//        return workouts.filter { calendar.component(.weekOfYear, from: $0.date) == weekOfYear }
//    }
//
//    func fetchWorkoutDetails(id: UUID) {
//        // Optional: call Strava detail endpoint and map
//    }
//
//    private func ensureAccessToken() async throws -> String {
//        // For now we are hardcoding and passing in a refresh token via initializer
//        // In the future, prefer secure storage (e.g., Keychain) and a TokenStore
//        return try await strava.refreshAccessToken(refreshToken: refreshToken)
//    }
//
//    private func mapActivityToWorkout(_ a: StravaService.Activity) -> Workout {
//        // Map Strava activity to app domain model with sensible defaults
//        let durationMinutes = Double(a.movingTime) / 60.0
//        let type = mapStravaType(a.type)
//        // Strava Activity in this project does not include start_date/HR/calories yet
//        return Workout(
//            title: a.name,
//            type: type,
//            date: Date(), // TODO: update when start_date is added to Activity
//            averageHR: 0,
//            duration: durationMinutes,
//            calories: 0
//        )
//    }
//
//    private func mapStravaType(_ stravaType: String) -> WorkoutType {
//        switch stravaType {
//        case "Run": return .run
//        case "Walk": return .walk
//        case "WeightTraining": return .strength
//        // Add additional mappings as needed
//        default: return .crossFit
//        }
//    }
//}
