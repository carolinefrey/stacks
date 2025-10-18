//
//  WorkoutDetailsLayout.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class WorkoutDetailsView: UIView {
    
    private let headerView: WorkoutDetailsHeaderView = {
        let headerView = WorkoutDetailsHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = .zero

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MetricCell.self, forCellWithReuseIdentifier: MetricCell.metricCollectionViewCellIdentifier)
        collection.backgroundColor = UIColor(hex: "#1f1f33")
        return collection
    }()
    
//    private let avgHeartRateLabel: UILabel = {
//        let avgHrLabel = UILabel()
//        avgHrLabel.translatesAutoresizingMaskIntoConstraints = false
//        avgHrLabel.textColor = .white
//        avgHrLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        return avgHrLabel
//    }()
//    
//    private let maxHeartRateLabel: UILabel = {
//        let maxHeartRateLabel = UILabel()
//        maxHeartRateLabel.translatesAutoresizingMaskIntoConstraints = false
//        maxHeartRateLabel.textColor = .white
//        maxHeartRateLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        return maxHeartRateLabel
//    }()
//    
//    private let caloriesLabel: UILabel = {
//        let caloriesLabel = UILabel()
//        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
//        caloriesLabel.textColor = .white
//        caloriesLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        return caloriesLabel
//    }()
    
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
            layout.itemSize = CGSize(width: collectionView.bounds.width, height: 115)
        }
    }
    
    func configureWorkoutDetailsView(with details: WorkoutDetails) {
        headerView.titleLabel.text = details.name
//        avgHeartRateLabel.text = "Avg HR: \(String(details.averageHeartrate))"
//        maxHeartRateLabel.text = "Max HR: \(String(details.maxHeartrate))"
//        caloriesLabel.text = "Calories burned: \(String(details.calories))"
    }

    private func setUpViews() {
        addSubview(headerView)
//        addSubview(avgHeartRateLabel)
//        addSubview(maxHeartRateLabel)
//        addSubview(caloriesLabel)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
//            avgHeartRateLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
//            avgHeartRateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            avgHeartRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            
//            maxHeartRateLabel.topAnchor.constraint(equalTo: avgHeartRateLabel.bottomAnchor, constant: 20),
//            maxHeartRateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            maxHeartRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            
//            caloriesLabel.topAnchor.constraint(equalTo: maxHeartRateLabel.bottomAnchor, constant: 20),
//            caloriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}

