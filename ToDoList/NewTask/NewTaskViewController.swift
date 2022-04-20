//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by Shevshelev Lev on 14.04.2022.
//

import UIKit

class NewTaskViewController: UIViewController {
    
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
        textField.borderStyle = .roundedRect
        textField.delegate = self
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
    }
    
    private func addSubViews() {
        let subViews = [
            titleLabel, startLabel, endLabel, descriptionLabel,
            titleTF, startDP, endDP, descriptionTextView, saveButton
        ]
        subViews.forEach {
            view.addSubview($0)
        }
        startDP.addTarget(self, action: #selector(setStartDate), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        endDP.addTarget(self, action: #selector(setEndDate), for: .valueChanged)
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
        if titleTF.text != nil, !(titleTF.text?.isEmpty ?? false) {
            createNewTask()
            navigationController?.popViewController(animated: true)
        } else {
            showAlert(with: "Wrong name!", and: "Task needs name!")
        }
    }
    
    @objc private func setStartDate() {
        if startDP.date >= endDP.date {
            startDP.date = Date()
        }
    }
    
    @objc private func setEndDate() {
        if endDP.date <= startDP.date {
            endDP.date = Date()
        }
    }
    
    private func createNewTask() {
        let task = StorageManager.shared.createNewTask()
        task.title = titleTF.text ?? ""
        task.startDate = startDP.date
        task.endDate = endDP.date
        task.explanation = descriptionTextView.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

// - MARK: UITextFieldDelegate

extension NewTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// - MARK: AlertControllers

extension NewTaskViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok!", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
