import UIKit
import SwiftOwl
import CoreData

class ChallengesViewController: UIViewController {
    var context: NSManagedObjectContext!
    var fetchController: NSFetchedResultsController<Challenge>!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "hint", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)

        if let challenges = try? context.fetch(Challenge.fetchRequest()) {
            NSLog("challenges: \(challenges.count)")
        }
        if let users = try? context.fetch(User.fetchRequest()) {
            NSLog("users: \(users.count)")
        }
        try? fetchController.performFetch()
    }
}

extension ChallengesViewController: NSFetchedResultsControllerDelegate {

}

extension ChallengesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Challenge Cell", for: indexPath)
        let challenge = fetchController.object(at: indexPath)

        cell.textLabel?.text = challenge.hint
        cell.detailTextLabel?.text = challenge.creator?.email

        return cell
    }

}

extension ChallengesViewController: UITableViewDelegate {

}
