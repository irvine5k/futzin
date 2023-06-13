//
//  Route.swift
//  futzin
//
//  Created by Kelven Galvao on 11/06/23.
//

import Foundation

enum Route: Equatable, Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    case match(players: [Player], teamCount: Int)
    case group(group: GroupModel)
}

extension Route: Identifiable {
    var id: Int {
        switch self {
        case .match(_, _):
            return 0
        case .group(_):
            return 1
        }
    }
}


