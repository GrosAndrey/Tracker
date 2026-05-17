//
//  ScheduleViewControllerDelegate.swift
//  Tracker
//
//  Created by Андрей Грошев on 15.05.2026.
//

import Foundation

protocol ScheduleViewControllerDelegate: AnyObject {
    func didUpdateSchedule(_ selectedDays: Set<Weekday>)
}
