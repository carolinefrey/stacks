//
//  HomeViewController.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Properties
    private var contentView: HomeContentView!
    private let viewModel: HomeViewModel
    
    var workoutsResults: [Workout] = []
    
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

        fetchActivitiesWithAutoRefresh(
            storedRefreshToken: Secrets.stravaRefreshToken,
            storedAccessToken: Secrets.stravaAccessToken,
            storedExpiresAt: Secrets.stravaExpiresAt
        ) { [weak self] activityResults, error in
            guard let self = self else { return }

            if let error = error {
                print("Error: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                if let activityResults = activityResults, !activityResults.isEmpty {
                    self.workoutsResults = activityResults
                    self.contentView.weeklyStatsView.configureWeeklyStatsView(
                        with: self.viewModel.calculateWeeklyStats(for: activityResults)
                    )
                    self.contentView.collectionView.reloadData()
                } else {
                    print("No results found")
                }
            }
        }
    }
    
    // MARK: Functions
    private func configureCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutsResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutSummaryCell.workoutSummaryCollectionViewCellIdentifier, for: indexPath) as? WorkoutSummaryCell else {
                fatalError("Could not dequeue WorkoutSummaryCell")
            }
            
        let workout = workoutsResults[indexPath.item]
        cell.configure(with: workout)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WeekOfYearFooterView.reuseIdentifier, for: indexPath) as! WeekOfYearFooterView
        footer.configure(text: "Week " + String(Date.currentWeekOfYear()))
        return footer
    }
}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Safely get the selected workout
        guard indexPath.item < workoutsResults.count else { return }
        let workout = workoutsResults[indexPath.item]

        // Initialize and push the detail view
        // Assumes WorkoutDetailView is a UIViewController that can be initialized with a Workout
        let detailVC = WorkoutDetailsViewController(workout: workout)
        navigationController?.pushViewController(detailVC, animated: true)

        // Deselect the tapped cell for visual feedback
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}

