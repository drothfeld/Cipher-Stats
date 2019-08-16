//
//  CipherGameCollectionViewCell.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/16/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit

// ==================================================
// Defines an individual cell in the CipherGameListView
// collection view.
// ==================================================
class CipherGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerDeckLabel: UILabel!
    @IBOutlet weak var playerInsigniaImage: UIImageView!
    
    @IBOutlet weak var opponentNameLabel: UILabel!
    @IBOutlet weak var opponentDeckLabel: UILabel!
    @IBOutlet weak var opponentInsigniaImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var playerAView: UIView!
    @IBOutlet weak var playerBView: UIView!
}
