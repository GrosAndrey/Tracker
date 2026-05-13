//
//  TrackersViewControllerDelegate.swift
//  Tracker
//
//  Created by Андрей Грошев on 13.05.2026.
//

import Foundation

protocol TrackersViewControllerDelegate: AnyObject {
    func completeTracker(_ trackerID: UUID, on date: Date)
    func uncompleteTracker(_ trackerID: UUID, on date: Date)
}
