//
//  ChallengeCell.swift
//  BlueOwl
//
//  Created by Paul Zabelin on 10/2/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

import UIKit

public class ChallengeCell: UITableViewCell {
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var hintLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var winsLabel: UILabel!

    
    func setChallenge(_ challenge: Challenge) {
        hintLabel.text = challenge.hint
        ratingLabel.text = String(repeating: "★", count: challenge.averageRating())
        userNameLabel.text = challenge.creator?.username
    }
}
