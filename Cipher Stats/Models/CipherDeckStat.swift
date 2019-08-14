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
    var wins = 0
    var losses = 0
    var winrate = 0
    
    init(name: String) { self.name = name }
    
    mutating func calculateWinRate() {
        let result = Double(self.wins) / Double(self.losses)
        self.winrate = result.roundToPercentage(2)
    }
}
