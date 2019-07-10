//
//  PlayerGameStat.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation


// ==================================================
// Defines a TCG specific game statistic object to
// keep track of player statistics for a single TCG.
// ==================================================
struct PlayerGameStat {
    var overallWinRate: Double
    var totalGames: Int
    var totalLosses: Int
    var totalWins: Int
    
    func toAnyObject() -> Any {
        return [
            "overallWinRate": overallWinRate,
            "totalGames": totalGames,
            "totalLosses": totalLosses,
            "totalWins": totalWins
        ]
    }
}
