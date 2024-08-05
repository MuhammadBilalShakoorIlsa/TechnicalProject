//
//  User+CoreDataProperties.swift
//  ProfileAssignment
//
//  Created by Muhammad Bilal Shakoor on 8/5/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var details: String?

}

extension User : Identifiable {

}
