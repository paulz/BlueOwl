//
//  Challenge+CalculatedProperties.swift
//  BlueOwl
//
//  Created by Paul Zabelin on 10/4/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

import Foundation

extension Challenge {
    func averageRating() -> Int {
        let setOfRatings = ratings?.allObjects as! [Rating]
        let stars = setOfRatings.compactMap { $0.stars?.intValue }
        let totalRatings = stars.reduce(0, +)
        let average = Double(totalRatings) / Double(stars.count)
        return Int(average.rounded())
    }
}
