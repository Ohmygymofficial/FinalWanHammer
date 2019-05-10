//
//  Weapon.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

// We defined here all the different weapons possibles of fighters
enum Weapon: String {
    
    case sword = "son épée"
    case axe = "sa hâche"
    case wand = "sa baguette"
    case fist = "son poing"
    
    
    /**
     updateStrenghtAndWeapon : For update the weapon and Strenght of the good FighterArray with the good GIFT
     */
    
    static func updateStrenghtAndWeapon(fighterArray: [Fighter], attackerNumber: Int, resultStrenght: Int, resultGift: String) {
        
        fighterArray[attackerNumber].strenght = resultStrenght
        historyPrint.hAttackerFActionStrenght = fighterArray[attackerNumber].strenght
        fighterArray[attackerNumber].weapon = resultGift
    }
    
}
