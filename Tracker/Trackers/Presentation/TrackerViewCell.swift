//
//  TrackerViewCell.swift
//  Tracker
//
//  Created by Андрей Грошев on 12.05.2026.
//

import UIKit

final class TrackerViewCell: UICollectionViewCell {
    weak var delegate: TrackersViewControllerDelegate?
    
    static let identifier = "TrackerViewCell"
    
    // MARK: - UI
    
    private let cardView = UIView()
    private let emojiLabel = UILabel()
    private let titleLabel = UILabel()
    private let daysLabel = UILabel()
    private let completeButton = UIButton(type: .system)
    
    // MARK: - State
    
    private var isCompleted = false
    private var completedDays = 0
    private var trackerID: UUID?
    private var trackerDate: Date?
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configure() {
        contentView.backgroundColor = .clear
        
        configureCardView()
        configureEmojiLabel()
        configureTitleLabel()
        configureDaysLabel()
        configureCompleteButton()
        
        setupHierarchy()
        setupConstraints()
    }
    
    private func configureCardView() {
        cardView.backgroundColor = UIColor.systemGreen
        cardView.layer.cornerRadius = 16
        cardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureEmojiLabel() {
        emojiLabel.text = "😪"
        emojiLabel.font = .systemFont(ofSize: 16)
        emojiLabel.textAlignment = .center
        
        emojiLabel.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        emojiLabel.layer.cornerRadius = 12
        emojiLabel.layer.masksToBounds = true
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Поливать растения"
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDaysLabel() {
        daysLabel.font = .systemFont(ofSize: 12, weight: .medium)
        daysLabel.textColor = .black
        daysLabel.text = "0 дней"
        
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCompleteButton() {
        completeButton.backgroundColor = UIColor.systemGreen
        completeButton.tintColor = .white
        
        completeButton.layer.cornerRadius = 17
        
        completeButton.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        
        completeButton.addTarget(
            self,
            action: #selector(didTapCompleteButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Layout
    
    private func setupHierarchy() {
        contentView.addSubview(cardView)
        
        cardView.addSubview(emojiLabel)
        cardView.addSubview(titleLabel)
        
        contentView.addSubview(daysLabel)
        contentView.addSubview(completeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 90),
            
            emojiLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            emojiLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            
            daysLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            daysLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            
            completeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            completeButton.centerYAnchor.constraint(equalTo: daysLabel.centerYAnchor),
            completeButton.widthAnchor.constraint(equalToConstant: 34),
            completeButton.heightAnchor.constraint(equalToConstant: 34),
            
            contentView.bottomAnchor.constraint(
                greaterThanOrEqualTo: daysLabel.bottomAnchor
            )
        ])
    }
    
    // MARK: - Public
    
    func configure(
        id: UUID,
        selectedDate: Date,
        title: String,
        emoji: String,
        color: UIColor,
        days: Int,
        completed: Bool
    ) {
        trackerID = id
        trackerDate = selectedDate
        titleLabel.text = title
        emojiLabel.text = emoji
        
        completedDays = days
        isCompleted = completed
        cardView.backgroundColor = color
        completeButton.backgroundColor = color
        
        updateDaysLabel()
        updateButton()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCompleteButton() {
        isCompleted.toggle()
        guard let trackerID, let trackerDate else { return }
        if trackerDate.startOfDay > Date().startOfDay {
            return
        }
        
        if isCompleted {
            completedDays += 1
            delegate?.completeTracker(trackerID, on: trackerDate)
        } else {
            completedDays -= 1
            delegate?.uncompleteTracker(trackerID, on: trackerDate)
        }
        
        updateDaysLabel()
        updateButton()
    }
    
    // MARK: - Updates
    
    private func updateDaysLabel() {
        daysLabel.text = "\(completedDays) \(daysText(for: completedDays))"
    }
    
    private func updateButton() {
        if isCompleted {
            completeButton.setImage(
                UIImage(systemName: "checkmark"),
                for: .normal
            )
            
            completeButton.alpha = 0.3
        } else {
            completeButton.setImage(
                UIImage(systemName: "plus"),
                for: .normal
            )
            
            completeButton.alpha = 1
        }
    }
    
    private func daysText(for days: Int) -> String {
        switch days % 10 {
        case 1:
            return days % 100 == 11 ? "дней" : "день"
        case 2, 3, 4:
            return (12...14).contains(days % 100) ? "дней" : "дня"
        default:
            return "дней"
        }
    }
}
