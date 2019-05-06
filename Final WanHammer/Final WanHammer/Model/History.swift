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
    
    
    
    
    
    func actionPrint(resultBonusToPrint: String) {
        
        lifePointConvert() // if BONUS OR UNLUCKY ZONE has been used
        var attackOrCare = ""
        var gainOrLoose = ""
        if checkCategory {  // take a var to print different word (depend of category : Wizard or no)
            attackOrCare = "un soin"
            gainOrLoose = "reçoit"
        } else {
            attackOrCare = "une attaque"
            gainOrLoose = "perd"
        }
        
        if bonusOrUnluckZone == true || fromUnluckZone == true { // if fighter came from bonus zone, print different message
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
        if readLine() != nil {
            
        }
    }
}

