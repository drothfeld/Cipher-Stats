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
    @IBOutlet weak var SelectOpponentButton: UIButton!
    @IBOutlet weak var WinCountLabel: UILabel!
    @IBOutlet weak var LossCountLabel: UILabel!
    @IBOutlet weak var WinRateLabel: UILabel!
    @IBOutlet weak var RecentGameWinningPlayerLabel: UILabel!
    @IBOutlet weak var RecentGameLosingPlayerLabel: UILabel!
    @IBOutlet weak var RecentGameDateLabel: UILabel!
    
    // Controller Values
    var selectedPlayer: Player!
    var selectedOpponent = Player.noPlayer

    
    // Make Firebase API call to get cipher statistics for selected player
    func loadPlayerStats() {
        // If there is no selected opponent, get overall statistics
        if (selectedOpponent == Player.noPlayer) {
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
            
        // If there is a selected opponent, get statistics for just this player versus player matchup
        } else {
            FirebaseService.shared.getPlayerMatchupStats(selectedPlayer: selectedPlayer, selectedOpponent: selectedOpponent, completion: { results in
                switch results {
                    
                    // Successful API call
                    case .success(let playerMatchupStats):
                        self.WinCountLabel.text = String(playerMatchupStats[0])
                        self.LossCountLabel.text = String(playerMatchupStats[1])
                        self.WinRateLabel.text = "Winrate: " + String(playerMatchupStats[2]) + "%"
                    
                    // An error occurred during API call
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            })
        }
    }
    
    // Make Firebase API call to get the most recent cipher match for selected player
    func loadMostRecentMatch() {
        FirebaseService.shared.getCipherGameMatches(completion: { results in
            switch results {
                
                // Successful API call
                case .success(let cipherMatches):
                    for match in cipherMatches {
                        if ((self.selectedOpponent == Player.noPlayer) &&
                            (match.winningPlayer == self.selectedPlayer.username || match.losingPlayer == self.selectedPlayer.username)) ||
                           ((self.selectedOpponent != Player.noPlayer) &&
                            ((match.winningPlayer == self.selectedPlayer.username && match.losingPlayer == self.selectedOpponent.username) ||
                             (match.winningPlayer == self.selectedOpponent.username && match.losingPlayer == self.selectedPlayer.username))) {
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
            if (selectedPlayer == selectedOpponent) { onSelectOpponent(Player.noPlayer) }
            SelectOpponentButton.isEnabled = true ; SelectOpponentButton.alpha = 1
            loadPlayerStats()
            loadMostRecentMatch()
        }
    }
    
    // User selects an opponent from the popup
    func onSelectOpponent(_ data: Player) -> () {
        selectedOpponent = data
        (selectedOpponent == Player.noPlayer) ? SelectOpponentButton.setTitle("Select Opponent", for: .normal) : SelectOpponentButton.setTitle(selectedOpponent.username, for: .normal)
        loadPlayerStats()
        loadMostRecentMatch()
    }
    
    // Bring up cipher player popup picker view modal
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayerPickerPopup" {
            let popup = segue.destination as! PlayerPickerPopUpViewController
            popup.onSelectPlayer = onSelectPlayer
        }
        else if segue.identifier == "toOpponentPickerPopup" {
            let popup = segue.destination as! PlayerPickerPopUpViewController
            popup.onSelectOpponent = onSelectOpponent
            popup.isOpponent = true
            popup.selectedPlayer = selectedPlayer
        }
    }
}

