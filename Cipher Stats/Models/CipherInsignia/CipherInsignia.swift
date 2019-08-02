//
//  CipherInsignia.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/1/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import UIKit

// ==================================================
// Defines an existing static insignia that is
// represented by a card color type.
// ==================================================
struct CipherInsignia: Equatable {
    // Fields
    var name: String
    var colorName: String
    var iconImageName: String = "30px-Colorless.png"
    var iconImage: UIImage?
    
    // Constructor
    private init(name: String, colorName: String, iconImageName: String?) {
        self.name = name
        self.colorName = colorName
        self.iconImage = (iconImageName != "30px-Colorless.png") ? UIImage(named: iconImageName!) : UIImage(named: "30px-Colorless.png")
    }
    
    static func == (lhs: CipherInsignia, rhs: CipherInsignia) -> Bool { return lhs.name == rhs.name}
    
    // All current existing card colors in cipher
    static let blade_of_light = CipherInsignia(name: "Blade of Light", colorName: "red", iconImageName: "30px-Red.png")
    static let mark_of_naga = CipherInsignia(name: "Mark of Naga", colorName: "blue", iconImageName: "30px-Blue.png")
    static let hoshido = CipherInsignia(name: "Hoshido", colorName: "white", iconImageName: "30px-White.png")
    static let nohr = CipherInsignia(name: "Nohr", colorName: "black", iconImageName: "30px-Black.png")
    static let medallion = CipherInsignia(name: "Medallion", colorName: "green", iconImageName: "30px-Green.png")
    static let divine_weapons = CipherInsignia(name: "Divine Weapons", colorName: "purple", iconImageName: "30px-Purple.png")
    static let holy_war_flag = CipherInsignia(name: "Holy War Flag", colorName: "yellow", iconImageName: "30px-Yellow.png")
    static let crests_of_the_goddess = CipherInsignia(name: "Crests of the Goddess", colorName: "brown", iconImageName: "30px-Brown.png")
    static let colorless = CipherInsignia(name: "Colorless", colorName: "none", iconImageName: "30px-Colorless.png")
}

