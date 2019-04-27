//
//  Dwarf.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

// MARK: POO Class declaration

class Dwarf : Fighter {
    
    override init(name: String, numberFetich: Int) {
        super.init(name: name, numberFetich: numberFetich)
        self.weapon = Weapon.axe.rawValue
        self.special = Special.doubleDamage.rawValue
        self.lifePoint = 80
        self.strenght = 20
        self.attempt = 1
        self.category = Category.dwarf.rawValue
    }
}
