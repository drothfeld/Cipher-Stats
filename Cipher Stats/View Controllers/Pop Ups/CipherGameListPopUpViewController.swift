//
//  CipherGameListPopUpViewController.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/16/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// A modal popup view that contains a table list view
// with all passed CipherGame objects.
// ==================================================
class CipherGameListPopUpViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Storyboard Outlets
    @IBOutlet weak var HeaderMatchupLabel: UILabel!
    
    // Controller Values
    var modeNames = [String?]()
    var cipherGameList = [CipherGame]()
    var viewMode: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderMatchupLabel.text = modeNames[1] == "" ? modeNames[0] : modeNames[0]! + " V.S " + modeNames[1]!
    }
    
    // Defines how many items are in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return cipherGameList.count }
    
    // Defines individual cells in the collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cipherGameCell", for: indexPath as IndexPath) as! CipherGameCollectionViewCell
        
        // Use different name checks depending on origin view controller
        let compareValue = viewMode == "deck" ? cipherGameList[indexPath.row].winningDeckOrCharacterName : cipherGameList[indexPath.row].winningPlayer
        
        // Check if Player/Deck A is first name passed to prevent uniform background colors
        if compareValue == modeNames[0] {
            cell.playerNameLabel.text = cipherGameList[indexPath.row].winningPlayer
            cell.playerDeckLabel.text = cipherGameList[indexPath.row].winningDeckOrCharacterName
            cell.opponentNameLabel.text = cipherGameList[indexPath.row].losingPlayer
            cell.opponentDeckLabel.text = cipherGameList[indexPath.row].losingDecksOrCharacterName
                
            cell.playerAView.backgroundColor = UIColor(red: 0, green: 128, blue: 1, alpha: 0.25)
            cell.playerBView.backgroundColor = UIColor(red: 128, green: 0, blue: 4, alpha: 0.25)
                
            // TODO: Set InsigniaImageView to proper image
                
        } else {
            cell.playerNameLabel.text = cipherGameList[indexPath.row].losingPlayer
            cell.playerDeckLabel.text = cipherGameList[indexPath.row].losingDecksOrCharacterName
            cell.opponentNameLabel.text = cipherGameList[indexPath.row].winningPlayer
            cell.opponentDeckLabel.text = cipherGameList[indexPath.row].winningDeckOrCharacterName
                
            cell.playerAView.backgroundColor = UIColor(red: 128, green: 0, blue: 4, alpha: 0.25)
            cell.playerBView.backgroundColor = UIColor(red: 0, green: 128, blue: 1, alpha: 0.25)
                
            // TODO: Set InsigniaImageView to proper image
        }
        cell.dateLabel.text = cipherGameList[indexPath.row].date.description
        
        return cell
    }
    
    // Dismiss the popup view modal
    @IBAction func exitButtonPressed(_ sender: Any) { dismiss(animated: true) }
}
