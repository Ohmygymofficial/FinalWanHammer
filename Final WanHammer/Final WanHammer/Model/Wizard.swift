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
    
    override init(name: String, numberFetich: Int) {
        super.init(name: name, numberFetich: numberFetich)
        self.weapon = Weapon.wand.rawValue
        self.special = Special.fireball.rawValue
        self.lifePoint = 125
        self.strenght = 15
        self.category = Category.wizard.rawValue
    }
    
    func specialWizard(randomInt: Int, resultBonusToPrint: String) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre magicien envoi une Fireball et enlève 10 points de dommages à toute l'équipe adversaire")
        if randomInt == 1 { // for the team One
            for i in 0..<fighterArrayP2.count {
                print("\(fighterArrayP2[i].name) le \(fighterArrayP2[i].category) se retrouve à \(fighterArrayP2[i].lifePoint - 10)")
                fighterArrayP1[i].lifePoint -= 10
            }
        } else if randomInt == 2 { // for the team 2
            for i in 0..<fighterArrayP1.count {
                print("\(fighterArrayP1[i].name) le \(fighterArrayP1[i].category) se retrouve à \(fighterArrayP1[i].lifePoint - 10)")
                fighterArrayP1[i].lifePoint -= 10
            }
        }
        historyPrint.actionPrint(resultBonusToPrint: "")
        specialFetichAction = false
    }
}
