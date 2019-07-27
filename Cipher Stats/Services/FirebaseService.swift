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
}
