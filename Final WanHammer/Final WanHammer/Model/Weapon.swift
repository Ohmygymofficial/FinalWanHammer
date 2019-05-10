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
     randomChest : Random Chest appear   and content its different (depend of Wizard or no)
     */
    static func randomChest(whichTeam : Int) {
        
        // Array Chest Content and value
        let weaponChestContent = ["une épée dorée","une hâche de Rahan","une grenade","un fléau d'arme","un tire-bouchon"]
        let healthChestContent = ["une purée de brocoli","une barre protéinée","une whey à la banane","une framboise fraiche","un BigMac"]
        let newValueWeaponChestContent = [15,25,30,25,5]
        
        // var resultGift = ""
        let randomNumberChest = Int.random(in: 1..<5)
        if randomNumberChest == 2 {
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Waooow ! Quelle chance !! Un coffre est apparu devant toi !")
            if !geek.checkCategory  { // if it's Dwarf/Colossus/Warrior : USE weaponChestContent
                weaponOrHealthInChest(weaponOrHealthArray: weaponChestContent, newValueWeaponChestContent: newValueWeaponChestContent, whichTeam: whichTeam)
            } else if geek.checkCategory { // if it's a wizard : : USE healthChestContent
                weaponOrHealthInChest(weaponOrHealthArray: healthChestContent, newValueWeaponChestContent: newValueWeaponChestContent, whichTeam: whichTeam)
            }
        }
    }
    
    
    /**
     weaponOrHealthInChest : To choose good Array : Weapon or Health, depend of category
     */
    static func weaponOrHealthInChest(weaponOrHealthArray: Array<String>, newValueWeaponChestContent: Array<Int>, whichTeam: Int) {
        
        var resultGift = ""
        let resultGiftNumber = Int(arc4random_uniform(UInt32(weaponOrHealthArray.count)))
        resultGift = weaponOrHealthArray[resultGiftNumber]
        let resultStrenght = newValueWeaponChestContent[resultGiftNumber]
        let fighterArray = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        updateStrenghtAndWeapon(fighterArray: fighterArray, attackerNumber: geek.attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
        if resultGift != "" {
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t C'est \(resultGift) ! Tu t'en équipes !"
                + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Ta puissance d'action est maintenant de : \(historyPrint.hAttackerFActionStrenght)")
            UserSetting.pause()
        }
    }
    
    
    /**
     updateStrenghtAndWeapon : For update the weapon and Strenght of the good FighterArray with the good GIFT
     */
    static func updateStrenghtAndWeapon(fighterArray: [Fighter], attackerNumber: Int, resultStrenght: Int, resultGift: String) {
        
        fighterArray[attackerNumber].strenght = resultStrenght
        historyPrint.hAttackerFActionStrenght = fighterArray[attackerNumber].strenght
        fighterArray[attackerNumber].weapon = resultGift
    }
}
