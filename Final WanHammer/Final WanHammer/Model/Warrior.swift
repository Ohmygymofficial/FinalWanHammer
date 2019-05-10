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
        self.weapon = weapon
        self.special = special
        self.lifePoint = lifePoint
        self.strenght = strenght
        self.category = category
    }
    
    /**
     specialWarrior : Double Attack for Warrior special attack
     */
    override func specialAttack(_ whichTeam: Int?, _ damageInLoad: Int?, _ resultBonusToPrint: String?) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre combattant possède une deuxième attaque")
        if let whichTeam = whichTeam {
        wanHammer.choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
        }
        wanHammer.specialFetichAction = false
        historyPrint.actionPrint(resultBonusToPrint: "")
    }
}

