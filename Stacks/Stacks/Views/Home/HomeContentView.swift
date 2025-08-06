//
//  HomeContentView.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class HomeContentView: UIView {
    // use AggregateStatsView, WeekSelectorView, etc. to build out the home dashboard here
    
    private let headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    let weeklyStatsView: WeeklyStatsView = {
        let view = WeeklyStatsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = .zero

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(WorkoutSummaryCell.self, forCellWithReuseIdentifier: WorkoutSummaryCell.workoutSummaryCollectionViewCellIdentifier)
        collection.backgroundColor = UIColor(hex: "#1f1f33")
        return collection
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: collectionView.bounds.width, height: 100)
        }
    }
    
    private func setUpViews() {
        addSubview(headerView)
        addSubview(weeklyStatsView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            weeklyStatsView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            weeklyStatsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weeklyStatsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weeklyStatsView.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: weeklyStatsView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
}

