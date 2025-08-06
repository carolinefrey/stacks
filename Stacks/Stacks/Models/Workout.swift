//
//  Workout.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import Foundation

struct Workout {
    let id: UUID = UUID()
    let title: String
    let type: WorkoutType
    let date: Date // format
    let averageHR: Int
    let duration: Double // will probably want to format depending on how Strava sends this through. Ex: 1h 25min
    let calories: Int
    
    //TODO: add workout-specific values like distance and pace
}
