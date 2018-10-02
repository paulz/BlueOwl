//
//  DataStore.swift
//  BlueOwl
//
//  Created by Paul Zabelin on 10/1/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

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
        }
        return container.viewContext
    }
}
