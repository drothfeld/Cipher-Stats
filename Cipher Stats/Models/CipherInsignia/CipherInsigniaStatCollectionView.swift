//
//  CipherInsigniaStatCollectionView.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/3/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// Defines a subclass of UIView that contains a
// collection of UIInsigniaStatViews for modularity.
// ==================================================
class UIInsigniaStatCollectionView: UIView {
    
    init(cipherInsigniaStats: [CipherInsigniaStat]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        for (index, cipherInsigniaStat) in cipherInsigniaStats.enumerated() {
            let cipherInsigniaStatView = UIInsigniaStatView(insignia: cipherInsigniaStat.cipherInsignia, winCount: cipherInsigniaStat.totalWins, lossCount: cipherInsigniaStat.totalLosses, collectionIndex: index)
            addSubview(cipherInsigniaStatView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
