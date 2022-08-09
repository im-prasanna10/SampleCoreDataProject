//
//  Userr+CoreDataProperties.swift
//  myProject
//
//  Created by Prasanna on 13/08/21.
//  Copyright © 2021 sakthipriya. All rights reserved.
//
//

import Foundation
import CoreData


extension Userr {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Userr> {
        return NSFetchRequest<Userr>(entityName: "Userr")
    }

    @NSManaged public var age: String?
    @NSManaged public var gender: String?
    @NSManaged public var imagedata: Data?
    @NSManaged public var name: String?
    @NSManaged public var random: String?
    @NSManaged public var regNo: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
