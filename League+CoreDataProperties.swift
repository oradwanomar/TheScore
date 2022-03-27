//
//  League+CoreDataProperties.swift
//  
//
//  Created by Omar Ahmed on 02/03/2022.
//
//

import Foundation
import CoreData


extension League {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<League> {
        return NSFetchRequest<League>(entityName: "League")
    }

    @NSManaged public var idLeague: String?
    @NSManaged public var strBadge: String?
    @NSManaged public var strLeague: String?
    @NSManaged public var strYoutube: String?

}
