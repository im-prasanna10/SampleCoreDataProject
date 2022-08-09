//
//  User+CoreDataProperties.swift
//  myProject
//
//  Created by Prasanna on 04/08/21.
//  Copyright © 2021 sakthipriya. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var imagedata: Data?
    @NSManaged public var name: String?
    @NSManaged public var random: String?
    @NSManaged public var regNo: String?

}
