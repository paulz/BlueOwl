import CoreData

class DataStore {
    var container: NSPersistentContainer!

    func loadSampleData() {
        let bundleURL = Bundle.main.url(forResource: "SampleData", withExtension: "xcappdata")!
        let contentsURL = bundleURL.appendingPathComponent("AppData")
        let enumerator = FileManager.default.enumerator(at: contentsURL, includingPropertiesForKeys: [.isDirectoryKey], options: [], errorHandler: nil)!
        while let sourceUrl = enumerator.nextObject() as? URL {
            guard let resourceValues = try? sourceUrl.resourceValues(forKeys: [.isDirectoryKey]),
                let isDirectory = resourceValues.isDirectory,
                !isDirectory else { continue }
            let destinationRoot = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!.deletingLastPathComponent()
            let path = sourceUrl.standardizedFileURL.path.replacingOccurrences(of: contentsURL.standardizedFileURL.path, with: "")
            let destinationURL = destinationRoot.appendingPathComponent(path)
            try? FileManager.default.removeItem(at: destinationURL)


            do {
                try FileManager.default.createDirectory(at: destinationURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
                try FileManager.default.copyItem(at: sourceUrl, to: destinationURL)
            }
            catch {
                NSLog("Failed to setup data: \(error)")
            }
            NSLog("destinationURL: \(destinationURL)")
        }
    }

    public func openExistingDatabase() -> NSManagedObjectContext? {
        loadSampleData()
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
