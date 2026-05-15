//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Андрей Грошев on 14.05.2026.
//

import UIKit

final class CreateTrackerViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let nameTextField = UITextField()
    private let optionsTableView = UITableView(frame: .zero, style: .plain)
    private let buttonsStackView = UIStackView()
    private let cancelButton = UIButton(type: .system)
    private let createButton = UIButton(type: .system)
    
    // MARK: - Properties
    private let options = ["Категория", "Расписание"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureTitleLabel()
        configureTextField()
        configureTableView()
        configureStackView()
        configureCancelButton()
        configureCreateButton()
        setupViews()
        
        setupHierarchy()
        setupConstraints()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Новая привычка"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = DSColor.ypBlack
        titleLabel.textAlignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextField() {
        nameTextField.placeholder = "Введите название трекера"
        nameTextField.backgroundColor = DSColor.ypBackgroundGray
        nameTextField.layer.cornerRadius = 16
        nameTextField.font = .systemFont(ofSize: 17, weight: .regular)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTableView() {
        optionsTableView.backgroundColor = DSColor.ypBackgroundGray
        optionsTableView.layer.cornerRadius = 16
        optionsTableView.isScrollEnabled = false
        optionsTableView.separatorStyle = .singleLine
        optionsTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureStackView() {
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCancelButton() {
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(DSColor.ypRed, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = DSColor.ypRed.cgColor
        cancelButton.layer.cornerRadius = 16
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCreateButton() {
        createButton.setTitle("Создать", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = DSColor.ypGray
        createButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        createButton.layer.cornerRadius = 16
        createButton.isEnabled = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(createButton)
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        let subviews: [UIView] = [
            titleLabel,
            nameTextField,
            optionsTableView,
            buttonsStackView
        ]
        
        view.addSubviews(subviews)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Заголовок экрана
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Текстовое поле ввода названия
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 75),
            
            // Таблица Категория / Расписание
            optionsTableView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            optionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            optionsTableView.heightAnchor.constraint(equalToConstant: 150), // 2 ячейки по 75pt
            
            // Контейнер нижних кнопок
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension CreateTrackerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        // Добавление шеврона (стрелочки справа)
        let disclosureImage = UIImageView(image: UIImage(systemName: "chevron.right"))
        disclosureImage.tintColor = UIColor(red: 0.68, green: 0.69, blue: 0.71, alpha: 1.0)
        cell.accessoryView = disclosureImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // TODO: Переход на экран выбора Категории
        } else {
            // TODO: Переход на экран настройки Расписания
        }
    }
}
