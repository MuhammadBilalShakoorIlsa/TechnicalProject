//
//  DataHelper.swift
//  ProfileAssignment
//
//  Created by Muhammad Bilal Shakoor on 8/5/24.
//

import Foundation
import CoreData
import UIKit

class DataHelper {
    static var shared = DataHelper()
    
    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveData(objects: [String:String]){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        user.name = objects["name"]
        user.email = objects["email"]
        user.phone = objects["phone"]
        user.details = objects["details"]

        
        do {
            try context.save()
            print("Data is Saved.")
        } catch {
            print("Data is not saved.")
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchData() -> [User] {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Cannot fetch data: \(error)")
            return []
        }
    }
    
    func editData(objects: [String: String], userId: NSManagedObjectID) {
           do {
               let user = try context.existingObject(with: userId) as! User
               user.name = objects["name"]
               user.email = objects["email"]
               user.phone = objects["phone"]
               user.details = objects["details"]
               
               try context.save()
               print("Data is Edited.")
           } catch {
               print("Data not Edited.")
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
}

