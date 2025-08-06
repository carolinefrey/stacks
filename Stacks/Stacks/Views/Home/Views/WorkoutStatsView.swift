//
//  WeeklyStatsView.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class WeeklyStatsView: UIView {
    
    // MARK: Properties
    
    let workoutsLabel: SingleStatView = {
        let workouts = SingleStatView(metricFontSize: 28, labelFontSize: 18)
        workouts.translatesAutoresizingMaskIntoConstraints = false
        return workouts
    }()
    
    let durationLabel: SingleStatView = {
        let duration = SingleStatView(metricFontSize: 28, labelFontSize: 18)
        duration.translatesAutoresizingMaskIntoConstraints = false
        return duration
    }()
    
    let caloriesLabel: SingleStatView = {
        let calories = SingleStatView(metricFontSize: 28, labelFontSize: 18)
        calories.translatesAutoresizingMaskIntoConstraints = false
        return calories
    }()
    
    private let metricsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        styleViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configureWeeklyStatsView(with stats: WeeklyStats) {
        workoutsLabel.metric.text = String(stats.workouts)
        workoutsLabel.statLabel.text = "workouts"
        
        durationLabel.metric.text = String(stats.totalDuration)
        durationLabel.statLabel.text = "time"

        caloriesLabel.metric.text = String(stats.totalCalories)
        caloriesLabel.statLabel.text = "calories"
        
        metricsStackView.addArrangedSubview(workoutsLabel)
        metricsStackView.addArrangedSubview(durationLabel)
        metricsStackView.addArrangedSubview(caloriesLabel)
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(metricsStackView)
        
        NSLayoutConstraint.activate([
            metricsStackView.topAnchor.constraint(equalTo: topAnchor),
            metricsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            metricsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            metricsStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func styleViews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.10)
        
        // Corner radius
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        // Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
    }
}

