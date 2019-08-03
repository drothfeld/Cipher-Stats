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
    
    init(color: String, snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        switch color {
            case "red": cipherInsignia = CipherInsignia.blade_of_light
            case "blue": cipherInsignia = CipherInsignia.mark_of_naga
            case "white": cipherInsignia = CipherInsignia.hoshido
            case "black": cipherInsignia = CipherInsignia.nohr
            case "green": cipherInsignia = CipherInsignia.medallion
            case "purple": cipherInsignia = CipherInsignia.divine_weapons
            case "yellow": cipherInsignia = CipherInsignia.holy_war_flag
            default: cipherInsignia = CipherInsignia.colorless
        }
        
        totalGamesPlayed = snapshotValue["totalGamesPlayed"] as! Int
        totalWins = snapshotValue["totalWins"] as! Int
        totalLosses = snapshotValue["totalLosses"] as! Int
        ref = snapshot.ref
        
        insigniaMatchups.append((CipherInsignia.blade_of_light, [snapshotValue["winsAgainstRed"] as! Int, snapshotValue["lossesAgainstRed"] as! Int, snapshotValue["winRateAgainstRed"] as! Int]))
        insigniaMatchups.append((CipherInsignia.mark_of_naga, [snapshotValue["winsAgainstBlue"] as! Int, snapshotValue["lossesAgainstBlue"] as! Int, snapshotValue["winRateAgainstBlue"] as! Int]))
        insigniaMatchups.append((CipherInsignia.hoshido, [snapshotValue["winsAgainstWhite"] as! Int, snapshotValue["lossesAgainstWhite"] as! Int, snapshotValue["winRateAgainstWhite"] as! Int]))
        insigniaMatchups.append((CipherInsignia.nohr, [snapshotValue["winsAgainstBlack"] as! Int, snapshotValue["lossesAgainstBlack"] as! Int, snapshotValue["winRateAgainstBlack"] as! Int]))
        insigniaMatchups.append((CipherInsignia.medallion, [snapshotValue["winsAgainstGreen"] as! Int, snapshotValue["lossesAgainstGreen"] as! Int, snapshotValue["winRateAgainstGreen"] as! Int]))
        insigniaMatchups.append((CipherInsignia.divine_weapons, [snapshotValue["winsAgainstPurple"] as! Int, snapshotValue["lossesAgainstPurple"] as! Int, snapshotValue["winRateAgainstPurple"] as! Int]))
        insigniaMatchups.append((CipherInsignia.holy_war_flag, [snapshotValue["winsAgainstYellow"] as! Int, snapshotValue["lossesAgainstYellow"] as! Int, snapshotValue["winRateAgainstYellow"] as! Int]))
        insigniaMatchups.append((CipherInsignia.colorless, [snapshotValue["winsAgainstColorless"] as! Int, snapshotValue["lossesAgainstColorless"] as! Int, snapshotValue["winRateAgainstColorless"] as! Int]))
    }
}

