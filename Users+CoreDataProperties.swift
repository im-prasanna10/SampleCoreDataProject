//
//  Users+CoreDataProperties.swift
//  myProject
//
//  Created by Prasanna on 04/08/21.
//  Copyright © 2021 sakthipriya. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var imagedata: Data?
    @NSManaged public var name: String?
    @NSManaged public var random: String?
    @NSManaged public var regNo: String?

}
