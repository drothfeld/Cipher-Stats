//
//  StatisticExtensions.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/25/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation


// Rounds a double to a specified digit count and returns as integer
extension Double {
    func roundToPercentage(_ fractionDigits: Int) -> Int {
        let multiplier = pow(10, Double(fractionDigits))
        let rounded = Darwin.round(self * multiplier) / multiplier
        return Int(rounded * 100)
    }
}
