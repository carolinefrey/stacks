//
//  HeaderView.swift
//  Stacks
//
//  Created by Caroline Frey on 8/3/25.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stacks"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let weekSelector: WeekSelectorView = {
        let selector = WeekSelectorView()
        selector.translatesAutoresizingMaskIntoConstraints = false
        return selector
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        addSubview(titleLabel)
        addSubview(weekSelector)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            weekSelector.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            weekSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weekSelector.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            weekSelector.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}


