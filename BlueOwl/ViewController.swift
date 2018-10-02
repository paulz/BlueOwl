import UIKit
import SwiftOwl
import CoreData

class ViewController: UIViewController {
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let challanges = try? context.fetch(Challange.fetchRequest()) {
            NSLog("challanges: \(challanges.count)")
        }
    }
}
