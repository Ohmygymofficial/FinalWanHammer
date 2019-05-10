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
                wanHammer.battleMode() // launch the Battle
            case "2":
                print("Lâcheur ! 😜")
                wanHammer.stayInProgram = false //change BOOL to go outside loop of program
            case "3":
                wanHammer.demoMode() //automatic choice of the userName, TeamName and Fighters
                wanHammer.battleMode() // launch the Battle
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
                wanHammer.countAction = 0
                var n = 0
                while n < 2 {
                    if n == 0 {
                        Team.resetFighters(fighterArray: wanHammer.fighterArrayP1, userArray: wanHammer.userArray[0], symbol: "🔴")
                    } else {
                        Team.resetFighters(fighterArray: wanHammer.fighterArrayP2, userArray: wanHammer.userArray[1], symbol: "🔵")
                    }
                    n += 1
                }
                wanHammer.battleMode() // launch the Battle
            case "2":
                print("Lâcheur ! 😜")
                wanHammer.stayInProgram = false
            default: print("je n'ai pas compris")
            }
        }
    }
    
    
    /**
     userInput : Take information about user (gamerName, teamName, FighterCategory & Name ....)
     */
    static func userInput() {
        
        while wanHammer.numberOfTeam < 2 {
            let pseudoOfGamerOk = UserSetting.pseudoOfGamers() // Starting to ask gamer's pseudo
            print("\rOk, merci à toi \(pseudoOfGamerOk) !" )
            let teamOfGamer = UserSetting.teamOfGamers() // Continue with team Name
            let userAndTeamInLoad = Team(gamerName: pseudoOfGamerOk, teamName: teamOfGamer) // link object with class Team
            if wanHammer.numberOfTeam == 0 {
                userAndTeamInLoad.symbol = "🔴"
            } else {
                userAndTeamInLoad.symbol = "🔵"
            }
            wanHammer.userArray.append(userAndTeamInLoad) // add this object in userArray
            print("\rMerci à toi \(userAndTeamInLoad.gamerName), ta team \(userAndTeamInLoad.teamName) a besoin de combattants maintenant !")
            if wanHammer.numberOfWizard > 0 { // Reset count numberOfWizard for the second user
                wanHammer.numberOfWizard = 0
            }
            UserSetting.chooseFighter() // Choose the Fighters of each team
            wanHammer.numberOfTeam += 1
        }
    }
    
    
    /**
     pseudoOfGamers : ask pseudo for the gamer
     */
    static func pseudoOfGamers() -> String {
        var pseudoOfGamerOk = ""
        repeat {
            if wanHammer.numberOfTeam == 0 {
                print("\r🔴 Joueur 1 : Quel est ton nom de Gamer ?")
            } else if wanHammer.numberOfTeam == 1 {
                print("\r🔵Joueur 2 : Quel est ton nom de Gamer ?")
            }
            if let pseudoOfGamer = readLine(), pseudoOfGamer != "" {
                pseudoOfGamerOk = String(pseudoOfGamer)
                if wanHammer.numberOfTeam == 1 {
                    if pseudoOfGamerOk == wanHammer.userArray[0].gamerName {
                        print("Désolé, le joueur 1 s'appelle déjà \(wanHammer.userArray[0].gamerName)")
                        return UserSetting.pseudoOfGamers()
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
                if wanHammer.numberOfTeam == 1 {
                    if teamofGamerOk == wanHammer.userArray[0].teamName {
                        print("Désolé, la team du joueur 1 s'appelle déjà \(wanHammer.userArray[0].teamName)")
                        return UserSetting.teamOfGamers()
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
        while wanHammer.numberOfFighter < 4 { // to be sure that each team have 3 fighters
            if wanHammer.numberOfFighter == 3 {
                print("\r\rEt donc, quel sera ton dernier fighter ? ")
            } else {
                print("\r\rTu dois choisir \(4 - wanHammer.numberOfFighter) Fighters : ")
            }
            print("\n1. 🗡 Donne moi un \(Category.warrior.rawValue)"
                + "\n2. 👨‍🎤 Donne moi un \(Category.dwarf.rawValue)"
                + "\n3. 👹 Donne moi un \(Category.colossus.rawValue)"
                + "\n4. 🧙‍♀️ Donne moi un \(Category.wizard.rawValue)"
                + "\n5. 💻 Voir les caractéristiques des personnages")
            
            if let choiceMenu1 = readLine() {
                switch choiceMenu1 {
                case "1":
                    UserSetting.addFighter(category: Category.warrior)
                case "2":
                    UserSetting.addFighter(category: Category.dwarf)
                case "3":
                    UserSetting.addFighter(category: Category.colossus)
                case "4":
                    if wanHammer.numberOfWizard >= 2 {
                        print("Désolé, vous ne pouvez pas choisir que des magiciens dans votre Team ;)")
                        return chooseFighter()
                    }
                    UserSetting.addFighter(category: Category.wizard)
                case "5":
                    UserSetting.FightersSettings()
                    UserSetting.pause()
                    chooseFighter()
                    
                default:
                    print("Je n'ai pas compris ton choix")
                    chooseFighter()
                }
            }
            UserSetting.ListArrayOfFighters()
            wanHammer.numberOfFighter += 1
        }
        print("Tu as choisi \(wanHammer.numberOfFighter - 1) fighters") // print when 3 fighters have been choosen
        wanHammer.numberOfFighter = 1 // reset var to 1
    }
    
    
    /**
     addFighter : In this function : Adding fighter in the good user Array
     */
    static func addFighter(category: Category) {
        
        print("\rOk pour le \(category) !")
        let nameOfTheFighterOk = nameOfTheFighter() // needed to initialize object
        let numberFetichOk = numberFetich() // needed to initialize object
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
            wanHammer.numberOfWizard += 1
        }
        if wanHammer.numberOfTeam == 0 { // add new object in the good Array depend of it's the TEAM 1 or the TEAM 2
            wanHammer.fighterArrayP1.append(fighterInLoad)
        } else if wanHammer.numberOfTeam == 1 {
            wanHammer.fighterArrayP2.append(fighterInLoad)
        }
    }
    
    
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
        print ("\r\rTeam \(wanHammer.userArray[wanHammer.numberOfTeam].teamName) Voici ton tableau de combattants mis à jour :")
        if wanHammer.numberOfTeam == 0 {
            for i in 0...wanHammer.fighterArrayP1.count - 1{
                print("🔴Le \(wanHammer.fighterArrayP1[i].category) : \(wanHammer.fighterArrayP1[i].name)")
            }
        } else {
            for i in 0...wanHammer.fighterArrayP2.count - 1 {
                print("🔵Le \(wanHammer.fighterArrayP2[i].category) : \(wanHammer.fighterArrayP2[i].name)")
            }
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
