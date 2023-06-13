//
//  GroupModel+CoreDataProperties.swift
//  futzin
//
//  Created by Kelven Galvao on 13/06/23.
//
//

import Foundation
import CoreData


extension GroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModel> {
        return NSFetchRequest<GroupModel>(entityName: "GroupModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var playersCountPerTeam: Int16
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for players
extension GroupModel {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: PlayerModel)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: PlayerModel)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension GroupModel : Identifiable {

}
