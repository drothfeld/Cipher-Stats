//
//  CipherInsigniaStatCollectionView.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/3/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// Defines a subclass of UIView that contains
// a collection of UIInsigniaStatViews.
// ==================================================
class UIInsigniaStatCollectionView: UIView {
    
    // Header row with column labels
    lazy var headerRow: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 15, width: 300, height: 30))
        let winLabel = UILabel(frame: CGRect(x: 70 , y: 7, width: 70, height: 15))
        let lossLabel = UILabel(frame: CGRect(x: 150 , y: 7, width: 70, height: 15))
        let winRateLabel = UILabel(frame: CGRect(x: 220 , y: 7, width: 70, height: 15))
        
        winLabel.text = "Wins"
        lossLabel.text = "Losses"
        winRateLabel.text = "Winrate"
        
        view.backgroundColor = .white
        view.addSubview(winLabel)
        view.addSubview(lossLabel)
        view.addSubview(winRateLabel)
        
        return view
    }()
    
    init(cipherInsigniaStats: [CipherInsigniaStat]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 350))
        addSubview(headerRow)
        
        for (index, cipherInsigniaStat) in cipherInsigniaStats.enumerated() {
            let cipherInsigniaStatView = UIInsigniaStatView(insignia: cipherInsigniaStat.cipherInsignia, winCount: cipherInsigniaStat.totalWins, lossCount: cipherInsigniaStat.totalLosses, collectionIndex: index)
            addSubview(cipherInsigniaStatView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
