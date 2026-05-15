//
//  Color.swift
//  Tracker
//
//  Created by Андрей Грошев on 28.04.2026.
//

import UIKit

enum DSColor {
    
    static var ypGreen: UIColor {
        guard let color = UIColor(named: "YP_green") else {
            assertionFailure("Color YP_green not found")
            return .systemGreen
        }
        return color
    }
    
    static var ypRed: UIColor {
        guard let color = UIColor(named: "YP_red") else {
            assertionFailure("Color YP_red not found")
            return .systemRed
        }
        return color
    }
    
    static var ypBlue: UIColor {
        guard let color = UIColor(named: "YP_blue") else {
            assertionFailure("Color YP_blue not found")
            return .blue
        }
        return color
    }
    
    static var ypWhite: UIColor {
        guard let color = UIColor(named: "YP_white") else {
            assertionFailure("Color YP_white not found")
            return .white
        }
        return color
    }
    
    static var ypBlack: UIColor {
        guard let color = UIColor(named: "YP_black") else {
            assertionFailure("Color YP_black not found")
            return .black
        }
        return color
    }
    
    static var ypGray: UIColor {
        guard let color = UIColor(named: "YP_gray") else {
            assertionFailure("Color YP_gray not found")
            return .gray
        }
        return color
    }
    
    static var ypSearchBackGround: UIColor {
        guard let color = UIColor(named: "YP_searchBackGround") else {
            assertionFailure("Color YP_searchBackGround not found")
            return .gray
        }
        return color
    }
    
    static var ypLigtGray: UIColor {
        guard let color = UIColor(named: "YP_ligtGray") else {
            assertionFailure("Color YP_ligtGray not found")
            return .lightGray
        }
        return color
    }
    
    static var ypBackgroundGray: UIColor {
        guard let color = UIColor(named: "YP_backgroundGray") else {
            assertionFailure("Color YP_backgroundGray not found")
            return .systemGray
        }
        return color
    }
    
}
