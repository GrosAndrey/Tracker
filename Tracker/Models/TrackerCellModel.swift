//
//  TrackerCellModel.swift
//  Tracker
//
//  Created by Андрей Грошев on 17.05.2026.
//

import UIKit

struct TrackerCellModel {
    let id: UUID
    let currentDay: Date
    let title: String
    let emoji: String
    let color: UIColor
    let days: Int
    let completed: Bool
}
