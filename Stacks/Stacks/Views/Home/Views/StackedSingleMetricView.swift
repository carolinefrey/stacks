//
//  SingleAggregateStackView.swift
//  Stacks
//
//  Created by Caroline Frey on 8/2/25.
//

import UIKit

class StackedSingleMetricView: UIView {
    
    // MARK: Properties
    
    let metric: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let singleStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(metricFontSize: CGFloat, labelFontSize: CGFloat) {
        self.init(frame: .zero)
        metric.font = .systemFont(ofSize: metricFontSize, weight: .bold)
        statLabel.font = .systemFont(ofSize: labelFontSize)
    }
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        singleStackView.addArrangedSubview(metric)
        singleStackView.addArrangedSubview(statLabel)
        
        addSubview(singleStackView)
        
        NSLayoutConstraint.activate([
            singleStackView.topAnchor.constraint(equalTo: topAnchor),
            singleStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            singleStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            singleStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

