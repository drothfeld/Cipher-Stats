//
//  PlayerStatsViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/7/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// The view controller for selecting and viewing
// cipher player statistics.
// ==================================================
class PlayerStatsViewController: UIViewController {
    // Storyboard Outlets
    @IBOutlet weak var SelectPlayerButton: UIButton!
    
    // Controller Values
    var selectedPlayer: Player!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // User selects a player from the popup
    func onSelectPlayer(_ data: Player) -> () {
        selectedPlayer = data
        SelectPlayerButton.setTitle(selectedPlayer.username, for: .normal)
    }
    
    // Bring up cipher player popup picker view modal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerPickerPopup" {
            let popup = segue.destination as! PlayerPickerPopUpViewController
            popup.onSelectPlayer = onSelectPlayer
        }
    }
}

