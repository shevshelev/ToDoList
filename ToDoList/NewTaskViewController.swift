//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 14.04.2022.
//

import UIKit

class NewTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    private var task = StorageManager.shared.createNewTask()
    private lazy var titleLabel: UILabel = {
        createLabel(with: "Task title:")
    }()
    private lazy var startLabel: UILabel = {
        createLabel(with: "Start date:")
    }()
    private lazy var endLabel: UILabel = {
        createLabel(with: "End date:")
    }()
    private lazy var descriptionLabel: UILabel = {
        createLabel(with: "Description:")
    }()
    private lazy var titleTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter task title"
        textField.textAlignment = .right
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var startDP: UIDatePicker = {
       createDatePicker()
    }()
    private lazy var endDP: UIDatePicker = {
       createDatePicker()
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.delegate = self
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor(gray: 0.5, alpha: 0.3)
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        addSubViews()
        setupNavBar()
    }
    

    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navigationController?.navigationBar.bottomAnchor ?? view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 90),
            titleLabel.heightAnchor.constraint(equalToConstant: 21),
            
            startLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            startLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startLabel.widthAnchor.constraint(equalToConstant: 90),
            startLabel.heightAnchor.constraint(equalToConstant: 21),
            
            endLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 16),
            endLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            endLabel.widthAnchor.constraint(equalToConstant: 90),
            endLabel.heightAnchor.constraint(equalToConstant: 21),
            
            descriptionLabel.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 90),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 21),
            
            titleTF.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleTF.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            titleTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTF.heightAnchor.constraint(equalToConstant: 34),
            
            startDP.centerYAnchor.constraint(equalTo: startLabel.centerYAnchor),
            startDP.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            startDP.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startDP.heightAnchor.constraint(equalToConstant: 34),
            
            endDP.centerYAnchor.constraint(equalTo: endLabel.centerYAnchor),
            endDP.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            endDP.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            endDP.heightAnchor.constraint(equalToConstant: 34),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalTo: descriptionTextView.widthAnchor, multiplier: 0.5),
            
            saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            saveButton.heightAnchor.constraint(equalToConstant: 31)

        ])
    }
    
    private func setupNavBar() {
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        print(#function)
    }
    
    private func addSubViews() {
        let subViews = [
            titleLabel, startLabel, endLabel, descriptionLabel,
            titleTF, startDP, endDP, descriptionTextView, saveButton
        ]
        subViews.forEach {
            view.addSubview($0)
        }
    }
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    private func createDatePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        picker.date = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }
    
    @objc private func saveButtonPressed() {
        StorageManager.shared.saveContext()
        print("Save")
    }
    
    @objc private func setStartDate() {
        task.startDate = startDP.date
    }
}

