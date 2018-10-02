import CoreData

class DataStore {
    var container: NSPersistentContainer!

    public func openExistingDatabase() -> NSManagedObjectContext? {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (description: NSPersistentStoreDescription, error: Error?) in
            assert(error == nil, "failed to create persistant store due to: \(error!)")
            assert(description.shouldInferMappingModelAutomatically)
            assert(description.shouldMigrateStoreAutomatically)
            assert(!description.shouldAddStoreAsynchronously)
            assert(!description.isReadOnly)
            NSLog("persistent store path: \(description.url!.path)")
        }
        return container.viewContext
    }
}
