//
//  WeekSelectorView.swift
//  Stacks
//
//  Created by Caroline Frey on 7/28/25.
//

import UIKit

class WeekSelectorView: UIView {
    
    // MARK: Properties
    
    private let backButton: UIButton = {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        let image = UIImage(systemName: "arrow.left", withConfiguration: config)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .white
        return backButton
    }()
    
    private let forwardButton: UIButton = {
        let forwardButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
        let image = UIImage(systemName: "arrow.right", withConfiguration: config)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.setImage(image, for: .normal)
        forwardButton.tintColor = .white
        return forwardButton
    }()
    
    private let datePickerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.tintColor = .white
        picker.overrideUserInterfaceStyle = .dark //tricks view into rendering in dark mode
        
        picker.minimumDate = Date().fiveYearsAgo
        picker.maximumDate = Date().today
        return picker
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
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
    
    // MARK: - Functions
    
    // MARK: - UI Setup
    
    private func setUpViews() {
        datePickerContainer.addSubview(datePicker)
        
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(datePickerContainer)
        stackView.addArrangedSubview(forwardButton)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            datePicker.centerXAnchor.constraint(equalTo: datePickerContainer.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: datePickerContainer.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: datePickerContainer.bottomAnchor),
        ])
    }
}



