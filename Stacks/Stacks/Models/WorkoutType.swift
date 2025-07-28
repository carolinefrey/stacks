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
