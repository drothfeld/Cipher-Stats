//
//  UIInsigniaMatchupView.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/8/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// Defines a subclass of UIView that contains
// an insignia image identifier and all winrate
// values when playing against other insignias.
// ==================================================
class UIInsigniaMatchupView: UIView {
    var insignia: CipherInsignia
    
    // Insignia icon UIImageView component
    lazy var insigniaImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = self.insignia.iconImage
        return imageView
    }()
    
    // Winrate UILabel components
    private func createWinrateLabel(winrate: [Int], index: Int) -> UILabel {
        let label = UILabel(frame: CGRect(x: 50 + (40 * index), y: 7, width: 40, height: 15))
        label.text = (winrate[2] == 0) ? " " : String(winrate[2]) + "%"
        label.font = UIFont(name: "Avenir", size: 12)
        return label
    }
    
    // Constructors
    init(insigniaStat: CipherInsigniaStat, collectionIndex: Int?) {
        self.insignia = insigniaStat.cipherInsignia
        super.init(frame: CGRect(x: 0, y: (collectionIndex ?? 0) * 40 + 50, width: 335, height: 30))
        self.addSubview(insigniaImageView)
        self.backgroundColor = .white
        
        for (index, cipherInsigniaStat) in insigniaStat.insigniaMatchups.enumerated() {
            if index != insigniaStat.insigniaMatchups.endIndex - 1  { self.addSubview(createWinrateLabel(winrate: cipherInsigniaStat.1, index: index)) }
        }
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
