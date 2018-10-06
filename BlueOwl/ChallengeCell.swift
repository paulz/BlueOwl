import UIKit

public class ChallengeCell: UITableViewCell {
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!

    func setChallenge(_ challenge: Challenge) {
        hintLabel.text = challenge.hint
        ratingLabel.text = String(repeating: "★", count: challenge.averageRoundedRating())
        userNameLabel.text = "  by \(challenge.creator?.username ?? "Anonimous")"
        photoView.image = challenge.photoFilePath.flatMap {UIImage(contentsOfFile: $0)}
        winsLabel.text = challenge.matches.flatMap {"\($0.count) wins"} ?? ""
    }
}
