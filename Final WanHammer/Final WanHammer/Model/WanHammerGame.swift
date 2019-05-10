//
//  WanHammerGame.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 10/05/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation


class WanHammerGame {
    
    // BOOL to stay in program
    var stayInProgram = true
    
    // initialize countAction to check if it's the first Round, and also for the next Battle
    var countAction = 0
    
    // to switch team One and team Two
    var numberOfTeam = 0
    
    // Because we can't have only Wizard in a team
    var numberOfWizard = 0
    
    // to stop at 3 fighters
    var numberOfFighter = 1
    
    // Wizard or no ?
    var checkCategory = false
    
    // needed to select the good attacker in Array
    var attackerNumber = 0
    
    // needed to select the good defender in Array
    var defenderNumber = 0
    
    // True if the fetich number is activate
    var specialFetichAction = false
    
    // Bool to check is the attacker come from UnluckZone
    var fromUnluckZone = false
    
    //Use to edit different sort of message
    var bonusOrUnluckZone = false
    
    // To print only the aliveDefender
    var nDefendAlive = 0
    
    // To print only the aliveAttacker
    var nAttackAlive = 0
    
    // to propose revenge
    var revenge = false
    
    
    // MARK: Array declaration
    // for the team1
    var fighterArrayP1 = [Fighter]()
    
    // for the team2
    var fighterArrayP2 = [Fighter]()
    
    //  to archive User's Name / total LifePoint / Round Win and loose
    var userArray = [Team]()
    
    // this is for keep the good IndexNumber in Menu Defender/Attacker choice.
    var arrayGoodIndex = [0,1,2]
    
    
    // MARK: LOOP FOR THE PROGRAM
    func InTheGame() {
        while geek.stayInProgram {
            if !geek.revenge { // If it's the first WanHammer, launch the principalMenu
                UserSetting.principalMenu()
            } else { // print another menu to continue next Battle
                UserSetting.RevengeMenu()
            }
        }
    }
    
    
    /**
     battleMode : Step by step : We have to choose attacker, chest, Fetich zone, Defendeur, Bonus Zone
     */
    func battleMode() {
        print("\r\r\r\r\r😈😈 Tous les combattants sont en place : Presser une touche pour que le WANHAMMER continu !😈😈 ")
        UserSetting.pause()
        Team.lifePointConvert() // initialize userArray[].Lifepoint value to check if one TEAM is DEAD
        if !geek.revenge {
            History.checkAllTeamLifePoint() // Print all the fighters LifePoint only if it's the First Battle
        }
        UserSetting.pause()
        var whichTeam : Int = 1 //Variable for random choice, or logical choice
        while geek.userArray[0].lifeTeam > 0, geek.userArray[1].lifeTeam  > 0 { // LOOP HERE IF THERE IS AT LEAST ONE FIGHTER ALIVE IN EACH TEAM
            if geek.countAction == 0 { //Random choice for the First Player who give the first attack
                whichTeam = Int.random(in: 1..<3)
            }
            historyPrint.hAttackerFActionStrenght = Team.choiceAttackFrom(whichTeam: whichTeam)  // CHOICE ATTACKER MENU
            Weapon.randomChest(whichTeam: whichTeam) // RANDOM CHEST : Sometimes, you take new weapon at the beginning of the round with a random chest
            Fighter.randomFetichNumber(whichTeam: whichTeam) //FETICH NUMBER BONUS : Have to take before DEFENDER CHOICE because of the dwarf (double damage action)
            Team.choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght) // CHOICE DEFENDER MENU
            geek.countAction += 1 // one damage or care has been done : countAction have to be increase
            historyPrint.actionPrint(resultBonusToPrint: "")
            Fighter.applyFetichBonus(whichTeam: whichTeam) // APPLY FETICH BONUS FOR THE OTHERS ATTACKERS (Warrior, Colossus, Wizard)
            Fighter.randomBonus(whichTeam: whichTeam) // BONUS UNLUCK ZONE : If you're lucky, you can use your critical attack, if not you do an unlucky action
            if whichTeam == 1 { // TO SWITCH PLAYER ATTACK
                whichTeam = 2
            } else {
                whichTeam = 1
            }
        }
        historyPrint.battleIsFinishPrint()
        Team.addWinAndLooseValue()
    }
    
    
    /**
     demoMode: Fighter/teamName/UserName selected by the program
     */
    func demoMode() {
        
        //Create FAKE USER and TEAM
        var teamDemo = Team(gamerName: "Jean", teamName: "JeanBute")
        teamDemo.symbol = "🔴"
        geek.userArray.append(teamDemo)
        teamDemo = Team(gamerName: "Luc", teamName: "LuckYTeam")
        teamDemo.symbol = "🔵"
        geek.userArray.append(teamDemo)
        
        //CREATE FIGHTERS
        for i in 1...6 {
            
            if i == 1 {
                let fighterInLoad = Dwarf(name: ("Kulk.J"), numberFetich: i)
                geek.fighterArrayP1.append(fighterInLoad)
            }
            
            if i == 2 {
                let fighterInLoad = Colossus(name: ("Bouh.J"), numberFetich: i)
                geek.fighterArrayP1.append(fighterInLoad)
            }
            
            if i == 3 {
                let fighterInLoad = Warrior(name: ("Jean.J"), numberFetich: i)
                geek.fighterArrayP1.append(fighterInLoad)
            }
            if i == 4 {
                let fighterInLoad = Wizard(name: ("Magik.L"), numberFetich: i)
                geek.fighterArrayP2.append(fighterInLoad)
            }
            
            if i == 5 {
                let fighterInLoad = Warrior(name: ("Luc.L"), numberFetich: i)
                geek.fighterArrayP2.append(fighterInLoad)
            }
            
            if i == 6 {
                let fighterInLoad = Colossus(name: ("owww.L"), numberFetich: i - 2)
                geek.fighterArrayP2.append(fighterInLoad)
            }
        }
        
    }
    
    
}
