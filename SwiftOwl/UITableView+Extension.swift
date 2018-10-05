import UIKit

extension UITableViewCell {
    @objc public static var defaultReuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}

public extension UITableView {
    func cell<T>(for indexPath: IndexPath) -> T where T:UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
}
