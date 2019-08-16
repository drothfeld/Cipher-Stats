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
class DeckStatsViewController: UIViewController, UITextFieldDelegate {
    // Storyboard Outlets
    @IBOutlet weak var DeckTextfield: UITextField!
    @IBOutlet weak var OpponentDeckTextfield: UITextField!
    @IBOutlet weak var WinCountLabel: UILabel!
    @IBOutlet weak var LossCountLabel: UILabel!
    @IBOutlet weak var WinrateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeckTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Deck", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        OpponentDeckTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Opponent Deck", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    // Hide keyboard when done key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func deckNameChanged(sender: UITextField) {
        // If there is no selected opponent, get overall statistics
        if (!OpponentDeckTextfield.hasText) {
            FirebaseService.shared.getCipherDeckStats(deckName: DeckTextfield.text ?? "", completion: { results in
                switch results {
                    
                // Successful API call
                case .success(let deckStats):
                    self.WinCountLabel.text = String(deckStats.wins)
                    self.LossCountLabel.text = String(deckStats.losses)
                    self.WinrateLabel.text = "Winrate: " + String(deckStats.winrate) + "%"
                    
                // An error occurred during API call
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        // If there is a selected opponent, get statistics for just this deck versus deck matchup
        } else {
            FirebaseService.shared.getDeckMatchupStats(deckNameA: DeckTextfield.text ?? "", deckNameB: OpponentDeckTextfield.text ?? "", completion: { results in
                switch results {
                    
                // Successful API call
                case .success(let deckMatchupStats):
                    self.WinCountLabel.text = String(deckMatchupStats.wins)
                    self.LossCountLabel.text = String(deckMatchupStats.losses)
                    self.WinrateLabel.text = "Winrate: " + String(deckMatchupStats.winrate) + "%"
                    
                // An error occurred during API call
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}
