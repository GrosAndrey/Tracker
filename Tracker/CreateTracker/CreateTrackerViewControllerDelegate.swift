//
//  CreateTrackerViewControllerDelegate.swift
//  Tracker
//
//  Created by Андрей Грошев on 15.05.2026.
//

import Foundation

protocol CreateTrackerViewControllerDelegate: AnyObject {
    func didUpdateTracker(_ selectedDays: Set<Weekday>)
}
