//
//  History.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 28/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

class History { // This class for print history of the last action
    var hAttackerUserName = ""  // empty parameters declaration
    var hAttackerTeamName = ""
    var hAttackerLifePoint = 0
    var hAttackerFName = ""
    var hAttackerFCategory = ""
    var hAttackerFActionStrenght = 0
    var hAttackerFLifePoint = 0
    
    var hDefenderUserName = ""
    var hDefenderTeamName = ""
    var hDefenderLifePoint = 0
    var hDefenderFName = ""
    var hDefenderFCategory = ""
    var hDefenderFLifePoint = 0
    
    
    /**
     func UpdateHistoryAttacker : to update History of the last action (Here : var for the Attacker)
     */
    func UpdateHistoryAttacker(choiceAttackerLoop: Int, fighterArray : [Fighter], userTeamName : String) {
        
        historyPrint.hAttackerTeamName = userTeamName
        historyPrint.hAttackerFActionStrenght = fighterArray[choiceAttackerLoop].strenght
        historyPrint.hAttackerFName = fighterArray[choiceAttackerLoop].name
        historyPrint.hAttackerFCategory = fighterArray[choiceAttackerLoop].category
        historyPrint.hAttackerFLifePoint = fighterArray[choiceAttackerLoop].lifePoint
    }
    
    
    /**
     func updateHistoryDefenderDamage : to update damage & History of the last FIGHTER'S ACTION
     */
    func updateHistoryDefenderDamage(iDefender: Int, damageInLoad: Int, fighterArray: [Fighter], userTeamName: String) {
        
        // HERE CAN REFACTOR CODE   Situations are similar
        var alreadyDead = false
        var defenderRandomNumber = 0
        
        if geek.fromUnluckZone { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
            repeat {
                defenderRandomNumber = Int(arc4random_uniform(UInt32(fighterArray.count)))
                if fighterArray[defenderRandomNumber].lifePoint > 0 {
                    historyPrint.hDefenderTeamName = userTeamName
                    historyPrint.hDefenderFName = fighterArray[defenderRandomNumber].name
                    historyPrint.hDefenderFCategory = fighterArray[defenderRandomNumber].category
                    fighterArray[defenderRandomNumber].lifePoint -= historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
                    historyPrint.hDefenderFLifePoint = fighterArray[defenderRandomNumber].lifePoint //the others var in History to explain
                    if fighterArray[defenderRandomNumber].lifePoint <= 0 { // situation if The attacker dead HimSelf...have to go out of this loop
                        return print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 WOWWWW LE WANHAMMER SE REDUIT : \(fighterArray[defenderRandomNumber].name) le \(fighterArray[defenderRandomNumber].category) est mort ! 🦴🦴🦴")
                    }
                }
            }  while fighterArray[defenderRandomNumber].lifePoint <= 0
            return print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tPas de chance !")
        }
        
        
        // if the opponent is already dead with the previous attack : print a message
        if fighterArray[iDefender].lifePoint <= 0 {
            alreadyDead = true
        }
        
        historyPrint.hDefenderTeamName = userTeamName
        historyPrint.hDefenderFName = fighterArray[iDefender].name
        historyPrint.hDefenderFCategory = fighterArray[iDefender].category
        fighterArray[iDefender].lifePoint -= historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
        historyPrint.hDefenderFLifePoint = fighterArray[iDefender].lifePoint //the others var in History to explain
        if fighterArray[iDefender].lifePoint <= 0 {
            if alreadyDead {
                print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 IL S'ACHAAAAAAARNE : \(fighterArray[iDefender].name) le \(fighterArray[iDefender].category) est déjà mort...au sol ! 🦴🦴🦴 Mais pourtant : ")
            } else {
                print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 WOWWWW LE WANHAMMER SE REDUIT : \(fighterArray[iDefender].name) le \(fighterArray[iDefender].category) est mort ! 🦴🦴🦴")
            }
        }
    }
    
    
    /**
     func updateHistoryDefenderCare : to update damage & History of the last WIZARD'S ACTION
     */
    
    func updateHistoryDefenderCare(iDefender: Int, damageInLoad: Int, fighterArray: [Fighter], userTeamName: String) {
        
        var defenderRandomNumber = 0
        
        if geek.fromUnluckZone { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
            repeat {
                defenderRandomNumber = Int(arc4random_uniform(UInt32(fighterArray.count)))
                if fighterArray[defenderRandomNumber].lifePoint > 0 {
                    historyPrint.hDefenderTeamName = userTeamName
                    historyPrint.hDefenderFName = fighterArray[defenderRandomNumber].name
                    historyPrint.hDefenderFCategory =  fighterArray[defenderRandomNumber].category
                    fighterArray[defenderRandomNumber].lifePoint += historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
                    historyPrint.hDefenderFLifePoint = fighterArray[defenderRandomNumber].lifePoint //the others var in History to explain
                }
            }  while fighterArray[defenderRandomNumber].lifePoint <= 0
            return print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tPas de chance !")
        }
        historyPrint.hDefenderTeamName = userTeamName
        historyPrint.hDefenderFName = fighterArray[iDefender].name
        historyPrint.hDefenderFCategory =  fighterArray[iDefender].category
        fighterArray[iDefender].lifePoint += historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
        historyPrint.hDefenderFLifePoint = fighterArray[iDefender].lifePoint //the others var in History to explain
    }
    
    
    /**
     displayTeamAndFighterLifePoint : To loop on the good Fighter and user Array
     */
    static func displayTeamAndFighterLifePoint(userArray: Team, fighterArray : [Fighter], symbol : String ) {
        // You can check life point of each fighters
        print("\(symbol) TEAM \(userArray.teamName) PV : \(userArray.lifeTeam)")
        print("\(symbol)Voici l'état actuel de tes fighters")
        for fighter in fighterArray {
            print("\(symbol)Le \(fighter.category) \(fighter.name) possède \(fighter.lifePoint) PV")
        }
        print("\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)\(symbol)")
    }
    
    
    /**
     checkAllTeamLifePoint : Print the array of the team to check LifePoint of each Fighters
     */
    static func checkAllTeamLifePoint() {
        displayTeamAndFighterLifePoint(userArray: geek.userArray[0], fighterArray: geek.fighterArrayP1, symbol: "🔴")
        displayTeamAndFighterLifePoint(userArray: geek.userArray[1], fighterArray: geek.fighterArrayP2, symbol: "🔵")
    }
    
    
    
    
    /**
     actionPrint : To print result of the last action (depend of : Normal Action, Fetich Action, Bonus Action)
     */
    static func actionPrint(resultBonusToPrint: String) {
        
        Team.lifePointConvert() // if BONUS OR UNLUCKY ZONE has been used
        var attackOrCare = ""
        var gainOrLoose = ""
        if geek.checkCategory {  // take a var to print different word (depend of category : Wizard or no)
            attackOrCare = "un soin"
            gainOrLoose = "reçoit"
        } else {
            attackOrCare = "une attaque"
            gainOrLoose = "perd"
        }
        
        if geek.bonusOrUnluckZone == true || geek.fromUnluckZone == true { // if fighter came from bonus zone, print different message
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre \(historyPrint.hAttackerFCategory) \(historyPrint.hAttackerFName) \(resultBonusToPrint) ")
            if historyPrint.hAttackerFName == historyPrint.hDefenderFName {
                print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t....lui même ^^' !!")
            } else {
                print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\(historyPrint.hDefenderFName) le \(historyPrint.hDefenderFCategory) !!")
            }
        } else { 
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Voici l'historique de l'action réalisée : "
                + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Action Classique : \(historyPrint.hAttackerFName) le \(historyPrint.hAttackerFCategory)"
                + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t a fait \(attackOrCare) sur \(historyPrint.hDefenderFName) le \(historyPrint.hDefenderFCategory)")
        }
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCelui-ci \(gainOrLoose) \(historyPrint.hAttackerFActionStrenght) PV et en possède maintenant \(historyPrint.hDefenderFLifePoint)")  // This is the commun message
        UserSetting.pause()
    }
    
    
    /**
     thanksAtTheEnd : End Message
     */
    static func thanksAtTheEnd() {
        print("Merci ! J'espère que vous avez trouvé ça divertissant ^^")
    }
}

