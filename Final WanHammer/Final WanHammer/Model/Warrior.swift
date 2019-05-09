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
    
    
    
    /**
     specialWarrior : Double Attack for Warrior special attack
     */
    override func specialAttack(_ wichTeam: Int?, _ damageInLoad: Int?, _ resultBonusToPrint: String?) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre combattant possède une deuxième attaque")
        if let wichTeam = wichTeam {
        choiceDefender(wichTeam: wichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
        }
        specialFetichAction = false
        historyPrint.actionPrint(resultBonusToPrint: "")
    }
}

