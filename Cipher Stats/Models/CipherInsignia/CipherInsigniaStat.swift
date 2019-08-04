//
//  CipherInsigniaStat.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/3/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import FirebaseDatabase

// ==================================================
// Defines an object that contains overall match
// statistics for a single CipherInsignia instance.
// ==================================================
struct CipherInsigniaStat {
    typealias InsigniaMatchup = (CipherInsignia, [Int])
    
    var cipherInsignia: CipherInsignia
    var insigniaMatchups = [InsigniaMatchup]()
    var totalGamesPlayed: Int
    var totalWins: Int
    var totalLosses: Int
    let ref: DatabaseReference?
    
    init(cipherInsignia: CipherInsignia, snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.cipherInsignia = cipherInsignia
        totalGamesPlayed = snapshotValue["totalGamesPlayed"] as! Int
        totalWins = snapshotValue["totalWins"] as! Int
        totalLosses = snapshotValue["totalLosses"] as! Int
        ref = snapshot.ref
        
        insigniaMatchups.append((CipherInsignia.blade_of_light, [snapshotValue["winsAgainstRed"] as! Int, snapshotValue["lossesAgainstRed"] as! Int, Int(snapshotValue["winRateAgainstRed"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.mark_of_naga, [snapshotValue["winsAgainstBlue"] as! Int, snapshotValue["lossesAgainstBlue"] as! Int, Int(snapshotValue["winRateAgainstBlue"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.hoshido, [snapshotValue["winsAgainstWhite"] as! Int, snapshotValue["lossesAgainstWhite"] as! Int, Int(snapshotValue["winRateAgainstWhite"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.nohr, [snapshotValue["winsAgainstBlack"] as! Int, snapshotValue["lossesAgainstBlack"] as! Int, Int(snapshotValue["winRateAgainstBlack"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.medallion, [snapshotValue["winsAgainstGreen"] as! Int, snapshotValue["lossesAgainstGreen"] as! Int, Int(snapshotValue["winRateAgainstGreen"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.divine_weapons, [snapshotValue["winsAgainstPurple"] as! Int, snapshotValue["lossesAgainstPurple"] as! Int, Int(snapshotValue["winRateAgainstPurple"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.holy_war_flag, [snapshotValue["winsAgainstYellow"] as! Int, snapshotValue["lossesAgainstYellow"] as! Int, Int(snapshotValue["winRateAgainstYellow"] as! String) ?? 0]))
        insigniaMatchups.append((CipherInsignia.colorless, [snapshotValue["winsAgainstColorless"] as! Int, snapshotValue["lossesAgainstColorless"] as! Int, Int(snapshotValue["winRateAgainstColorless"] as! String) ?? 0]))
    }
}

