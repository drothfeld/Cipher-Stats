//
//  PlayerPickerPopUpViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// A modal popup view that contains a picker with all
// cipher players that have recorded matches.
// ==================================================
class PlayerPickerPopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // Storyboard Outlets
    @IBOutlet weak var PlayerPicker: UIPickerView!
    
    // Controller Values
    var playerPickerData = [Player]()
    var onSelectPlayer: ((_ data: Player) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make Firebase API call to get list of all users on TCG-Portal
        FirebaseService.shared.getPlayerProfiles(completion: { results in
            switch results {
                
            // Successful API call
            case .success(let players):
                self.playerPickerData = players
                self.PlayerPicker.reloadAllComponents()
                
            // An error occurred during API call
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // Picker column count
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    // Picker row count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return playerPickerData.count }
    
    // Capture the picker view selection
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> Int { return row }
    
    // Display the picker option labels
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: playerPickerData[row].username)
    }
    
    // User taps the done button after choosing a player
    @IBAction func DoneButtonPressed(_ sender: Any) {
        onSelectPlayer?(playerPickerData[PlayerPicker.selectedRow(inComponent: 0)])
        dismiss(animated: true)
    }
}
