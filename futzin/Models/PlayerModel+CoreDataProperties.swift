//
//  PlayerModel+CoreDataProperties.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//
//

import Foundation
import CoreData


extension PlayerModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerModel> {
        return NSFetchRequest<PlayerModel>(entityName: "PlayerModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var position: String?
    @NSManaged public var stars: Int16

}

extension PlayerModel : Identifiable {

}
