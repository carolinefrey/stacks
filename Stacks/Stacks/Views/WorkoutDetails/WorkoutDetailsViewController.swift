//
//  WorkoutDetailsViewController.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class WorkoutDetailsViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: Properties
    private var contentView: WorkoutDetailsView!
    
    var workout: Workout

    // MARK: Initializers
    init(workout: Workout) {
        self.workout = workout
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor(hex: "#1f1f33")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        contentView = WorkoutDetailsView()
        view = contentView
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)

        fetchActivityDetails(for: workout) { [weak self] detailResults, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                if let detailResults = detailResults {
                    self.contentView.configureWorkoutDetailsView(with: detailResults)
                } else {
                    print("No results found")
                }
            }
        }
    }
    
    // MARK: Functions
    private func configureCollectionView() {
//        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }
}

//extension WorkoutDetailsViewController {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//}
