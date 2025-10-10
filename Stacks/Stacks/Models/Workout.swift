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
    let date: Date
    let duration: Int
}
