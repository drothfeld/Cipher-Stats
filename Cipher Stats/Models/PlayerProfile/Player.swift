//
//  Player.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation
import FirebaseDatabase

// ==================================================
// Defines a player object that keeps track of TCG
// broad statistics.
// ==================================================
struct Player: Equatable, Comparable {
    
    var email: String
    var username: String
    let ref: DatabaseReference?
    
    private init() {
        self.username = "None"
        self.email = ""
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        email = snapshotValue["email"] as! String
        username = snapshotValue["username"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "username": username,
        ]
    }
    
    static let noPlayer = Player()
    
    static func < (lhs: Player, rhs: Player) -> Bool { return lhs.username < rhs.username }
    static func == (lhs: Player, rhs: Player) -> Bool { return ((lhs.email == rhs.email) && (lhs.username == rhs.username)) }
}
