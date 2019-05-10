//
//  Team.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
class Team { // This class to create UserTeam
    
    var gamerName : String
    var teamName : String
    
    static let numberOfFighters = 3
    var winCounter = 0
    var looseCounter = 0
    var lifeTeam = 0
    var symbol = "X"
    
    init(gamerName: String, teamName: String) {
        self.gamerName = gamerName
        self.teamName = teamName
    }
    
    
    /**
     pseudoOfGamers : ask pseudo for the gamer
     */
    static func pseudoOfGamers() -> String {
        var pseudoOfGamerOk = ""
        repeat {
            if geek.numberOfTeam == 0 {
                print("\r🔴 Joueur 1 : Quel est ton nom de Gamer ?")
            } else if geek.numberOfTeam == 1 {
                print("\r🔵Joueur 2 : Quel est ton nom de Gamer ?")
            }
            if let pseudoOfGamer = readLine(), pseudoOfGamer != "" {
                pseudoOfGamerOk = String(pseudoOfGamer)
                if geek.numberOfTeam == 1 {
                    if pseudoOfGamerOk == geek.userArray[0].gamerName {
                        print("Désolé, le joueur 1 s'appelle déjà \(geek.userArray[0].gamerName)")
                        return Team.pseudoOfGamers()
                    }
                }
                return pseudoOfGamerOk
            } else {
                print("\rTu dois nous donner un nom de Gamer pour pouvoir jouer :")
            }
        } while pseudoOfGamerOk == ""
        return pseudoOfGamerOk
    }
    
    
    /**
     teamOfGamers : ask name of the Team
     */
    static func teamOfGamers() -> String {
        
        var teamofGamerOk = ""
        repeat { // repeat while teamOfGamer == ""
            print("Quel nom souhaites-tu donner à ta team ?")
            if let teamOfGamer = readLine(), teamOfGamer != "" {
                teamofGamerOk = String(teamOfGamer)
                if geek.numberOfTeam == 1 {
                    if teamofGamerOk == geek.userArray[0].teamName {
                        print("Désolé, la team du joueur 1 s'appelle déjà \(geek.userArray[0].teamName)")
                        return Team.teamOfGamers()
                    }
                }
                return teamofGamerOk
            } else {
                print("Tu dois donner un nom à ta team ;)")
            }
        } while teamofGamerOk == ""
        return teamofGamerOk
    }
    
    
    
    /**
     chooseFighter : Menu to choose category of fighters : 1 2 3 4
     */
    static func chooseFighter() {
        while geek.numberOfFighter < 4 { // to be sure that each team have 3 fighters
            if geek.numberOfFighter == 3 {
                print("\r\rEt donc, quel sera ton dernier fighter ? ")
            } else {
                print("\r\rTu dois choisir \(4 - geek.numberOfFighter) Fighters : ")
            }
            print("\n1. 🗡 Donne moi un \(Category.warrior.rawValue)"
                + "\n2. 👨‍🎤 Donne moi un \(Category.dwarf.rawValue)"
                + "\n3. 👹 Donne moi un \(Category.colossus.rawValue)"
                + "\n4. 🧙‍♀️ Donne moi un \(Category.wizard.rawValue)"
                + "\n5. 💻 Voir les caractéristiques des personnages")
            
            if let choiceMenu1 = readLine() {
                switch choiceMenu1 {
                case "1":
                    Team.addFighter(category: Category.warrior)
                case "2":
                    Team.addFighter(category: Category.dwarf)
                case "3":
                    Team.addFighter(category: Category.colossus)
                case "4":
                    if geek.numberOfWizard >= 2 {
                        print("Désolé, vous ne pouvez pas choisir que des magiciens dans votre Team ;)")
                        return chooseFighter()
                    }
                    Team.addFighter(category: Category.wizard)
                case "5":
                    Fighter.FightersSettings()
                    UserSetting.pause()
                    chooseFighter()
                    
                default:
                    print("Je n'ai pas compris ton choix")
                    chooseFighter()
                }
            }
            Fighter.ListArrayOfFighters()
            geek.numberOfFighter += 1
        }
        print("Tu as choisi \(geek.numberOfFighter - 1) fighters") // print when 3 fighters have been choosen
        geek.numberOfFighter = 1 // reset var to 1
    }
    
    
    /**
     addFighter : In this function : Adding fighter in the good user Array
     */
    static func addFighter(category: Category) {
        
        print("\rOk pour le \(category) !")
        let nameOfTheFighterOk = Fighter.nameOfTheFighter() // needed to initialize object
        let numberFetichOk = Fighter.numberFetich() // needed to initialize object
        var fighterInLoad = Fighter(name: "", numberFetich: 0)
        switch category { // depending category : link object with the good Class
        case .warrior:
            fighterInLoad = Warrior(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
        case .dwarf:
            fighterInLoad = Dwarf(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
        case .colossus:
            fighterInLoad = Colossus(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
        case .wizard:
            fighterInLoad = Wizard(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
            geek.numberOfWizard += 1
        }
        if geek.numberOfTeam == 0 { // add new object in the good Array depend of it's the TEAM 1 or the TEAM 2
            geek.fighterArrayP1.append(fighterInLoad)
        } else if geek.numberOfTeam == 1 {
            geek.fighterArrayP2.append(fighterInLoad)
        }
    }
    
    
    /**
     choiceAttackFrom : Here we have to choose the Attacker
     */
    static func choiceAttackFrom(whichTeam: Int) -> Int {
        
        geek.nAttackAlive = 0 // reset to check good choice while fighters were dead
        let userTeamName = Tools.selectArrayTeamOneOrTwo(whichTeam: whichTeam) //take the good UserArray for the function
        let fighterArray = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam) //take the good FighterArray for the function
        print("\r\r\r\(userTeamName.symbol) \(userTeamName.gamerName) de la Team \(userTeamName.teamName) : Il te reste \(userTeamName.lifeTeam) PV"
            + "\r Avec quel Fighter désires-tu agir ?")
        loopChoiceAttackFrom(fighterArray: fighterArray)
        
        if let choiceAttacker = readLine() { // Check User Choice
            if var choiceAttackerLoop = Int(choiceAttacker) { // Check if it's Int
                if choiceAttackerLoop <= 0 || choiceAttackerLoop > geek.nAttackAlive { // If the user Choice is not in the proposition 0 to ... nAttackAline : print :
                    print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                    return choiceAttackFrom(whichTeam: whichTeam)
                }
                choiceAttackerLoop = geek.arrayGoodIndex[choiceAttackerLoop - 1] // Adjust value to keep the good index (if fighter is dead / fighters are dead)
                switch choiceAttackerLoop {
                case choiceAttackerLoop:
                    historyPrint.UpdateHistoryAttacker(choiceAttackerLoop: choiceAttackerLoop, fighterArray : fighterArray, userTeamName : userTeamName.teamName)
                    geek.attackerNumber = choiceAttackerLoop // keep  in variable to use for Chest modification value
                    if historyPrint.hAttackerFCategory == Category.wizard.rawValue {
                        geek.checkCategory = true
                    } else {
                        geek.checkCategory = false
                    }
                    return historyPrint.hAttackerFActionStrenght
                default: print("Je n'ai pas compris qui donne l'attaque. On recommence : ")
                }
            }
            print("Vous devez choisir un chiffre attaquant. On recommence : ")
            return choiceAttackFrom(whichTeam: whichTeam)
        }
        return choiceAttackFrom(whichTeam: whichTeam)
    }
    
    
    /**
     loopChoiceAttackFrom : Func to print the attacker list with a loop
     */
    static func loopChoiceAttackFrom(fighterArray: [Fighter]) {
        
        for nAttack in 0..<fighterArray.count {
            if fighterArray[nAttack].lifePoint > 0 {  // print only if the fighter is not dead
                geek.nAttackAlive += 1 // to print the number : increase 1 2 3 ...
                geek.arrayGoodIndex[geek.nAttackAlive - 1] = nAttack // archive the good index to keep the good one in the fighterArrayP1 or P2
                print("\(geek.nAttackAlive). \(fighterArray[nAttack].name) le \(fighterArray[nAttack].category) avec \(fighterArray[nAttack].weapon) de puissance \(fighterArray[nAttack].strenght), reste PV : \(fighterArray[nAttack].lifePoint)")
            }
        }
    }
    
    
    /**
     choiceDefender : Who receive the attack or the Care
     */
    static func choiceDefender(whichTeam: Int, damageInLoad: Int) {
        
        let userTeam = Tools.selectArrayTeamOneOrTwo(whichTeam: whichTeam) // constant for the defender action : Good Array, Good Fighter, depending of which Team and Category
        let userTeamInverted = Tools.selectArrayTeamInverted(whichTeam: whichTeam)
        let defenderArray = Tools.selectArrayDefenderOneorTwo(whichTeam: whichTeam)
        let defenderArrayInverted = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        
        if !geek.checkCategory { // if it's not a Wizard
            let healOrAttack = "endommager"
            let healOrAttack2 = "Attaque"
            healOrAttackFighter(fighterArray: defenderArray, healOrAttack: healOrAttack, healOrAttack2 : healOrAttack2, userTeam: userTeam)
        } else { // If it's WIZARD : Then array of the fighter will be different because it's a care for the team of the Wizard
            let healOrAttack = "soigner"
            let healOrAttack2 = "Soin"
            healOrAttackFighter(fighterArray: defenderArrayInverted, healOrAttack: healOrAttack, healOrAttack2: healOrAttack2, userTeam: userTeam)
        }
        
        
        if let choicetoDefend = readLine() {
            if var iDefender = Int(choicetoDefend) {
                if iDefender <= 0 || iDefender > geek.nDefendAlive {
                    print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                    let _ = choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
                }
                iDefender = geek.arrayGoodIndex[iDefender - 1] // to take again the good Index
                switch iDefender {
                    //LOOP FOR CASE SITUATION
                //APPLY DAMAGE TO THE GOOD FIGHTER
                case iDefender:
                    if !geek.checkCategory {  //if it's not Wizard
                        historyPrint.updateHistoryDefenderDamage(iDefender: iDefender, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
                    } else {  //if it's a Wizard
                        historyPrint.updateHistoryDefenderCare(iDefender: iDefender, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
                    }
                default: print("Je n'ai pas compris qui reçoit le coup. On recommence : ")
                }
                geek.defenderNumber = iDefender // update var defenderNumber
            } else {
                print("Vous devez saisir le chiffre d'un défenseur : On recommence ^^")
                let _ = choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
            }
        }
    }
    
    
    /**
     healOrAttackFighter : To list with optimized code if it's an attack or a care (depend of FighterArray P1 or P2, and Category : Wizard or no)
     */
    static func healOrAttackFighter(fighterArray: [Fighter], healOrAttack: String, healOrAttack2 : String, userTeam: Team) {
        
        
        geek.nDefendAlive = 0 // reset to check good choice while fighters were dead
        print("\r\(userTeam.symbol) \(userTeam.gamerName) : Quel Fighter désires-tu \(healOrAttack) ?")
        
        for nDefend in 0..<fighterArray.count {
            if fighterArray[nDefend].lifePoint > 0 {
                geek.nDefendAlive += 1
                geek.arrayGoodIndex[geek.nDefendAlive - 1] = nDefend
                print("💢\(geek.nDefendAlive). \(healOrAttack2) sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
            }
        }
    }

    
    /**
     addWinAndLooseValue : At the end of the Game, give +1 to the value Win or Loose for each Team
     */
    static func addWinAndLooseValue () {
        
        geek.revenge = true
        if geek.userArray[0].lifeTeam < geek.userArray[1].lifeTeam {
            geek.userArray[0].looseCounter += 1
            geek.userArray[1].winCounter += 1
            print("\rUn point de Victoire pour la team \(geek.userArray[1].teamName)"
                + "\rBravo à toi \(geek.userArray[1].gamerName) !!!")
        } else {
            geek.userArray[1].looseCounter += 1
            geek.userArray[0].winCounter += 1
            print("\rUn point de Victoire pour la team \(geek.userArray[0].teamName)"
                + "\rBravo à toi \(geek.userArray[0].gamerName) !!!")
        }
        UserSetting.pause()
    }
    
    
    /**
     lifePointConvert : To convert negative lifePoint to 0 and can have good addition in the final result
     */
    static func lifePointConvert() {
        
        //to reset negative count to 0 and don't have error in addition mode
        for n in 0..<geek.fighterArrayP1.count {
            if geek.fighterArrayP1[n].lifePoint < 0 {
                geek.fighterArrayP1[n].lifePoint = 0
            }
        }
        for n in 0..<geek.fighterArrayP2.count {
            if geek.fighterArrayP2[n].lifePoint < 0 {
                geek.fighterArrayP2[n].lifePoint = 0
            }
        }
        // update userArray Life Team
        geek.userArray[0].lifeTeam = geek.fighterArrayP1[0].lifePoint + geek.fighterArrayP1[1].lifePoint + geek.fighterArrayP1[2].lifePoint
        geek.userArray[1].lifeTeam = geek.fighterArrayP2[0].lifePoint + geek.fighterArrayP2[1].lifePoint + geek.fighterArrayP2[2].lifePoint
        
    }
    
}

