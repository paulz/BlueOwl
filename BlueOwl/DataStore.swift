import CoreData

class DataStore {
    var container: NSPersistentContainer!

    func loadAppData(name: String) {
        let bundleURL = Bundle.main.url(forResource: name, withExtension: "xcappdata")!
        let contentsURL = bundleURL.appendingPathComponent("AppData")
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: contentsURL,
                                                includingPropertiesForKeys: [.isDirectoryKey],
                                                options: [],
                                                errorHandler: nil)!
        let destinationRoot = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).last!.deletingLastPathComponent()
        let sourceRoot = contentsURL.standardizedFileURL.path
        while let sourceUrl = enumerator.nextObject() as? URL {
            guard let resourceValues = try? sourceUrl.resourceValues(forKeys: [.isDirectoryKey]),
                let isDirectory = resourceValues.isDirectory,
                !isDirectory else {
                    continue
            }
            let path = sourceUrl.standardizedFileURL.path.replacingOccurrences(of: sourceRoot, with: "")
            let destinationURL = destinationRoot.appendingPathComponent(path)
            try? fileManager.removeItem(at: destinationURL)
            try! fileManager.createDirectory(at: destinationURL.deletingLastPathComponent(),
                                             withIntermediateDirectories: true,
                                             attributes: nil)
            try! fileManager.copyItem(at: sourceUrl,
                                      to: destinationURL)
        }
    }

    public func openExistingDatabase() -> NSManagedObjectContext? {
        loadAppData(name: "SampleData")
        container = NSPersistentContainer(name: "iSpyData")
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
