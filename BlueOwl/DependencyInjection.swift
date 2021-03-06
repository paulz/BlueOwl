import SwinjectStoryboard
import SwinjectAutoregistration
import SwiftOwl
import CoreData

extension SwinjectStoryboard {
    public static func setup() {
        defaultContainer.register(NSPersistentContainer.self) { _ in
            loadAppData(name: "SampleData")
            let container = NSPersistentContainer(name: "iSpyData")
            container.loadPersistentStores { (description: NSPersistentStoreDescription, error: Error?) in
                assert(error == nil)
                assert(description.shouldInferMappingModelAutomatically)
                assert(description.shouldMigrateStoreAutomatically)
                assert(!description.shouldAddStoreAsynchronously)
                assert(!description.isReadOnly)
                NSLog("persistent store path: \(description.url!.path)")
            }
            return container
        }.inObjectScope(.container)
        defaultContainer.register(NSManagedObjectContext.self) { r in
            return (r~>NSPersistentContainer.self).viewContext
        }
        defaultContainer.storyboardInitCompleted(ChallengesViewController.self) { r, c in
            c.context = r~>
            c.fetchData()
        }
    }
}
