//
//  Player.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation


// ==================================================
// Defines a player object that keeps track of TCG
// broad statistics.
// ==================================================
struct Player {
    var email: String
    var username: String
    var gameStats: [PlayerGameStat]
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
            "gameStats": gameStats,
        ]
    }
}
