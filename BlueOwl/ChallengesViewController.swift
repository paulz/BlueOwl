import UIKit
import SwiftOwl
import CoreData

class ChallengesViewController: UIViewController {
    var context: NSManagedObjectContext!
    var fetchController: NSFetchedResultsController<Challenge>!
    @IBOutlet weak var tableView: UITableView!

    func createFetchController() {
        let fetchRequest: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "hint", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createFetchController()
        try? fetchController.performFetch()
    }
}

extension ChallengesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Challenge Cell", for: indexPath) as! ChallengeCell
        let challenge = fetchController.object(at: indexPath)
        cell.setChallenge(challenge)
        return cell
    }

}
