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
}
