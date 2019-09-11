//
//  Date+Extension.swift
//  BanjoLocation-Unit-Dashboard-Dashboard-UnitTests
//
//  Created by Carlos Jimenez on 9/10/19.
//

import Foundation

extension Date {

    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: Date())
    }

}
