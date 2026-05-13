//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Андрей Грошев on 28.04.2026.
//

import UIKit

final class TrackersViewController: UIViewController {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    private var trackers: [Tracker] = []
    private var categories: [TrackerCategory] = []
    private var completedTrackers: Set<TrackerRecord> = []
    
    private var currentDate = Date().startOfDay
    private var selectedDate: Date?
    private var params: GeometricParams = GeometricParams(cellCount: 2,
                                                          leftInset: 16,
                                                          rightInset: 16,
                                                          cellSpacing: 9)
    
    // MARK: - UI
    
    private let addTrackButton = UIButton(type: .custom)
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let errorImageView = UIImageView()
    private let whatTrackLabel = UILabel()
    private var trackerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 167, height: 148)
        let trackerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return trackerCollectionView
    }()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mockData()
        configure()
    }
    
    // MARK: - Configure
    
    private func configure() {
        configureView()
        configureAddTrackButton()
        configuredatePicker()
        configureTitleLabel()
        configureSearchBar()
        configureErrorImage()
        configureWhatTrackLabel()
        configureTrackerCollectionView()
        
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
        dateLabel.text = dateFormatter.string(from: currentDate)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.alpha = 0.02
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.tintColor = DSColor.ypBlack
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
    
    private func configureTrackerCollectionView() {
        trackerCollectionView.backgroundColor = DSColor.ypWhite
        
        trackerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        trackerCollectionView.register(TrackerViewCell.self, forCellWithReuseIdentifier: TrackerViewCell.identifier)
        
        trackerCollectionView.delegate = self
        trackerCollectionView.dataSource = self
    }
    
    // MARK: - Layout
    
    private func setupHierarchy() {
        let subviews: [UIView] = [
            addTrackButton,
            dateLabel,
            datePicker,
            titleLabel,
            searchBar,
            errorImageView,
            whatTrackLabel,
            trackerCollectionView
        ]
        
        view.addSubviews(subviews)
    }
    
    private func setupConstraints() {
        addTrackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 52).isActive = true
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
        
        trackerCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8).isActive = true
        trackerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackerCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func updateTrackersForDate(date: Date) {
        trackerCollectionView.reloadData()
    }
    
    func addTracker(_ tracker: Tracker, to categoryTitle: String) {
        categories = categories.map { category in
            if category.title == categoryTitle {
                return TrackerCategory(
                    title: category.title,
                    trackers: category.trackers + [tracker]
                )
            } else {
                return category
            }
        }
    }
    
    func addTrackerWithCategory(_ tracker: Tracker, categoryTitle: String) {
        if categories.contains(where: { $0.title == categoryTitle }) {
            addTracker(tracker, to: categoryTitle)
        } else {
            let newCategory = TrackerCategory(
                title: categoryTitle,
                trackers: [tracker]
            )
            categories = categories + [newCategory]
        }
    }
    
    func completedDaysCount(for id: UUID) -> Int {
        completedTrackers.filter { $0.trackerID == id }.count
    }
    
    func isTrackerCompleted(id: UUID, on date: Date) -> Bool {
        completedTrackers.contains {
            $0.trackerID == id &&
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddTrackButton() {
        // TODO: реакция на нажатие
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
        let normalizedDate = sender.date.startOfDay
        selectedDate = normalizedDate
        
        updateTrackersForDate(date: normalizedDate)
    }
}

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trackerCollectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerViewCell.identifier, for: indexPath) as? TrackerViewCell else {
            return UICollectionViewCell()
        }
        
        let tracker = trackers[indexPath.row]
        cell.delegate = self
        cell.configure(id: tracker.id,
                       selectedDate: selectedDate ?? currentDate,
                       title: tracker.name,
                       emoji: tracker.emoji,
                       color: tracker.color,
                       days: completedDaysCount(for: tracker.id),
                       completed: isTrackerCompleted(id: tracker.id, on: selectedDate ?? currentDate))
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    // Размеры ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth =  availableWidth / CGFloat(params.cellCount)
        return CGSize(width: cellWidth,
                      height: cellWidth * 2 / 3)
    }
    
    // Отступы от краев коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: params.leftInset, bottom: 10, right: params.rightInset)
    }
    
    // Расстояния между ячейками внутри коллекции - вертикальные отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return params.paddingWidth
    }
    
    // Расстояния между ячейками внутри коллекции - горизонтальные отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return params.cellSpacing
    }
}

// MARK: - TrackersViewControllerDelegate

extension TrackersViewController: TrackersViewControllerDelegate {
    func completeTracker(_ trackerID: UUID, on date: Date) {
        let record = TrackerRecord(trackerID: trackerID, date: date)
        completedTrackers.insert(record)
    }
    
    func uncompleteTracker(_ trackerID: UUID, on date: Date) {
        let record = TrackerRecord(trackerID: trackerID, date: date)
        completedTrackers.remove(record)
    }
}

// MARK: - Mok data

extension TrackersViewController {
    func mockData() {
        trackers.append(contentsOf: [
            Tracker(id: UUID(),
                    name: "Поливать растения",
                    color: DSColor.ypGreen,
                    emoji: "🌱",
                    schedule: [.monday, .friday])
        ])
    }
}
