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

