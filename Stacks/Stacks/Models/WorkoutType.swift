//
//  WorkoutType.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

enum WorkoutType: String, CaseIterable {
    case strength
    case crossFit
    case run
    case walk
    case bike
    case swim
    case ski
    case yoga
    case hike
}

extension WorkoutType {
    var icon: String {
        switch self {
        case .strength: return "figure.strengthtraining.traditional"
        case .crossFit: return "figure.cross.training"
        case .run: return "figure.run"
        case .walk: return "figure.walk"
        case .bike: return "figure.outdoor.cycle"
        case .swim: return "figure.pool.swim"
        case .ski: return "figure.skiing.downhill"
        case .yoga: return "figure.yoga"
        case .hike: return "figure.hiking"
        }
    }
}

extension WorkoutType {
    init(stravaType: String) {
        switch stravaType {
        case "Run": self = .run
        case "Walk": self = .walk
        case "WeightTraining": self = .strength
        case "Workout": self = .crossFit
        case "Ride": self = .bike
        case "AlpineSki": self = .ski
        case "Yoga": self = .yoga
        case "Swim": self = .swim
        case "Hike": self = .hike
        default : self = .strength
        }
    }
}
