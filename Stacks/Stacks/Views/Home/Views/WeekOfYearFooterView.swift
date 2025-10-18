//
//  WeekOfYearFooterView.swift
//  Stacks
//
//  Created by Caroline Frey on 9/29/25.
//

import UIKit

final class WeekOfYearFooterView: UICollectionReusableView {
    static let reuseIdentifier = "WeekFooterView"
    
    private let weekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(weekLabel)
        
        NSLayoutConstraint.activate([
            weekLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            weekLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            weekLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            weekLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8)
        ])
    }
    
    func configure(text: String) {
        weekLabel.text = text
    }
}
