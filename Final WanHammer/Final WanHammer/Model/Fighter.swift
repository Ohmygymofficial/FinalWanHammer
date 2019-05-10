//
//  Fighter.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

class Fighter { // Attribute of fighter might change according to characters
    
    var name : String
    var numberFetich : Int
    
    var category = Category.warrior.rawValue // By default we choose warrior
    var weapon: String = Weapon.sword.rawValue
    var special: String = Special.doubleAttack.rawValue
    var lifePoint: Int = 100
    var strenght: Int = 10
    
    init(name: String, numberFetich: Int) {
        self.name = name
        self.numberFetich = numberFetich
    }
    
    
    
    func specialAttack(_ whichTeam: Int?, _ damageInLoad: Int?, _ resultBonusToPrint: String?) {}
    
    
    /**
     nameOfTheFighter : ask name of each fighter
     */
    static func nameOfTheFighter() -> String {
        var nameOfTheFighterOk = ""
        repeat { //repeat while var is empty
            print("Quel nom souhaite tu lui donner ? ")
            if let nameTest = readLine(), nameTest != "" {
                nameOfTheFighterOk = String(nameTest)
                return nameOfTheFighterOk
            } else {
                print("Tu dois donner un nom à ton Fighter")
            }
        } while nameOfTheFighterOk == ""
        return nameOfTheFighterOk
    }
    
    
    /**
     numberFetich : ask FetichNumber of the fighter
     */
    static func numberFetich() -> Int {
        let numberTestOk = ""
        repeat { // repeat while var is empty
            print("Quel est ton numéro fétiche entre 1 et 5 ")
            if let numberTest = readLine() {
                if let numberTestOk = Int(numberTest) { // check if it's Int
                    if numberTestOk > 0, numberTestOk < 6 {
                        return numberTestOk
                    } else { // if it's not 1 2 3 4 5  print this :
                        print("Le chiffre doit être supérieur à 0, et inférieur à 6")
                    }
                } else { // if it's Int, so print :
                    print("Cela ne peut être qu'un numéro !")
                }
                
            } else {
                print("Tu dois donner un numéro fétiche à ton Fighter dans la fonction numberTest ;)")
            }
        } while numberTestOk == ""
        return 1
    }
    
    
    /**
     FightersSettings : To print the caracteristic of the Fighters
     */
    static func FightersSettings() {
        print("Voici les caractéristiques des personnages :"
            + "\n 🗡 Le \(Category.warrior.rawValue): PV : 100, Dégâts : 10, spécial : Double Attaque"
            + "\n 👨‍🎤 Le \(Category.dwarf.rawValue) : PV : 80, Arme : Hâche, Dégâts : 20, spécial : Double Dégâts"
            + "\n 👹 Le \(Category.colossus.rawValue) : PV : 200, Dégâts : 5, spécial : Frayeur (Adversaire perd son tour)"
            + "\n 🧙‍♀️ Le \(Category.wizard.rawValue) : PV : 150, Soins : +15, spécial : FireBall dégâts 30")
    }
    
    
    /**
     ListArrayOfFighters : To print List of Fighters
     */
    static func ListArrayOfFighters() {
        print ("\r\rTeam \(geek.userArray[geek.numberOfTeam].teamName) Voici ton tableau de combattants mis à jour :")
        if geek.numberOfTeam == 0 {
            for i in 0...geek.fighterArrayP1.count - 1{
                print("🔴Le \(geek.fighterArrayP1[i].category) : \(geek.fighterArrayP1[i].name)")
            }
        } else {
            for i in 0...geek.fighterArrayP2.count - 1 {
                print("🔵Le \(geek.fighterArrayP2[i].category) : \(geek.fighterArrayP2[i].name)")
            }
        }
    }
    
    
    /**
     updateStrenghtAndWeapon : For update the weapon and Strenght of the good FighterArray with the good GIFT
     */
    func updateStrenghtAndWeapon(fighterArray: [Fighter], attackerNumber: Int, resultStrenght: Int, resultGift: String) {
        
        self.strenght = resultStrenght
        self.weapon = resultGift
        
        fighterArray[attackerNumber].strenght = resultStrenght
        historyPrint.hAttackerFActionStrenght = fighterArray[attackerNumber].strenght
        fighterArray[attackerNumber].weapon = resultGift
    }
    
    /**
     resetFighters : Function to reset All the parameters of each Fighters on each teams
     */
    static func resetFighters(fighterArray: [Fighter],userArray: Team, symbol: String) {
        
        for i in 0..<fighterArray.count {
            if fighterArray[i].category == "Combattant" {
                fighterArray[i].lifePoint = 100
                fighterArray[i].strenght = 10
                fighterArray[i].weapon = Weapon.sword.rawValue
            }
            if fighterArray[i].category == "Nain" {
                fighterArray[i].lifePoint = 80
                fighterArray[i].strenght = 20
                fighterArray[i].weapon = Weapon.axe.rawValue
            }
            if fighterArray[i].category == "Colosse" {
                fighterArray[i].lifePoint = 200
                fighterArray[i].strenght = 5
                fighterArray[i].weapon = Weapon.fist.rawValue
            }
            if fighterArray[i].category == "Magicien" {
                fighterArray[i].lifePoint = 125
                fighterArray[i].strenght = 15
                fighterArray[i].weapon = Weapon.wand.rawValue
            }
        }
        
        print ("\r\rTeam \(userArray.teamName) Voici ton tableau de combattants : Ils sont tous FRAIS à nouveau :) ")
        for i in 0...fighterArray.count - 1{
            print("\(symbol) Le \(fighterArray[i].category) : \(fighterArray[i].name), Force \(fighterArray[i].strenght), avec \(fighterArray[i].weapon). PV \(fighterArray[i].lifePoint)")
        }
    }
    
}
