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
    
    
    /**
     specialAttack : Nothing of mother Class
     */
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
     randomFetichNumber : Check random Fetich number : If it's ok : resultFetich Bool become true and special action will be proposed
     */
    static func randomFetichNumber(whichTeam : Int) {
        
        var fetichOk = false
        let randomFetichNumber = Int.random(in: 1..<6)
        let fighterArray = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        if randomFetichNumber == fighterArray[geek.attackerNumber].numberFetich {
            fetichOk = true
        }
        
        if fetichOk {
            switch historyPrint.hAttackerFCategory {
            case Category.warrior.rawValue:
                geek.specialFetichAction = true
            case Category.dwarf.rawValue:
                let specialInLoad = Dwarf(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
                geek.specialFetichAction = false
            case Category.colossus.rawValue:
                geek.specialFetichAction = true
            case Category.wizard.rawValue:
                geek.specialFetichAction = true
            default:
                print("Pas d'action Fétiche ce tour ci ^^") //never happen. Have to keep it because SWITCH is on the current Attacker var
            }
        }
    }
    
    
    /**
     applyFetichBonus : The Dwarf have already apply his double damage if he find FetichNumber...but for the other : We need another function
     */
    static func applyFetichBonus(whichTeam : Int) {
        
        if geek.specialFetichAction {
            if historyPrint.hAttackerFCategory == Category.warrior.rawValue { //SPECIAL FETICH for the Warrior : Double Attack, so launch second attack after firstDamage
                let specialInLoad = Warrior(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            if historyPrint.hAttackerFCategory == Category.colossus.rawValue { // SPECIAL FETICH for the Colossus : entiere Double Turn
                let specialInLoad = Colossus(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            if historyPrint.hAttackerFCategory == Category.wizard.rawValue { // SPECIAL FETICH for the Magician : Loop damage for all the opponent lifePoint Array
                let specialInLoad = Wizard(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            geek.specialFetichAction = false
        }
    }
    
    
    /**
     randomBONUS : Random BONUS (depend of Wizard or no)
     */
    static func randomBonus(whichTeam: Int) {
        
        let randomBonusZone = Int.random(in: 1..<20)
        let category = historyPrint.hAttackerFCategory
        let userTeam = Tools.selectArrayTeamOneOrTwo(whichTeam: whichTeam) // constant for the defender action : Good Array, Good Fighter, depending of which Team and Category
        let userTeamInverted = Tools.selectArrayTeamInverted(whichTeam: whichTeam)
        let defenderArray = Tools.selectArrayDefenderOneorTwo(whichTeam: whichTeam)
        let defenderArrayInverted = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        
        
        if randomBonusZone == 19 {  //BONUS ZONE : GOOD ACTION
            geek.bonusOrUnluckZone = true // used later for print final result
            var resultBonusToPrint = ""
            let bonusZoneFighter = ["prend confiance et envoit un autre coup puissant au ventre de ","dans son élan d'attaque, ajoute un revers puissant en pleine figure de ","énervé, prend appui sur un arbre, et envoi un coup fatal en pleine gorge de ","utilise son courage pour ajouter une série de 6 coups de tête en plein nez de ","nous fait un coup retourné supplémentaire en plein dos de "]
            let instantDamageValue = [50,60,90,60,50]
            let bonusZoneWizard = ["rassemble sa concentration et arrive à ajouter un sort de soin puissant pour ","ajoute 2 mouvements spéciaux et envoi un soin pour ","utilise sa dernière formule ! Un soin puissant est invoqué pour "]
            let instantCareValue = [50,60,90]
            switch category {
            case "Combattant", "Nain", "Colosse":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(bonusZoneFighter.count)))
                resultBonusToPrint = bonusZoneFighter[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantDamageValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderDamage(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(bonusZoneWizard.count)))
                resultBonusToPrint = bonusZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderCare(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😎😎😎😎  BONUS ZONE  😎😎😎😎")
            historyPrint.actionPrint(resultBonusToPrint: resultBonusToPrint)
            geek.bonusOrUnluckZone = false
        }
        
        
        if randomBonusZone == 1 { //UNLUCK ZONE
            geek.fromUnluckZone = true
            var resultBonusToPrint = ""
            let unluckyZoneFighter = ["prend confiance et envoit un autre coup puissant .... mais il glisse et crée une blessure au ventre sur ","dans son élan d'attaque, ajoute un revers puissant..mais il manque son coup et crée une blessure au bras sur ","énervé, prend appui sur un arbre, pour envoyer un coup fatal en pleine gorge...mais l'arbre est glissant, il rate son attaque et crée une profonde blessure sur ","utilise son courage pour ajouter des coups de tête...mais désorienté, il crée des blessures sur ","nous fait un coup retourné supplémentaire ...son arme lui glisse des mains et il crée une entaille sur "]
            let instantDamageValue = [50,60,90,60,50]
            let unluckyZoneWizard = ["rassemble sa concentration pour lancer un soin puissant...mais il est déconcentré et son soin est envoyé sur ","ajoute 2 mouvements spéciaux pour soigner encore ! Mouvements râtés....les soins arrivent sur ","utilise sa dernière formule ! Un soin puissant est invoqué! Mais la formule est pas la bonne... et elle soigne "]
            let instantCareValue = [50,60,90]
            
            switch category {
            case "Combattant", "Nain", "Colosse":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(unluckyZoneFighter.count)))
                resultBonusToPrint = unluckyZoneFighter[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantDamageValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderDamage(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(unluckyZoneWizard.count)))
                resultBonusToPrint = unluckyZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderCare(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😩😩😩😩  UNLUCK ZONE  😩😩😩😩")
            historyPrint.actionPrint(resultBonusToPrint: resultBonusToPrint)
            geek.fromUnluckZone = false
        }
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
     isDead : To check if the fighter is dead and change var alreadyDead
     */
    static func isDead(i : Int, fighterArray: [Fighter]) {
        if fighterArray[i].lifePoint <= 0 { //check if one of them is dead and print it
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 WOWWWW LE WANHAMMER SE REDUIT : \(fighterArray[i].name) le \(fighterArray[i].category) est mort ! 🦴🦴🦴")
        }
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
