//
//  UIInsigniaMatchupView.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/7/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// Defines a subclass of UIView that contains
// a collection of UIInsigniaMatchupViews.
// ==================================================
class UIInsigniaMatchupCollectionView: UIView {
    
    // Header row with insignia column labels
    lazy var headerRow: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 15, width: 335, height: 30))
        let redInsigniaImage = UIImageView(frame: CGRect(x: 50, y: 5, width: 20, height: 20))
        let blueInsigniaImage = UIImageView(frame: CGRect(x: 90, y: 5, width: 20, height: 20))
        let whiteInsigniaImage = UIImageView(frame: CGRect(x: 130, y: 5, width: 20, height: 20))
        let blackInsigniaImage = UIImageView(frame: CGRect(x: 170, y: 5, width: 20, height: 20))
        let greenInsigniaImage = UIImageView(frame: CGRect(x: 210, y: 5, width: 20, height: 20))
        let purpleInsigniaImage = UIImageView(frame: CGRect(x: 250, y: 5, width: 20, height: 20))
        let yellowInsigniaImage = UIImageView(frame: CGRect(x: 290, y: 5, width: 20, height: 20))
        
        view.backgroundColor = .white
        redInsigniaImage.image = CipherInsignia.blade_of_light.iconImage
        blueInsigniaImage.image = CipherInsignia.mark_of_naga.iconImage
        whiteInsigniaImage.image = CipherInsignia.hoshido.iconImage
        blackInsigniaImage.image = CipherInsignia.nohr.iconImage
        greenInsigniaImage.image = CipherInsignia.medallion.iconImage
        purpleInsigniaImage.image = CipherInsignia.divine_weapons.iconImage
        yellowInsigniaImage.image = CipherInsignia.holy_war_flag.iconImage
        
        view.addSubview(redInsigniaImage)
        view.addSubview(blueInsigniaImage)
        view.addSubview(whiteInsigniaImage)
        view.addSubview(blackInsigniaImage)
        view.addSubview(greenInsigniaImage)
        view.addSubview(purpleInsigniaImage)
        view.addSubview(yellowInsigniaImage)
        
        return view
    }()
    
    init(cipherInsigniaStats: [CipherInsigniaStat]) {
        super.init(frame: CGRect(x: 0, y: 0, width: 335, height: 300))
        addSubview(headerRow)
        
        for (index, cipherInsigniaStat) in cipherInsigniaStats.enumerated() {
            let cipherInsigniaMatchupView = UIInsigniaMatchupView(insigniaStat: cipherInsigniaStat, collectionIndex: index)
            addSubview(cipherInsigniaMatchupView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
