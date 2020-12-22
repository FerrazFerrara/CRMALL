//
//  Serie+CoreDataProperties.swift
//  
//
//  Created by Ferraz on 21/12/20.
//
//

import Foundation
import CoreData


extension Serie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Serie> {
        return NSFetchRequest<Serie>(entityName: "Serie")
    }

    @NSManaged public var gender: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32

}
