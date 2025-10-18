//
//  Workout.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import Foundation

struct Workout {
    let id: Int
    let title: String
    let type: WorkoutType
    let date: Date
    let duration: Int
    let formattedDuration: String
    let averageHeartrate: Double
    let distance: Double?
    let formattedDistance: String?
}

struct WorkoutDetails: Codable {
    let name: String
    let calories: Double
    let averageHeartrate: Double
    let maxHeartrate: Double
}
