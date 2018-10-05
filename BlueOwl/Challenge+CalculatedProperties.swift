import Foundation

extension Challenge {
    func averageRating() -> Double {
        return ratings?.value(forKeyPath: "@avg.stars") as? Double ?? 0.0
    }

    func averageRoundedRating() -> Int {
        return Int(averageRating().rounded())
    }
}
