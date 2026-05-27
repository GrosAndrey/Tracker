//
//  CreateTrackerViewControllerDelegate.swift
//  Tracker
//
//  Created by Андрей Грошев on 15.05.2026.
//

import UIKit

protocol CreateTrackerViewControllerDelegate: AnyObject {
    func didUpdateTracker(_ trackerName: String, _ categoryTitle: String, _ selectedDays: Set<Weekday>, _ emoji: String, _ color: UIColor)
}
