//
//  Message.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 10/05/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
class Message {
    
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
                Message.userInput() // ask userName and teamName and chooseFighters
                wanHammer.battleMode() // launch the Battle
            case "2":
                print("Lâcheur ! 😜")
                wanHammer.stayInProgram = false //change BOOL to go outside loop of program
            case "3":
                wanHammer.demoMode() //automatic choice of the userName, TeamName and Fighters
                wanHammer.battleMode()
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
                        wanHammer.resetFighters(fighterArray: wanHammer.fighterArrayP1, userArray: wanHammer.userArray[0], symbol: "🔴")
                    } else {
                        wanHammer.resetFighters(fighterArray: wanHammer.fighterArrayP2, userArray: wanHammer.userArray[1], symbol: "🔵")
                    }
                    n += 1
                }
                wanHammer.battleMode()
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
            let pseudoOfGamerOk = Message.pseudoOfGamers() // Starting to ask gamer's pseudo
            print("\rOk, merci \(pseudoOfGamerOk)")
            let teamOfGamer = Message.teamOfGamers() // Continue with team Name
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
            wanHammer.chooseFighter() // Choose the Fighters of each team
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
                        return Message.pseudoOfGamers()
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
                        return Message.teamOfGamers()
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
     pause : To make a pause in execution, and wait about touch press about user
     */
    static func pause() {
        
        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()
        
    } // End of next()
    
}




    /*
 
 // MARK: - Introduction
 static func arena() {
 print("Bienvenue dans l'arène ! \n")
 } // End of arena()
 
 static func playerName(_ player: String) {
 print("\(player) - Quel est ton nom ?", terminator: " ")
 } // End of playerName()
 
 static func welcome1(_ player: String) {
 print("Force & Honneur, \(player) ! \n")
 } // End of welcome1()
 
 static func welcome2(_ player: String) {
 print("Esprit & Robustesse sur toi, \(player) ! \n")
 } // End of welcome2()
 
 // MARK: - Champions creation
 static func usedName() {
 print("Ce nom est déjà pris, veuillez recommencer. \n")
 } // End of usedName()
 
 
    static func nameChampions(_ team: Team) {
        print("\(team.player) - Choisis le nom des héros qui composeront ton équipe ! \n")
    } // End of nameChampions()
    
    static func name(_ num: Int) {
        print("Quel est le nom de ton champion numéro \(num) ?")
    } // End of name()
    
    static func choseRole(_ hero: String) {
        print()
        print("Quelle sera la classe de \(hero) ? \n"
            + "\n1. Combattant" + " - ATQ: \(Constants.SWORDDAMAGE)"
            + " / PV: \(Constants.FIGHTERLIFE)" + " - Guerrier équilibré"
            + "\n2. Magicien" + " - ATQ: \(Constants.DEAD)"
            + " / PV: \(Constants.WIZARDLIFE)" + " - Ne combat pas / Soigneur efficace"
            + "\n3. Colosse" + " - ATQ: \(Constants.FISTSDAMAGE)"
            + " / PV: \(Constants.COLOSSUSLIFE)" + " - Faible puissance / Très résistant"
            + "\n4. Nain" + " - ATQ: \(Constants.AXEDAMAGE)"
            + " / PV: \(Constants.DWARFLIFE)" + " - Grande puissance / Peu résistant")
    } // End of choseRole()
    
    static func roleChoiced(_ currentCharacter: Character, _ role: String) {
        
        switch role {
        case "1":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                + " attrape une épée tranchante dans le râtelier d'arme le plus proche !")
        case "2":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                + " invoque son septre magique !")
        case "3":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                + " n'a besoin d'aucune arme pour écraser ses adversaires !")
        case "4":
            print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                + " se saisit de sa hache préférée !")
        default:
            print("Je n'ai pas compris votre choix."
                + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
        }
        print()
    } // End of roleChoiced()
    
    static func team1Created(_ team1: Team) {
        print("\(team1.player) - Tes champions"
            + " \(team1.characters[1]!.name), \(team1.characters[2]!.name) et \(team1.characters[3]!.name)"
            + " atteignent l'arène et attendent leurs adversaires de pied ferme.. \n")
    } // End of team1created()
    
    static func team2Created(_ team2: Team) {
        print("\(team2.player) - Tes champions"
            + " \(team2.characters[1]!.name), \(team2.characters[2]!.name) et \(team2.characters[3]!.name)"
            + " rejoignent l'enceinte et font face à leurs rivaux.. \n")
    } // End of team2Created()
    
    static func errorChoice() {
        print("Je n'ai pas compris votre choix."
            + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
        print()
    } // End of errorChoice()
    
    static func noRoleDuplicate() {
        print("ATTENTION: Vous possèdez déjà un champion de cette classe. Veuillez en choisir une autre !")
    } // End of noRoleDuplicate()
    
    // MARK: - Random Options
    static func randomStart(_ atkTeam: Team) {
        print("Le peuple a parlé ! L'équipe de \(atkTeam.player) donnera le premier assaut ! \n")
        print("QUE LE COMBAT COMMENCE ! \n")
    } // End of randomStart()
    
    static func randomTreasureAppears() {
        print("UN COFFRE MAGIQUE APPARAIT ! \n")
    } // End of randomTreasureAppears()
    
    // MARK: - Battle mode
    static func turn(_ turn: Int) {
        print("--- TOUR \(turn) --- \n")
    } // End of turn()
    
    static func attack1(_ atkTeam: Team) {
        print("\(atkTeam.player) - Quel champion souhaites-tu jouer ?")
    } // End of attack1()
    
    static func attack2(_ atkTeam: Team) {
        print("\(atkTeam.player) - Quel adversaire souhaites-tu attaquer ?")
    } // End of attack2()
    
    static func instantDamage(_ instantDamage: Int, _ atk: Character, _ def: Character, _ action: Int) {
        if action == 1 {
            print("\(atk.name) inflige \(instantDamage) points de dégâts à \(def.name). \n")
        } else if action == 3 {
            print("\(atk.name) soigne \(instantDamage) points de vie de \(def.name). \n")
        } else if action == 2 {
            print("\(atk.name) trouve une faille dans la défense de"
                + " \(def.name) et assène un coup critique de \(instantDamage * 2) points de dégâts ! \n")
        }
    } // End of instantDamage()
    
    static func dodge(_ defCharacter: Character) {
        print("\(defCharacter.name) esquive l'assaut ! \n")
    } // End of dodge()
    
    static func counterAttack(_ defCharacter: Character) {
        print("\(defCharacter.name) effectue une parade et contre-attaque !")
    } // End of counterAttack()
    
    static func deadCharacter(_ deadCharacter: Character) {
        print("\(deadCharacter.name) est mort ! \n")
    } // End of deadCharacter()
    
    static func heal1(_ team: Team) {
        print("\(team.player) - Quel compagnon souhaites-tu soigner ?")
    } // End of heal1()
    
    static func heal2(_ healCharacter: Character) {
        print("Il possède maintenant \(healCharacter.life) points de vie ! \n")
    } // End of heal2()
    
    static func noHeal(_ healCharacter: Character) {
        print("\(healCharacter.name) possède tous ses points de vie ! \n")
    } // End of noHeal()
    
    static func changeWeapon(_ atkCharacter: Character) {
        print("Quelle nouvelle arme choisira \(atkCharacter.name) le \(atkCharacter.roleName) ?"
            + "\n1. Masse - ATQ: \(Constants.MACEDAMAGEMIN) à \(Constants.MACEDAMAGEMAX) de dégâts"
            + "\n2. Dague - ATQ: \(Constants.DAGGERDAMAGEMIN) à \(Constants.DAGGERDAMAGEMAX) dégâts"
            + "\n3. Lance - ATQ: \(Constants.SPEARDAMAGEMIN) à \(Constants.SPEARDAMAGEMAX) dégâts"
            + "\n4. Refuser de changer d'arme")
    } // End of changeWeapon()
    
    static func weaponChoiced(_ atkCharacter: Character, _ weapon: String) {
        
        switch weapon {
        case "1":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit d'une imposante masse !")
        case "2":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit d'une dague mortelle !")
        case "3":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " se saisit de la lance maniable et rapide !")
        case "4":
            print("\(atkCharacter.name) le \(atkCharacter.roleName)"
                + " refuse de changer d'arme et poursuit le combat !")
        default:
            print("Je n'ai pas compris votre choix."
                + " Veuillez rentrer un numéro pour choisir l'arme correspondante.")
        }
        print()
    } // End of weaponChoiced()
    
    static func teamWins(_ team: Team) {
        print("\(team.player) REMPORTE LA VICTOIRE !! \n")
    } // End of teamWins()
    
    static func victory(_ turn: Int, _ team1: Team, _ team2: Team) {
        print("FIN DU COMBAT EN \(turn) TOURS ! \n")
        print("VICTOIRES : \(team1.player): \(team1.victory) / \(team2.player): \(team2.victory) \n")
    } // End of victory()
    
    // MARK: - Reset Option
    static func resetOptions() {
        print("Que souhaitez-vous faire ?"
            + "\n1. Rejouer avec les mêmes équipes"
            + "\n2. Rejouer avec des équipes différentes"
            + "\n3. Quitter le jeu")
    } // End of resetOptions()
    
    // MARK: - Flow controller
    static func next() {
        
        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()
        
    } // End of next()
}
*/
