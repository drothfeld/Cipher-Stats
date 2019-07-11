//
//  PlayerStatsViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/7/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit

class PlayerStatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make Firebase API call to get list of all users on TCG-Portal
        FirebaseService.shared.getPlayerProfiles(completion: { results in
            switch results {
                // Successful API call
                case .success(let players):
                    print("Success")
                
                // An error occurred during API call
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }


}

