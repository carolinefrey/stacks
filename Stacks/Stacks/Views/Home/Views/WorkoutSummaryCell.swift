//
//  WorkoutSummaryCell.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class WorkoutSummaryCell: UICollectionViewCell {
    
    static let workoutSummaryCollectionViewCellIdentifier = "WorkoutSummaryCollectionViewCell"
 
    // MARK: Properties

    let dayOfWeek: UILabel = {
        let day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.textColor = .white
        day.font = .systemFont(ofSize: 12, weight: .regular)
        return day
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = .systemFont(ofSize: 18, weight: .bold)
        return title
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        styleCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configure(with workout: Workout) {
        dayOfWeek.text = workout.date.dayOfWeek().uppercased()
        title.text = workout.title
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(dayOfWeek)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            dayOfWeek.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dayOfWeek.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayOfWeek.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            title.topAnchor.constraint(equalTo: dayOfWeek.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func styleCells() {
        backgroundColor = UIColor.white.withAlphaComponent(0.10)
        
        // Corner radius
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        // Border
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
    }
}
