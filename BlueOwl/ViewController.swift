import UIKit
import SwiftOwl
import CoreData

class ViewController: UIViewController {
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let challenges = try? context.fetch(Challenge.fetchRequest()) {
            NSLog("challenges: \(challenges.count)")
        }
        if let users = try? context.fetch(User.fetchRequest()) {
            NSLog("users: \(users.count)")
        }
    }
}
