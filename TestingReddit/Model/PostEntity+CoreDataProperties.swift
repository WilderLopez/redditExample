//
//  PostEntity+CoreDataProperties.swift
//  
//
//  Created by Wilder López on 5/16/23.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var url: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var fullImageUrl: String?
    @NSManaged public var subredditNamePrefixed: String?
    @NSManaged public var created: Int64
    @NSManaged public var numComments: Int32
    @NSManaged public var name: String

}
