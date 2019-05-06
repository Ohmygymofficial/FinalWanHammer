//
//  Warrior.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
// MARK: POO Class declaration

class Warrior : Fighter {
    
    
    override init(name: String, numberFetich: Int) { 
        super.init(name: name, numberFetich: numberFetich)
        /*
         self.category = Category.warrior.rawValue
         self.weapon = Weapon.sword.rawValue
         self.special = Special.doubleAttack.rawValue
         self.lifePoint = 100
         self.strenght = 10
         */
    }
    
    /**
     specialWarrior : Double Attack for Warrior special attack
     */
    func specialWarrior(wichTeam: Int, damageInLoad: Int, resultBonusToPrint: String) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre combattant possède une deuxième attaque")
        choiceDefender(wichTeam: wichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
        specialFetichAction = false
        historyPrint.actionPrint(resultBonusToPrint: "")
    }
}

