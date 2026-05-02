//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Андрей Грошев on 28.04.2026.
//

import UIKit

final class TrackersViewController: UIViewController {
    private let addTrackButton = UIButton(type: .custom)
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let errorImageView = UIImageView()
    private let whatTrackLabel = UILabel()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        configureView()
        configureAddTrackButton()
        configuredatePicker()
        configureTitleLabel()
        configureSearchBar()
        configureErrorImage()
        configureWhatTrackLabel()
        
        setupHierarchy()
        setupConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = DSColor.ypWhite
    }
    
    private func configureAddTrackButton() {
        let logoutImage = UIImage(resource: .buttonPlus)
        addTrackButton.setImage(logoutImage, for: .normal)
        addTrackButton.translatesAutoresizingMaskIntoConstraints = false
        addTrackButton.addTarget(self, action: #selector(didTapAddTrackButton), for: .touchUpInside)
        addTrackButton.accessibilityIdentifier = "AddTrackButton"
    }
    
    private func configuredatePicker() {
        let fontRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        dateLabel.backgroundColor = DSColor.ypLigtGray
        dateLabel.font = fontRegular
        dateLabel.textColor = DSColor.ypBlack
        dateLabel.textAlignment = .right
        dateLabel.layer.cornerRadius = 8
        dateLabel.layer.masksToBounds = true
        dateLabel.text = dateFormatter.string(from: Date())
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.alpha = 0.02
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    private func configureTitleLabel() {
        let fontBold = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        titleLabel.text = "Трекеры"
        titleLabel.font = fontBold
        titleLabel.textColor = DSColor.ypBlack
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureSearchBar() {
        let fontRegular = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        
        searchBar.searchTextField.textColor = DSColor.ypBlack
        searchBar.searchTextField.backgroundColor = DSColor.ypSearchBackGround
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [
                .foregroundColor: DSColor.ypGray,
                .font: fontRegular
            ]
        )
        searchBar.searchTextField.tintColor = DSColor.ypGray
        let searchIcon = UIImage(systemName: "magnifyingglass")?.withTintColor(DSColor.ypGray, renderingMode: .alwaysOriginal)
        searchBar.setImage(searchIcon, for: .search, state: .normal)
        searchBar.tintColor = DSColor.ypGray
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureErrorImage() {
        errorImageView.image = UIImage(resource: .errorLogo)
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWhatTrackLabel() {
        let fontMedium = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        whatTrackLabel.text = "Что будем отслеживать?"
        whatTrackLabel.font = fontMedium
        whatTrackLabel.textColor = DSColor.ypBlack
        whatTrackLabel.textAlignment = .center
        
        whatTrackLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        let subviews: [UIView] = [
            addTrackButton,
            dateLabel,
            datePicker,
            titleLabel,
            searchBar,
            errorImageView,
            whatTrackLabel
        ]
        
        view.addSubviews(subviews)
    }
    
    private func setupConstraints() {
        addTrackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        addTrackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6).isActive = true
        addTrackButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
        addTrackButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        dateLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: addTrackButton.centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        datePicker.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: addTrackButton.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: addTrackButton.bottomAnchor, constant: 1).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        errorImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        errorImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        whatTrackLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor).isActive = true
        whatTrackLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 8).isActive = true
        whatTrackLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
    
    @objc
    private func didTapAddTrackButton() {
        // TODO: реакция на нажатие
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
}
