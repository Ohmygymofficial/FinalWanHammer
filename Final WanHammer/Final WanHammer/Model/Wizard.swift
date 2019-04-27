//
//  Wizard.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
// MARK: POO Class declaration

class Wizard : Fighter {
    
    var potion = 10
    
    override init(name: String, numberFetich: Int) {
        super.init(name: name, numberFetich: numberFetich)
        self.weapon = Weapon.wand.rawValue
        self.special = Special.fireball.rawValue
        self.lifePoint = 125
        self.strenght = 15
        self.attempt = 1
        self.category = Category.wizard.rawValue
    }
}
