//
//  HomeViewController.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: Properties
    private var contentView: HomeContentView!
    private let viewModel: HomeViewModel
    
    // MARK: Initializers
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(hex: "#1f1f33")
    }
    
    convenience init() {
        self.init(viewModel: HomeViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        contentView = HomeContentView()
        view = contentView
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        contentView.aggregateStatsView.configureAggregateStatsView(with: viewModel.fetchWeeklyStats())
    }
    
    // MARK: Functions
    
    private func configureCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //TODO: This should return MAX 7, but could be 1-7 depending on what day it is (ex: viewing on a Tuesday, should only be Monday & Tuesday's workout)
        
        return viewModel.workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutSummaryCell.workoutSummaryCollectionViewCellIdentifier, for: indexPath) as? WorkoutSummaryCell else {
                fatalError("Could not dequeue WorkoutSummaryCell")
            }
            
        let workout = viewModel.workouts[indexPath.item]
        cell.configure(with: workout)
        return cell
    }
}
