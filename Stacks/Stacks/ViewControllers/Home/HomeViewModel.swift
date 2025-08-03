//
//  HomeViewModel.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//
import Foundation
import UIKit

struct HomeViewModel {
    func fetchWeeklyStats() -> WeeklyStats {
        // dummy data
        return WeeklyStats(workouts: 6, totalDuration: 8, totalCalories: 3021)
    }
}
