//
//  FirebaseService.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/10/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation
import Firebase


// ==================================================
// Singleton service to manage Firebase API calls
// ==================================================
class FirebaseService {
    static let shared = FirebaseService()
    private init(){}
    
    //
    // GET: Retrieve all TCG-Portal player profiles
    //
    func getPlayerProfiles(completion: @escaping (Result<[Player], Error>) -> Void) {
        let ref = Database.database().reference(withPath: "users/")
        ref.observe(.value, with: { snapshot in
            var playerProfiles = [Player]()
            
            // Build new player profile list from data snapshot
            for item in snapshot.children {
                let playerProfile = Player(snapshot: item as! DataSnapshot)
                playerProfiles.append(playerProfile)
            }
            
            // Return the list of player profiles
            playerProfiles.sort(by: <)
            DispatchQueue.main.async { completion(.success(playerProfiles)) }
        
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Retrieve overall cipher game stats for a single player
    //
    func getPlayerStats(ref: DatabaseReference, completion: @escaping (Result<PlayerGameStat, Error>) -> Void) {
        ref.child("playerStats/fireEmblemCipher").observeSingleEvent(of: .value, with: { (snapshot) in
            let playerStats = PlayerGameStat(snapshot: snapshot)
            
            // Return the player game stats
            DispatchQueue.main.async { completion(.success(playerStats)) }
            
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Retrieves all recorded cipher game matches
    //
    func getCipherGameMatches(completion: @escaping (Result<[CipherGame], Error>) -> Void) {
        let ref = Database.database().reference(withPath: "recorded-games")
        ref.observe(.value, with: { snapshot in
            var cipherMatches = [CipherGame]()
            
            // Build recorded cipher game match list
            for item in snapshot.children {
                let cipherGame = CipherGame(snapshot: item as! DataSnapshot)
                cipherMatches.append(cipherGame)
            }
            
            // Return the list of recorded cipher game matches sorted by date
            cipherMatches = cipherMatches.sorted { $0.date > $1.date }
            DispatchQueue.main.async { completion(.success(cipherMatches)) }
            
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Returns a CipherDeckStat object that contains win/loss
    //      data for a given lord/MC deck name (i.e. "Corrin (M)")
    //
    func getCipherDeckStats(deckName: String, completion: @escaping (Result<CipherDeckStat, Error>) -> Void) {
        let ref = Database.database().reference(withPath: "recorded-games")
        ref.observe(.value, with: { snapshot in
            var cipherDeckStats = CipherDeckStat(name: deckName)
            
            // Go through all retrieved cipher game matches and count
            // the wins/losses for the given deck/lord/MC name
            for item in snapshot.children {
                let cipherGame = CipherGame(snapshot: item as! DataSnapshot)
                if cipherGame.winningDeckOrCharacterName == cipherDeckStats.name { cipherDeckStats.addWin(); cipherDeckStats.relevantCipherGames.append(cipherGame) }
                else if cipherGame.losingDecksOrCharacterName == cipherDeckStats.name { cipherDeckStats.addLoss(); cipherDeckStats.relevantCipherGames.append(cipherGame) }
            }
            
            // Calculate winrate and return CipherDeckStat object
            cipherDeckStats.calculateWinRate()
            DispatchQueue.main.async { completion(.success(cipherDeckStats)) }
            
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Returns a CipherDeckStat object that contains win/loss
    //      data when comparing one decks performance against another
    //
    func getDeckMatchupStats(deckNameA: String, deckNameB: String, completion: @escaping (Result<CipherDeckStat, Error>) -> Void) {
        let ref = Database.database().reference(withPath: "recorded-games")
        ref.observe(.value, with: { snapshot in
            var cipherDeckStats = CipherDeckStat(name: deckNameA, opponent: deckNameB)
            
            // Go through all retrieved cipher game matches and count
            // the wins/losses for deckNameA's performance against deckNameB
            for item in snapshot.children {
                let cipherGame = CipherGame(snapshot: item as! DataSnapshot)
                if cipherGame.winningDeckOrCharacterName == cipherDeckStats.name && cipherGame.losingDecksOrCharacterName == cipherDeckStats.opponent { cipherDeckStats.addWin(); cipherDeckStats.relevantCipherGames.append(cipherGame) }
                else if cipherGame.winningDeckOrCharacterName == cipherDeckStats.opponent && cipherGame.losingDecksOrCharacterName == cipherDeckStats.name { cipherDeckStats.addLoss(); cipherDeckStats.relevantCipherGames.append(cipherGame) }
            }
            
            // Calculate winrate and return CipherDeckStat object
            cipherDeckStats.calculateWinRate()
            DispatchQueue.main.async { completion(.success(cipherDeckStats)) }
            
            // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Returns an array containing the win/loss count and
    //      overall win-rate of Player-A and Player-B's cipher matches
    //
    func getPlayerMatchupStats(selectedPlayer: Player, selectedOpponent: Player, completion: @escaping (Result<[Int], Error>) -> Void) {
        let ref = Database.database().reference(withPath: "recorded-games")
        ref.observe(.value, with: { snapshot in
            var playerMatchupStats = [0, 0, 0]
            
            // Build win/loss/winrate array from recorded cipher matches
            for item in snapshot.children {
                let cipherGame = CipherGame(snapshot: item as! DataSnapshot)
                if (cipherGame.winningPlayer == selectedPlayer.username && cipherGame.losingPlayer == selectedOpponent.username) { playerMatchupStats[0] += 1 }
                else if (cipherGame.winningPlayer == selectedOpponent.username && cipherGame.losingPlayer == selectedPlayer.username) { playerMatchupStats[1] += 1 }
            }
            
            playerMatchupStats[2] = (Double(playerMatchupStats[0]) / (Double(playerMatchupStats[0]) + Double(playerMatchupStats[1]))).roundToPercentage(2)
            DispatchQueue.main.async { completion(.success(playerMatchupStats)) }
            
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    //
    // GET: Returns an array of CipherInsigniaStat objects that
    //      contain all matchup statistics for all combinations
    //      of CipherInsignia matchups
    //
    func getInsigniaMatchupStats(completion: @escaping (Result<[CipherInsigniaStat], Error>) -> Void) {
        let ref = Database.database().reference(withPath: "game-statistics/fireEmblemCipher")
        ref.observe(.value, with: { snapshot in
            var insigniaMatchupStats = [CipherInsigniaStat]()
            var insigniaMatchup: CipherInsigniaStat
            
            for (index, color) in snapshot.children.enumerated() {
                switch index {
                    case 0: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.nohr, snapshot: color as! DataSnapshot)
                    case 1: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.mark_of_naga, snapshot: color as! DataSnapshot)
                    case 2: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.medallion, snapshot: color as! DataSnapshot)
                    case 12: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.divine_weapons, snapshot: color as! DataSnapshot)
                    case 13: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.blade_of_light, snapshot: color as! DataSnapshot)
                    case 15: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.hoshido, snapshot: color as! DataSnapshot)
                    case 16: insigniaMatchup = CipherInsigniaStat(cipherInsignia: CipherInsignia.holy_war_flag, snapshot: color as! DataSnapshot)
                    default: continue
                }
                insigniaMatchupStats.append(insigniaMatchup)
            }
            
            DispatchQueue.main.async { completion(.success(insigniaMatchupStats)) }
            
        // An error occurred during the Firebase API call
        }) { error in
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
}
