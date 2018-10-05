import UIKit
import SwiftOwl
import CoreData

class ChallengesViewController: UIViewController {
    var context: NSManagedObjectContext!
    var fetchController: NSFetchedResultsController<Challenge>!
    @IBOutlet weak var tableView: UITableView!

    func fetchData() {
        let fetchRequest: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "hint", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
        try? fetchController.performFetch()
    }
}

extension ChallengesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.fetchedObjects!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChallengeCell = tableView.cell(for: indexPath)
        cell.setChallenge(fetchController.object(at: indexPath))
        return cell
    }
}

