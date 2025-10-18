//
//  MetricCell.swift
//  Stacks
//
//  Created by Caroline Frey on 10/13/25.
//

import UIKit

class MetricCell: UICollectionViewCell {
    
    static let metricCollectionViewCellIdentifier = "MetricCollectionViewCell"
 
    // MARK: Properties

    let metricTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .white
        title.font = .systemFont(ofSize: 12, weight: .regular)
        return title
    }()
    
    let metricValue: UILabel = {
        let metric = UILabel()
        metric.translatesAutoresizingMaskIntoConstraints = false
        metric.textColor = .white
        metric.font = .systemFont(ofSize: 18, weight: .bold)
        return metric
    }()
    
    let unitLabel: UILabel = {
        let unit = UILabel()
        unit.translatesAutoresizingMaskIntoConstraints = false
        unit.textColor = .white
        unit.font = .systemFont(ofSize: 18, weight: .bold)
        return unit
    }()
    
    let metricAndUnitStack: UIStackView = {
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
    
    func configure(with metric: String, value: String, unit: String) {
        metricTitle.text = metric
        metricValue.text = value
        unitLabel.text = unit
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(metricTitle)
        
        metricAndUnitStack.addArrangedSubview(metricValue)
        metricAndUnitStack.addArrangedSubview(unitLabel)
        
        addSubview(metricAndUnitStack)
        
        NSLayoutConstraint.activate([
            metricTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            metricTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            metricAndUnitStack.topAnchor.constraint(equalTo: metricTitle.bottomAnchor, constant: 10),
            metricAndUnitStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            metricAndUnitStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
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
