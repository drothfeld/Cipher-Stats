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
        // TODO: Make Firebase API call to get
        //       entered deck and opponent statistics
    }
}
