//
//  StringExtensions.swift
//  Tracker
//
//  Created by Андрей Грошев on 17.05.2026.
//

import Foundation

extension Int {
    var localizedDaysText: String {
        switch self % 10 {
        case 1:
            return self % 100 == 11 ? "дней" : "день"
        case 2, 3, 4:
            return (12...14).contains(self % 100) ? "дней" : "дня"
        default:
            return "дней"
        }
    }
}
