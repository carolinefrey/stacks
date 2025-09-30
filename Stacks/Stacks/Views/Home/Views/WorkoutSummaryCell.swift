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
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    let firstStat: SingleStatView = {
        let stat = SingleStatView(metricFontSize: 18, labelFontSize: 16)
        stat.translatesAutoresizingMaskIntoConstraints = false
        return stat
    }()
    
    let secondStat: SingleStatView = {
        let stat = SingleStatView(metricFontSize: 18, labelFontSize: 16)
        stat.translatesAutoresizingMaskIntoConstraints = false
        return stat
    }()
    
    let thirdStat: SingleStatView = {
        let stat = SingleStatView(metricFontSize: 18, labelFontSize: 16)
        stat.translatesAutoresizingMaskIntoConstraints = false
        return stat
    }()
    
    let statsRow: UIStackView = {
        let row = UIStackView()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.alignment = .center
        return row
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
        icon.image = UIImage(systemName: workout.type.icon)
        
        firstStat.metric.text = formatDurationMetric(workout.duration)
        firstStat.statLabel.text = "time"
            
        secondStat.metric.text = String(workout.calories)
        secondStat.statLabel.text = "calories"
        
        thirdStat.metric.text = String(workout.averageHR)
        thirdStat.statLabel.text = "avg hr"
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(dayOfWeek)
        addSubview(title)
        addSubview(icon)
        
        statsRow.addArrangedSubview(firstStat)
        statsRow.addArrangedSubview(secondStat)
        statsRow.addArrangedSubview(thirdStat)
        
        addSubview(statsRow)
        
        NSLayoutConstraint.activate([
            dayOfWeek.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dayOfWeek.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayOfWeek.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            title.topAnchor.constraint(equalTo: dayOfWeek.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30),
            
            statsRow.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            statsRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            statsRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
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
