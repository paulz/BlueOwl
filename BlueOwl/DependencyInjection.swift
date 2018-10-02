import SwinjectStoryboard
import SwiftOwl
import CoreData

extension SwinjectStoryboard {
    public static func setup() {
        defaultContainer.register(NSManagedObjectContext.self) { _ in
            return DataStore().openExistingDatabase()!
        }.inObjectScope(.container)
        defaultContainer.storyboardInitCompleted(ChallengesViewController.self) { r, c in
            c.context = r.resolve(NSManagedObjectContext.self)
        }
    }
}
