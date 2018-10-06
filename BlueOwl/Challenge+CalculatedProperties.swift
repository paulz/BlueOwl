import Foundation

extension Challenge {
    static let iSpyPhotos = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last!.appendingPathComponent("iSpyPhotos")

    var photoFilePath: String? {
        get {
            return photoHref.map{type(of: self).iSpyPhotos.appendingPathComponent($0).appendingPathExtension("jpg").path}
        }
    }

    func averageRating() -> Double {
        return ratings?.value(forKeyPath: "@avg.stars") as? Double ?? 0.0
    }

    func averageRoundedRating() -> Int {
        return Int(averageRating().rounded())
    }
}
