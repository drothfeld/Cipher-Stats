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
    @IBOutlet weak var WinCountLabel: UILabel!
    @IBOutlet weak var LossCountLabel: UILabel!
    @IBOutlet weak var WinRateLabel: UILabel!
    @IBOutlet weak var RecentGameWinningPlayerLabel: UILabel!
    @IBOutlet weak var RecentGameLosingPlayerLabel: UILabel!
    @IBOutlet weak var RecentGameDateLabel: UILabel!
    
    // Controller Values
    var selectedPlayer: Player!

    
    // Make Firebase API call to get cipher statistics for selected player
    func loadPlayerStats() {
        FirebaseService.shared.getPlayerStats(ref: selectedPlayer.ref!, completion: { results in
            switch results {
                    
                // Successful API call
                case .success(let playerStats):
                    self.WinCountLabel.text = String(playerStats.totalWins)
                    self.LossCountLabel.text = String(playerStats.totalLosses)
                    self.WinRateLabel.text = "Winrate: " + String(playerStats.overallWinRate.roundToPercentage(2)) + "%"
                    
                // An error occurred during API call
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    // Make Firebase API call to get the most recent cipher match for selected player
    func loadMostRecentMatch() {
        FirebaseService.shared.getCipherGameMatches(completion: { results in
            switch results {
                
                // Successful API call
                case .success(let cipherMatches):
                    for match in cipherMatches {
                        if (match.winningPlayer == self.selectedPlayer.username || match.losingPlayer == self.selectedPlayer.username) {
                            self.RecentGameWinningPlayerLabel.text = match.winningPlayer + " (" + match.winningDeckOrCharacterName + ")"
                            self.RecentGameLosingPlayerLabel.text = match.losingPlayer + " (" + match.losingDecksOrCharacterName + ")"
                            self.RecentGameDateLabel.text = match.date.description
                            return
                        }
                    }
                
                // An error occurred during API call
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    // User selects a player from the popup
    func onSelectPlayer(_ data: Player) -> () {
        selectedPlayer = data
        SelectPlayerButton.setTitle(selectedPlayer.username, for: .normal)
        if selectedPlayer != nil {
            loadPlayerStats()
            loadMostRecentMatch()
        }
    }
    
    // Bring up cipher player popup picker view modal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerPickerPopup" {
            let popup = segue.destination as! PlayerPickerPopUpViewController
            popup.onSelectPlayer = onSelectPlayer
        }
    }
}

// Rounds a double to a specified digit count and returns as integer
extension Double {
    func roundToPercentage(_ fractionDigits: Int) -> Int {
        let multiplier = pow(10, Double(fractionDigits))
        let rounded = Darwin.round(self * multiplier) / multiplier
        return Int(rounded * 100)
    }
}

