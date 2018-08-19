//
//  Person.swift
//  Notes
//
//  Created by Hitesh  Agarwal on 8/19/18.
//  Copyright © 2018 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import CoreData

class PersonModal {

    var firstName: String?
    var lastName: String?
    var location: String?
    
    init(firstName: String, lastName: String, location: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.location = location
    }
    
    func saveInDB(context: NSManagedObjectContext? ) -> Person? {
        
        let managedObjectContext = context ?? CoreDataManager.shared.managesObjectContext
        var person: Person
        if let tempPerson = self.getPerson(context: managedObjectContext) {
            person = tempPerson
        }
        else {
            person = Person(context: managedObjectContext)
        }
        
        person.firstName = self.firstName
        person.lastName = self.lastName
        person.location = self.location
        
        do {
            try context?.save()
            return person
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func getPerson(context: NSManagedObjectContext?) -> Person? {
        let managedObjectContext = context ?? CoreDataManager.shared.managesObjectContext
        
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        
        let predicate = NSPredicate(format: "firstName == %@ && lastName == %@ && location == %@", self.firstName ?? "", self.lastName ?? "", self.location ?? "")
        
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            return result.first
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getAllPersonInfo() -> [Person] {
        
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        do {
            let result = try CoreDataManager.shared.managesObjectContext.fetch(fetchRequest)
            return result
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}
