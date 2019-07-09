//
//  PlayerPickerPopUpViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 7/9/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit

class PlayerPickerPopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // Storyboard Outlets
    @IBOutlet weak var PlayerPicker: UIPickerView!
    
    // Controller Values
    var playerPickerData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        playerPickerData = FIREBASE_GETPLAYERS_API_RESULT
    }
    
    // Picker column count
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    // Picker row count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return playerPickerData.count }
    
    // Capture the picker view selection
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> Int { return row }
    
    // User taps the done button after choosing a player
    @IBAction func DoneButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
