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
    
    
    /**
     specialWizard : FireBall for Wizard special attack
     */
    override func specialAttack(_ wichTeam: Int?, _ damageInLoad: Int?, _ resultBonusToPrint: String?) {
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😇😇😇😇 FETICH TIME 😇😇😇😇"
            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre magicien envoi une Fireball et enlève :")
        if wichTeam == 1 { // for the team One
            fireballValueAndDamage(fighterArray: fighterArrayP2)
        } else if wichTeam == 2 { // for the team 2
            fireballValueAndDamage(fighterArray: fighterArrayP1)
        }
        specialFetichAction = false
    }
    
    
    
    /**
     fireballValueAndDamage : Give 30 / 20 or 10 value to the fireball and the good damage on the fighter's
     */
    func fireballValueAndDamage(fighterArray: [Fighter]) {
        
        var fireballDamage = 30 // this the power of this fetichTime
        var counterFireball = 0
        //take a first loop to check how many fighters are alive
        for i in 0..<fighterArray.count {
            if fighterArray[i].lifePoint > 0 {
                counterFireball += 1
            }
        }
        fireballDamage = 30 / counterFireball //give a value to fireball 10 20 or 30
        for i in 0..<fighterArray.count { //aply the damage to the fighters are alive
            print("\(fighterArray[i].name) le \(fighterArray[i].category) est  à \(fighterArray[i].lifePoint)")
            if fighterArray[i].lifePoint > 0 {
                fighterArray[i].lifePoint -= fireballDamage
                print("\(fireballDamage) points de dommages à \(fighterArray[i].name) le \(fighterArray[i].category). Il se retrouve à \(fighterArray[i].lifePoint)")
                if fighterArray[i].lifePoint <= 0 { //check if one of them is dead and print it
                    print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 WOWWWW LE WANHAMMER SE REDUIT : \(fighterArray[i].name) le \(fighterArray[i].category) est mort ! 🦴🦴🦴")
                }
            }
        }
    }
}



