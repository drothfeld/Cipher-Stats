//
//  InsigniaStatsViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/7/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// The view controller for selecting and viewing
// cipher insignia/color statistics.
// ==================================================
class InsigniaStatsViewController: UIViewController {
    // Storyboard Outlets
    @IBOutlet weak var OverallWinratesButton: UIButton!
    @IBOutlet weak var MatchupWinratesButton: UIButton!
    @IBOutlet weak var OverallWinratesView: UIView!
    @IBOutlet weak var MatchupWinratesView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Toggle the displayed view to show overall insignia statistics
    @IBAction func ToggleStatisticsButtonPressed(_ sender: UIButton) {
        OverallWinratesButton.alpha = (sender == OverallWinratesButton) ? 1.0 : 0.5
        MatchupWinratesButton.alpha = (sender == MatchupWinratesButton) ? 1.0 : 0.5
        OverallWinratesView.isHidden = (sender == OverallWinratesButton) ? false : true
        MatchupWinratesView.isHidden = (sender == MatchupWinratesButton) ? false : true
    }
}

