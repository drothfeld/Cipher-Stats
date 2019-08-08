//
//  CipherInsigniaStatView.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/2/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit


// ==================================================
// Defines a subclass of UIView that contains
// an insignia image identifier and statistical
// values for matchups in labels.
// ==================================================
class UIInsigniaStatView: UIView {
    var insignia: CipherInsignia
    var winCount: Int
    var lossCount: Int
    
    // Insignia icon UIImageView component
    lazy var insigniaImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = self.insignia.iconImage
        return imageView
    }()
    
    // Win count UILabel component
    lazy var winLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 70, y: 7, width: 25, height: 15))
        label.text = String(winCount)
        return label
    }()
    
    // Loss count UIlabel component
    lazy var lossLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 150 , y: 7, width: 25, height: 15))
        label.text = String(lossCount)
        return label
    }()
    
    // Win Rate UILabel component
    lazy var winRate: UILabel = {
        let label = UILabel(frame: CGRect(x: 220, y: 7, width: 75, height: 15))
        label.text = String((Double(self.winCount)/Double(self.winCount + self.lossCount)).roundToPercentage(2)) + "%"
        return label
    }()
    
    // Constructors
    init(insignia: CipherInsignia, winCount: Int, lossCount: Int, collectionIndex: Int?) {
        self.insignia = insignia
        self.winCount = winCount
        self.lossCount = lossCount
        super.init(frame: CGRect(x: 0, y: (collectionIndex ?? 0) * 40 + 50, width: 300, height: 30))
        setupView()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // Builds all UIKit components and adds them to the CipherInsigniaStatView
    private func setupView() {
        backgroundColor = .white
        addSubview(insigniaImageView)
        addSubview(winLabel)
        addSubview(lossLabel)
        addSubview(winRate)
    }
}
