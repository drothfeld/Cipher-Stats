//
//  CipherDeckStat.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/13/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation
import FirebaseDatabase

// ==================================================
// Defines the win/loss counts of a single
// cipher deck/lord/MC name (i.e. "Corrin (M)").
// ==================================================
struct CipherDeckStat {
    var name: String
    var opponent: String
    var wins = 0
    var losses = 0
    var winrate = 0
    var relevantCipherGames = [CipherGame]()
    
    
    init(name: String, opponent: String = "None") {
        self.name = name
        self.opponent = opponent
    }
    
    mutating func calculateWinRate() { if (self.wins + self.losses > 0) { self.winrate = (Double(self.wins) / (Double(self.wins) + Double(self.losses))).roundToPercentage(2) } }
    
    mutating func addWin() { self.wins += 1 }
    mutating func addLoss() { self.losses += 1 }
}
