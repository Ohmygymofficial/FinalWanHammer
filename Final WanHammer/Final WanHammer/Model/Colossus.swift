//
//  Colossus.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
// MARK: POO Class declaration

class Colossus : Fighter {
    
    // PLEASE do an enum for WEAPON and SPECIAL like I did for Category ;)
    // To get a string of the value in the enum in main.swift it's : figherObject.category.rawValue
    
    override init(name: String, numberFetich: Int) {
        super.init(name: name, numberFetich: numberFetich)
        self.weapon = Weapon.fist.rawValue
        self.special = Special.fear.rawValue
        self.lifePoint = 200
        self.strenght = 5
        self.category = Category.colossus.rawValue
    }
    
    /**
     specialColossus : Fear for Colossus special attack
     */
    override func specialAttack(_ whichTeam: Int?, _ damageInLoad: Int?, _ resultBonusToPrint: String?) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre Colosse a fait peur a vos adversaires, vous avez droit à un deuxième tour")
        if let whichTeam = whichTeam {
            historyPrint.hAttackerFActionStrenght = wanHammer.choiceAttackFrom(whichTeam: whichTeam)
            wanHammer.choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
        }
        historyPrint.actionPrint(resultBonusToPrint: "")
        wanHammer.specialFetichAction = false
    }
}
