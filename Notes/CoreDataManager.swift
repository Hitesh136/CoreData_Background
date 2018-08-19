//
//  CoreDataManager.swift
//  Notes
//
//  Created by Hitesh  Agarwal on 8/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import CoreData

final class CoreDataManager {
 
    //MARK:- Properties
    static let shared = CoreDataManager(modalName: "Notes")
    private var modalName: String
    
    private(set) lazy var managesObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModal: NSManagedObjectModel = {
        guard let modalURL = Bundle.main.url(forResource: self.modalName, withExtension: "momd") else {
            fatalError("Data Modal file not found")
        }
        
        guard let managedObjectModal = NSManagedObjectModel(contentsOf: modalURL) else {
            fatalError("Can't create managed Object modal file form data modal")
        }
        
        return managedObjectModal
    }()
    
    private(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModal)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modalName).sqlite"
        
        let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentDirectoryURL.appendingPathComponent(storeName)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        }
        catch {
            fatalError("Can't connect persistent store to persistent store cordinator")
        }
        
        return persistentStoreCoordinator
    }()
    
    //MARK:- Initializers
    private init(modalName: String) {
        self.modalName = modalName
    }
    
    var applicationDocumentDirectory: String {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString
        
    }
}
