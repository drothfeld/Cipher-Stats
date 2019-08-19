//
//  InsigniaStringAlterations.swift
//  Cipher Stats
//
//  Created by Dylan Rothfeld on 8/18/19.
//  Copyright © 2019 Dylan Rothfeld. All rights reserved.
//

import Foundation


// Takes an extended version of an insignia description string
// and returns the corresponding CipherInsignia.
extension String {
    func convertToCipherInsignia() -> CipherInsignia {
        switch self {
            case "Sword of Light (Red)": return CipherInsignia.blade_of_light
            case "Mark of Naga (Blue)": return CipherInsignia.mark_of_naga
            case "Hoshido (White)": return CipherInsignia.hoshido
            case "Nohr (Black)": return CipherInsignia.nohr
            case "Medallion (Green)": return CipherInsignia.medallion
            case "Divine Artifacts (Purple)": return CipherInsignia.divine_weapons
            case "Holy War Flag (Yellow)": return CipherInsignia.holy_war_flag
            case "Crests of the Goddess (Brown)": return CipherInsignia.crests_of_the_goddess
            default: return CipherInsignia.colorless
        }
    }
}
