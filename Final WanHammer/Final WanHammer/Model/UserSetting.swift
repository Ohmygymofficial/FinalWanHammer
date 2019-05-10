//
//  Message.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 10/05/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
class UserSetting {
    
    /**
     principalMenu : ask if User want to stay or quit program
     */
    static func principalMenu() {
        
        print("Bienvenue dans le WANHAMMER")
        print("\rQue voulez vous faire ?"
            + "\n1. ▶ Entrer dans le WANHAMMER"
            + "\n2. ❌ Je ne veux pas me battre"
            + "\n3. Attribution auto des équipes")
        if let choiceMenu1 = readLine() {
            switch choiceMenu1 {
            case "1":
                UserSetting.userInput() // ask userName and teamName and chooseFighters
                geek.battleMode() // launch the Battle
            case "2":
                print("Lâcheur ! 😜")
                geek.stayInProgram = false //change BOOL to go outside loop of program
            case "3":
                geek.demoMode() //automatic choice of the userName, TeamName and Fighters
                geek.battleMode() // launch the Battle
            default: print("je n'ai pas compris")
            }
        }
    }
    
    /**
     RevengeMenu : ask if User have already done One WanHammer
     */
    static func RevengeMenu() {
        print("Désirez vous une revanche ?"
            + "\n1. ▶ OUIIIIIII ! "
            + "\n2. ❌ Je ne veux plus me battre")
        if let choiceMenu1 = readLine() {
            switch choiceMenu1 {
            case "1":
                //reset LifePoint, weapon, Strenght, and each element of each fighters, and countAction
                geek.countAction = 0
                var n = 0
                while n < 2 {
                    if n == 0 {
                        Fighter.resetFighters(fighterArray: geek.fighterArrayP1, userArray: geek.userArray[0], symbol: "🔴")
                    } else {
                        Fighter.resetFighters(fighterArray: geek.fighterArrayP2, userArray: geek.userArray[1], symbol: "🔵")
                    }
                    n += 1
                }
                geek.battleMode() // launch the Battle
            case "2":
                print("Lâcheur ! 😜")
                geek.stayInProgram = false
            default: print("je n'ai pas compris")
            }
        }
    }
    
    
    /**
     userInput : Take information about user (gamerName, teamName, FighterCategory & Name ....)
     */
    static func userInput() {
        
        while geek.numberOfTeam < 2 {
            let pseudoOfGamerOk = Team.pseudoOfGamers() // Starting to ask gamer's pseudo
            print("\rOk, merci à toi \(pseudoOfGamerOk) !" )
            let teamOfGamer = Team.teamOfGamers() // Continue with team Name
            let userAndTeamInLoad = Team(gamerName: pseudoOfGamerOk, teamName: teamOfGamer) // link object with class Team
            if geek.numberOfTeam == 0 {
                userAndTeamInLoad.symbol = "🔴"
            } else {
                userAndTeamInLoad.symbol = "🔵"
            }
            geek.userArray.append(userAndTeamInLoad) // add this object in userArray
            print("\rMerci à toi \(userAndTeamInLoad.gamerName), ta team \(userAndTeamInLoad.teamName) a besoin de combattants maintenant !")
            if geek.numberOfWizard > 0 { // Reset count numberOfWizard for the second user
                geek.numberOfWizard = 0
            }
            Team.chooseFighter() // Choose the Fighters of each team
            geek.numberOfTeam += 1
        }
    }
    
    
    /**
     pause : To make a pause in execution, and wait about touch press about user
     */
    static func pause() {
        
        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()
        
    }
}
