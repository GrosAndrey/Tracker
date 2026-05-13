//
//  DateExtensions.swift
//  Tracker
//
//  Created by Андрей Грошев on 13.05.2026.
//

import Foundation

extension Date {
    var startOfDay: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        return calendar.startOfDay(for: self)
    }
}
