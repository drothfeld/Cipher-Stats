//
//  PlayerGameStat.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation
import FirebaseDatabase


// ==================================================
// Defines a TCG specific game statistic object to
// keep track of player statistics for a single TCG.
// ==================================================
struct PlayerGameStat {
    var overallWinRate: Double
    var totalGames: Int
    var totalLosses: Int
    var totalWins: Int
    let ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        overallWinRate = snapshotValue["overallWinRate"] as! Double
        totalGames = snapshotValue["totalGames"] as! Int
        totalLosses = snapshotValue["totalLosses"] as! Int
        totalWins = snapshotValue["totalWins"] as! Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "overallWinRate": overallWinRate,
            "totalGames": totalGames,
            "totalLosses": totalLosses,
            "totalWins": totalWins
        ]
    }
}
