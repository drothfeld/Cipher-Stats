//
//  CipherGame.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/14/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation
import FirebaseDatabase

// ==================================================
// Defines a record of a cipher game that contains
// the outcome of a single match.
// ==================================================
struct CipherGame: Equatable, Comparable {
    
    var battleRoyale: Bool
    var cardGame: String
    var date: Date
    var losingColor: String
    var losingDecksOrCharacterName: String
    var losingPlayer: String
    var playerOne: String
    var playerTwo: String
    var playerThree: String
    var playerFour: String
    var winningColor: String
    var winningDeckOrCharacterName: String
    var winningPlayer: String
    let ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        battleRoyale = snapshotValue["battleRoyale"] as! Bool
        cardGame = snapshotValue["cardGame"] as! String
        date = (snapshotValue["date"] as! String).toDate() ?? Date(timeIntervalSinceNow: 0)
        losingColor = snapshotValue["losingColors"] as! String
        losingDecksOrCharacterName = snapshotValue["losingDecksOrCharacterNames"] as! String
        losingPlayer = snapshotValue["losingPlayers"] as! String
        playerOne = snapshotValue["playerOne"] as! String
        playerTwo = snapshotValue["playerTwo"] as! String
        playerThree = snapshotValue["playerThree"] as! String
        playerFour = snapshotValue["playerFour"] as! String
        winningColor = snapshotValue["winningColor"] as! String
        winningDeckOrCharacterName = snapshotValue["winningDeckOrCharacterName"] as! String
        winningPlayer = snapshotValue["winningPlayer"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "battleRoyale": battleRoyale,
            "cardGame": cardGame,
            "date": date,
            "losingColor": losingColor,
            "losingDecksOrCharacterName": losingDecksOrCharacterName,
            "losingPlayer": losingPlayer,
            "playerOne": playerOne,
            "playerTwo": playerTwo,
            "playerThree": playerThree,
            "playerFour": playerFour,
            "winningColor": winningColor,
            "winningDeckOrCharacterName": winningDeckOrCharacterName,
            "winningPlayer": winningPlayer,
        ]
    }
    
    static func < (lhs: CipherGame, rhs: CipherGame) -> Bool { return lhs.date < rhs.date }
    static func == (lhs: CipherGame, rhs: CipherGame) -> Bool { return ((lhs.ref == rhs.ref)) }
}

// Converts a cipher game date string into a Swift Date object
extension String {
    func toDate(withFormat format: String = "MMddyyyy")-> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
