//
//  DeckStatsViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/8/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// The view controller for selecting and viewing
// cipher MC deck statistics.
// ==================================================
class DeckStatsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseService.shared.getCipherDeckStats(deckName: "Corrin (M)", completion: { results in
            switch results {
                
            // Successful API call
            case .success(let deckStats):
                let stats = deckStats
                
                
            // An error occurred during API call
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
