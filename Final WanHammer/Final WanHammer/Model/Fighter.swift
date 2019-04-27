//
//  Fighter.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

class Fighter {
    
    var name : String
    var numberFetich : Int
    
    // Attribute of fighter might change according to characters
    
    var category = Category.warrior.rawValue // By default we choose warrior or maybe another one ???
    var weapon: String = Weapon.sword.rawValue
    var special: String = Special.doubleAttack.rawValue
    var lifePoint: Int = 100
    var strenght: Int = 10
    var attempt: Int = 1
    
    init(name: String, numberFetich: Int) {
        self.name = name
        self.numberFetich = numberFetich
    }
}
