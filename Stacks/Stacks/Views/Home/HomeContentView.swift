//
//  HomeContentView.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class HomeContentView: UIView {
    // use AggregateStatsView, WeekSelectorView, etc. to build out the home dashboard here
    
    let aggregateStatsView: AggregateStatsView = {
        let view = AggregateStatsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setUpViews() {
        addSubview(aggregateStatsView)
        
        NSLayoutConstraint.activate([
            aggregateStatsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            aggregateStatsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aggregateStatsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            aggregateStatsView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

