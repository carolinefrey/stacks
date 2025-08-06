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
    case weightVestWalk
    case bike
    case mountainBike
    case swim
    case pickleBall
    case tennis
}

extension WorkoutType {
    var displayName: String {
        switch self {
        case .strength: return "Strength"
        case .crossFit: return "CrossFit"
        case .run: return "Run"
        case .walk: return "Walk"
        case .weightVestWalk: return "Weight Vest Walk"
        case .bike: return "Bike"
        case .mountainBike: return "Mountain bike"
        case .swim: return "Swim"
        case .pickleBall: return "Pickleball"
        case .tennis: return "Tennis"
        }
    }
}

extension WorkoutType {
    var icon: String {
        switch self {
        case .strength: return "figure.strengthtraining.traditional"
        case .crossFit: return "figure.cross.training"
        case .run: return "figure.run"
        case .walk: return "figure.walk"
        case .weightVestWalk: return "figure.walk"
        case .bike: return "figure.outdoor.cycle"
        case .mountainBike: return "figure.outdoor.cycle"
        case .swim: return "figure.pool.swim"
        case .pickleBall: return "figure.pickleball"
        case .tennis: return "figure.tennis"
        }
    }
}
