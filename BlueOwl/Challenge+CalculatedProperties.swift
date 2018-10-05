//
//  Challenge+CalculatedProperties.swift
//  BlueOwl
//
//  Created by Paul Zabelin on 10/4/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

import Foundation

extension Challenge {
    func averageRating() -> Double {
        return ratings?.value(forKeyPath: "@avg.stars") as? Double ?? 0.0
    }

    func averageRoundedRating() -> Int {
        return Int(averageRating().rounded())
    }
}
