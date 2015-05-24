//
//  GeoImage.swift
//  Mapcation
//
//  Created by Lyndon Michael Bibera on 5/24/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import Foundation
import CoreData

class GeoImage: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var imageUrl: String

}
