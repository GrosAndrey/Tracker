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

extension Calendar {
    func getWeekday(from date: Date) -> Weekday? {
        let appleWeekday = self.component(.weekday, from: date)
        let number = appleWeekday == 1 ? 7 : appleWeekday - 1
        return Weekday(rawValue: number)
    }
}
