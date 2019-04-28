//
//  main.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation


// MARK: var declaration
var stayInProgram = true
var numberOfTeam = 0 // to switch team One and team Two
var numberOfWizard = 0 // Because we can't have only Wizard in a team
var numberOfFighter = 1 // to stop at 3 fighters
var checkCategory = false
var attackerNumber = 0
var specialWizardOn = false
var specialColossus = false
var specialWarrior = false

// MARK: Array declaration
var fighterArrayP1 = [Fighter]()   // for the team1
var fighterArrayP2 = [Fighter]()  // for the team2
var userArray = [Team]()  //  to archive User's Name / total LifePoint / Round Win and loose
var actionArray : [Any] = ["Joueur1", "Fighter1", "Categorie1", "LifePoint1","Joueur2", "Fighter2", "Categorie2", "LifePoint2"]




/**
 principalMenu : ask if User want to stay or quit program
 */
func principalMenu() {
    //Start With "Welcome print"
    print("Bienvenue dans le WANHAMMER")
    print("\rQue voulez vous faire ?"
        + "\n1. ▶ Entrer dans le WANHAMMER"
        + "\n2. ❌ Je ne veux pas me battre")
    
    if let choiceMenu1 = readLine() {
        switch choiceMenu1 {
        case "1":
            userInput()
            battleMode()
            print("Fonction à ajouter")
        case "2":
            print("Lâcheur ! 😜")
            stayInProgram = false
        default: print("je n'ai pas compris")
        }
    }
}




/**
 userInput : Take information about user (gamerName, teamName, FighterCategory & Name ....)
 */
func userInput() {
    
    while numberOfTeam < 2 {
        
        // Starting to ask gamer's pseudo
        let pseudoOfGamerOk = pseudoOfGamers()
        print("\rOk, merci \(pseudoOfGamerOk)")
        // Continue with team Name
        let teamOfGamer = teamOfGamers()
        //add value into good instance and Array User
        let userAndTeamInLoad = Team(gamerName: pseudoOfGamerOk, teamName: teamOfGamer)
        userArray.append(userAndTeamInLoad)
        print("\rMerci à toi \(userAndTeamInLoad.gamerName), ta team \(userAndTeamInLoad.teamName) a besoin de combattants maintenant !")
        // Reset count numberOfWizard for the second user
        if numberOfWizard > 0 {
            numberOfWizard = 0
        }
        // Choose the Fighters of each team
        chooseFighter()
        numberOfTeam += 1
    }
}



/**
 pseudoOfGamers : ask pseudo for the gamer
 */
func pseudoOfGamers() -> String {
    var pseudoOfGamerOk = ""
    repeat {
        if numberOfTeam == 0 {
            print("\r🔴 Joueur 1 : Quel est ton nom de Gamer ?")
        } else if numberOfTeam == 1 {
            print("\r🔵Joueur 2 : Quel est ton nom de Gamer ?")
        }
        if let pseudoOfGamer = readLine(), pseudoOfGamer != "" {
            pseudoOfGamerOk = String(pseudoOfGamer)
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
func teamOfGamers() -> String {
    
    var teamofGamerOk = ""
    repeat {
        print("Quel nom souhaite tu donner à ta team ?")
        if let teamOfGamer = readLine(), teamOfGamer != "" {
            teamofGamerOk = String(teamOfGamer)
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
func chooseFighter() {
    
    
    while numberOfFighter < 4 {
        if numberOfFighter == 3 {
            print("\r\rEt donc, quel sera ton dernier fighter ? ")
        } else {
            print("\r\rTu dois choisir \(4 - numberOfFighter) Fighters : ")
        }
        print("\n1. 🗡 Donne moi un combattant"
            + "\n2. 👨‍🎤 Donne moi un nain"
            + "\n3. 👹 Donne moi un colosse"
            + "\n4. 🧙‍♀️ Donne moi un magicien"
            + "\n5. 💻 Voir les caractéristiques des personnages")
        
        if let choiceMenu1 = readLine() {
            switch choiceMenu1 {
            case "1":
                let fighterChoosen = "Combattant"
                addFighter(category: fighterChoosen)
            case "2":
                let fighterChoosen = "Nain"
                addFighter(category: fighterChoosen)
            case "3":
                let fighterChoosen = "Colosse"
                addFighter(category: fighterChoosen)
            case "4":
                let fighterChoosen = "Magicien"
                if numberOfWizard >= 2 {
                    print("Désolé, vous ne pouvez pas choisir que des magiciens dans votre Team ;)")
                    chooseFighter()
                }
                addFighter(category: fighterChoosen)
            case "5":
                print("Voici les caractéristiques des personnages :"
                    + "\n 🗡 Le combattant : PV : 100, Dégâts : 10, Action : 1, spécial : Double Attaque"
                    + "\n 👨‍🎤 Le nain : PV : 80, Arme : Hâche, Dégâts : 20, Action : 1, spécial : Double Dégâts"
                    + "\n 👹 Le colosse : PV : 200, Dégâts : 5, Action : 1, spécial : Frayeur (Adversaire perd son tour)"
                    + "\n 🧙‍♀️ Le magicien : PV : 150, Soins : +15, Action : 1, spécial : FireBall dégâts 30")
                
                print("Presser une touche pour continuer")
                if let _ = readLine() {
                    chooseFighter()
                }
            default:
                print("Je n'ai pas compris ton choix")
                chooseFighter()
            }
            
        }
        numberOfFighter += 1
        // Add choice into an instance of Class Fighter
        // depend of the gamer (numberOfTeam) and of the numberOfFighter
        print ("\r\rTeam \(userArray[numberOfTeam].teamName) Voici ton tableau de combattants mis à jour :")
        
        if numberOfTeam == 0 {
            for i in 0...fighterArrayP1.count - 1{
                print("🔴Le \(fighterArrayP1[i].category) : \(fighterArrayP1[i].name)")
            }
        } else {
            for i in 0...fighterArrayP2.count - 1 {
                print("🔵Le \(fighterArrayP2[i].category) : \(fighterArrayP2[i].name)")
            }
        }
    }
    print("Tu as choisi \(numberOfFighter - 1) fighters")
    numberOfFighter = 1
}



/**
 addFighter : In this function : Adding fighter in the good user Array
 */
func addFighter(category: String) {
    
    print("\rOk pour le \(category) !")
    let nameOfTheFighterOk = nameOfTheFighter()
    let numberFetichOk = numberFetich()
    var fighterInLoad = Fighter(name: "", numberFetich: 0)
    switch category {
    case "Combattant":
        fighterInLoad = Warrior(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case "Nain":
        fighterInLoad = Dwarf(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case "Colosse":
        fighterInLoad = Colossus(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case "Magicien":
        fighterInLoad = Wizard(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
        numberOfWizard += 1
    default:
        fighterInLoad = Fighter(name: "DEFAULT", numberFetich: 5)
    }
    if numberOfTeam == 0 {
        fighterArrayP1.append(fighterInLoad)
    } else if numberOfTeam == 1 {
        fighterArrayP2.append(fighterInLoad)
    }
}



/**
 nameOfTheFighter : ask name of the fighter
 */
func nameOfTheFighter() -> String {
    var nameOfTheFighterOk = ""
    repeat {
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
func numberFetich() -> Int {
    let numberTestOk = ""
    repeat {
        print("Quel est ton numéro fétiche entre 1 et 9 ")
        if let numberTest = readLine() {
            if let numberTestOk = Int(numberTest) {
                if numberTestOk > 0, numberTestOk < 10 {
                    return numberTestOk
                } else {
                    print("Le chiffre doit être supérieur à 0, et inférieur à 10")
                }
            } else {
                print("Cela ne peut être qu'un numéro !")
            }
            
        } else {
            print("Tu dois donner un numéro fétiche à ton Fighter dans la fonction numberTest ;)")
        }
    } while numberTestOk == ""
    return 1
}




/**
 battleMode : Step by step : We have to choose attacker, chest, Fetich zone, Defendeur, Bonus Zone
 */
func battleMode() {
    print("\r\r\r\r\r😈😈 Tous les combattants sont choisis : Presser une touche pour que le WANHAMMER commence !😈😈 ")
    if let _ = readLine() {
        
        
        checkAllTeamLifePoint()
        
        print("Appuyer sur la touche ENTRER pour continuer")
        if let _ = readLine() {
            
            
            // You can check the last action // have to create lastActionArray who stock and give the last Action if there is a last Action
            // var lastActionArray = [Any]()
            var countAction = 0
            
            
            //necessary variable to create battle round
            var lifePointP1 = fighterArrayP1[0].lifePoint + fighterArrayP1[1].lifePoint + fighterArrayP1[2].lifePoint
            var lifePointP2 = fighterArrayP2[0].lifePoint + fighterArrayP2[1].lifePoint + fighterArrayP2[2].lifePoint
            //Variable for random choice, or logical choice
            var randomInt : Int = 1
            
            
            // LOOP HERE IF THERE IS AT LEAST ONE FIGHTER ALIVE IN EACH TEAM
            while lifePointP1 > 0, lifePointP2 > 0 {
                
                //Random choice for the First Player who give the first attack
                if countAction == 0 {
                    randomInt = Int.random(in: 1..<3)
                }
                
                
                if let _ = readLine() {
                    // You have to choose which fighter do an action
                    var damageInLoad = choiceAttackFrom(randomInt: randomInt)
                    
                    
                    // Sometimes, you take new weapon at the beginning of the round with a random chest
                    if let resultGift = randomChest(randomInt: randomInt, damageInLoad : damageInLoad) {
                        if resultGift != "" {
                            print("Tu aperçois au sol \(resultGift), et tu t'en équipes !")
                            if randomInt == 1 {
                                print("Grâce à cela, ta puissance d'action est passée à : \(fighterArrayP1[attackerNumber].strenght) ")
                                damageInLoad = fighterArrayP1[attackerNumber].strenght //update damageInLoad variable value
                            } else if randomInt == 2 {
                                print("Grâce à cela, ta puissance d'action est passée à : \(fighterArrayP2[attackerNumber].strenght) ")
                                damageInLoad = fighterArrayP2[attackerNumber].strenght  //update damageInLoad variable value
                            }
                            
                        }
                    }
                    
                   
                    
                    //here we have the fetich number to add
                    
                    if let resultFetich = randomFetichNumber(randomInt: randomInt) {
                        var category = ""
                        if resultFetich == true { // if the fetichNumber was selected
                            if randomInt == 1 { // for the team One, take the category
                                category = fighterArrayP1[attackerNumber].category
                            } else if randomInt == 2 { // for the team 2
                                category = fighterArrayP2[attackerNumber].category
                            }
                            
                            switch category {
                            case "Combattant":
                                specialWarrior = true
                            case "Nain":
                                print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tFETICH TIME !"
                                    + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre nain est en forme, il affligera double dégâts ce tour-ci !")
                                damageInLoad += damageInLoad
                            case "Colosse":
                                specialColossus = true
                            case "Magicien":
                                specialWizardOn = true
                            default:
                                print("Pas d'action Fétiche ce tour ci ^^")
                            }
                            
                        }
                    }
                    
                    
                    
                    // You have to choose which opponent on the action will be done
                    choiceDefender(randomInt: randomInt, damageInLoad: damageInLoad)
                    
                    
                    
                    
                    countAction += 1
                    // TO SWITCH PLAYER ATTACK
                    if randomInt == 1 {
                        randomInt = 2
                    } else {
                        randomInt = 1
                    }
                    
                    
                    // PARTY IS DONE WHEN ALL THE FIGHTER OF ONE TEAM ARE DEAD
                    lifePointP1 = fighterArrayP1[0].lifePoint + fighterArrayP1[1].lifePoint + fighterArrayP1[2].lifePoint
                    lifePointP2 = fighterArrayP2[0].lifePoint + fighterArrayP2[1].lifePoint + fighterArrayP2[2].lifePoint
                    
                    if countAction != 0 {
                        actionPrint(lifePointP1: lifePointP1, lifePointP2: lifePointP2)
                    }
                    
                    
                    //SPECIAL FETICH for the Warrior : Double Attack, so launch second attack after firstDamage
                    if specialWarrior == true {
                        print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tFETICH TIME !"
                            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre combattant possède une deuxième attaque")
                        // TO SWITCH PLAYER ATTACK
                        if randomInt == 1 {
                            randomInt = 2
                        } else {
                            randomInt = 1
                        }
                        choiceDefender(randomInt: randomInt, damageInLoad: damageInLoad)
                        actionPrint(lifePointP1: lifePointP1, lifePointP2: lifePointP2)
                        // TO SWITCH PLAYER ATTACK
                        if randomInt == 1 {
                            randomInt = 2
                        } else {
                            randomInt = 1
                        }
                    }
                    
                    // SPECIAL FETICH for the Colossus : entiere Double Turn
                    if specialColossus == true {
                        print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tFETICH TIME !"
                            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre Colosse a fait peur a vos adversaires, vous avez droit à un deuxième tour")
                        // TO SWITCH PLAYER ATTACK
                        if randomInt == 1 {
                            randomInt = 2
                        } else {
                            randomInt = 1
                        }
                        damageInLoad = choiceAttackFrom(randomInt: randomInt)
                        choiceDefender(randomInt: randomInt, damageInLoad: damageInLoad)
                        actionPrint(lifePointP1: lifePointP1, lifePointP2: lifePointP2)
                    }
                    
                    // SPECIAL FETICH for the Magician : Loop damage for all the opponent lifePoint Array
                    if specialWizardOn == true {
                        print("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tFETICH TIME !"
                            + "\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVotre magicien envoi une Fireball et enlève 10 points de dommages à toute l'équipe adversaire")
                        if randomInt == 1 { // for the team One
                            for i in 0..<fighterArrayP1.count {
                                print("\(fighterArrayP1[i].name) le \(fighterArrayP1[i].category) se retrouve à \(fighterArrayP1[i].lifePoint - 10)")
                                fighterArrayP1[i].lifePoint -= 10
                            }
                        } else if randomInt == 2 { // for the team 2
                            for i in 0..<fighterArrayP2.count {
                                print("\(fighterArrayP2[i].name) le \(fighterArrayP2[i].category) se retrouve à \(fighterArrayP2[i].lifePoint - 10)")
                                fighterArrayP2[i].lifePoint -= 10
                            }
                        }
                    }
                    
                    
                    // initialisation of special var
                    specialWizardOn = false
                    specialColossus = false
                    specialWarrior = false
                    
                    
                    
                    // BONUS ZONE :
                    // If you're lucky, you can use your special attack
                    // If you're lucky ++  you can use a critical attack
                    // If you're really bad, your CRITICAL ATTACK is missed, and your attack is not on the opponent but on one of your fighter        let randomNumberChest = Int.random(in: 1..<5)
                    let randomBonusZone = Int.random(in: 0..<11)
                    var category = ""
                    if randomBonusZone == 10 {
                        if randomInt == 1 { // for the team One, take the category
                            category = fighterArrayP1[attackerNumber].category
                        } else if randomInt == 2 { // for the team 2
                            category = fighterArrayP2[attackerNumber].category
                        }
                        switch category {
                        case "Combattant":
                            print("Afficher une histoire avec le combattant qui tue l'un des personnages adversaires au hasard")
                        case "Nain":
                            print("Afficher une histoire avec le nain qui tue l'un des personnages adversaires au hasard")
                        case "Colosse":
                            print("Afficher une histoire avec le colosse qui tue l'un des personnages adversaires au hasard")
                        case "Magicien":
                            print("Afficher une histoire avec le magicien qui réduit de moitié les points adversaires pour les donner à ses fighters")
                        default:
                            print("Pas d'action BONUS ce tour ci ^^")
                        }
                        
                    }
                    if randomBonusZone == 1 {
                        if randomInt == 1 { // for the team One, take the category
                            category = fighterArrayP1[attackerNumber].category
                        } else if randomInt == 2 { // for the team 2
                            category = fighterArrayP2[attackerNumber].category
                        }
                        switch category {
                        case "Combattant":
                            print("Afficher une histoire avec le combattant qui se tue lui meme sans faire exprès")
                        case "Nain":
                            print("Afficher une histoire avec le nain qui se tue lui meme sans faire exprès")
                        case "Colosse":
                            print("Afficher une histoire avec le colosse qui se tue lui meme sans faire exprès")
                        case "Magicien":
                            print("Afficher une histoire avec le magicien qui rate un sort et fait perdre la moitié des points de vie pour les donner à ses adversaires")
                        default:
                            print("Pas d'action Bonus ce tour ci ^^")
                        }
                        
                    }
                }
                
            }
            print("La partie est terminée :")
            print("🔴Score final de la team \(userArray[0].teamName) du joueur \(userArray[0].gamerName) : \(lifePointP1)")
            print("🔵Score final de la team \(userArray[1].teamName) du joueur \(userArray[1].gamerName) : \(lifePointP2)")
        }
    }
}




/**
 choiceAttackFrom : Here we have to choose the Attacker
 */
func choiceAttackFrom(randomInt: Int) -> Int {
    
    if randomInt == 1 {
        print("\r\r\r🔴\(userArray[0].gamerName) : Avec quel Fighter désires tu agir ?")
        // TEST LOOP FOR TO ASK A QUESTION
        for nAttack in 0..<fighterArrayP1.count {
            if fighterArrayP1[nAttack].lifePoint > 0 {
                print("🔴\(nAttack + 1). Avec \(fighterArrayP1[nAttack].name) le \(fighterArrayP1[nAttack].category) ")
            }
        }
    } else {
        print("\r\r\r🔵\(userArray[1].gamerName) : Avec quel Fighter désires tu agir ?")
        // TEST LOOP FOR TO ASK A QUESTION
        for nAttack in 0..<fighterArrayP2.count  {
            if fighterArrayP2[nAttack].lifePoint > 0 {
                print("🔵\(nAttack + 1). Avec \(fighterArrayP2[nAttack].name) le \(fighterArrayP2[nAttack].category) ")
            }
        }
    }
    
    if let choiceAttacker = readLine() {
        if let choiceAttackerLoop = Int(choiceAttacker) {
            switch choiceAttackerLoop {
            case choiceAttackerLoop:
                if randomInt == 1 {
                    let damageInLoad = fighterArrayP1[choiceAttackerLoop - 1].strenght
                    actionArray[0] = userArray[0].teamName
                    actionArray[1] = fighterArrayP1[choiceAttackerLoop - 1].name
                    actionArray[2] = fighterArrayP1[choiceAttackerLoop - 1].category
                    actionArray[3] = fighterArrayP1[choiceAttackerLoop - 1].lifePoint
                    // Update bool checkCategory for using Chest option
                    if fighterArrayP1[choiceAttackerLoop - 1].category == "Magicien" {
                        checkCategory = true
                        
                    } else {
                        checkCategory = false
                    }
                    // keep "choiceAttackerLoop - 1" in variable to use for Chest modification value
                    attackerNumber = choiceAttackerLoop - 1
                    return damageInLoad
                } else if randomInt == 2 {
                    let damageInLoad = fighterArrayP2[choiceAttackerLoop - 1].strenght
                    actionArray[0] = (userArray[1].teamName)
                    actionArray[1] = fighterArrayP2[choiceAttackerLoop - 1].name
                    actionArray[2] = fighterArrayP2[choiceAttackerLoop - 1].category
                    actionArray[3] = fighterArrayP2[choiceAttackerLoop - 1].lifePoint
                    // Update bool checkCategory for using Chest option
                    if fighterArrayP2[choiceAttackerLoop - 1].category == "Magicien" {
                        checkCategory = true
                    } else {
                        checkCategory = false
                    }
                    // keep "choiceAttackerLoop - 1" in variable to use for Chest modification value
                    attackerNumber = choiceAttackerLoop - 1
                    return damageInLoad
                }
            default: print("Je n'ai pas compris qui donne l'attaque. On recommence : ")
            }
        }
        //   }
    }
    return choiceAttackFrom(randomInt: randomInt)
}




/**
 randomChest : Random Chest appear   and content its different (depend of Wizard or no)
 */
func randomChest(randomInt : Int, damageInLoad : Int) -> String? {
    
    
    let weaponChestContent = ["une épée dorée","une hâche de Rahan","une grenade","un fléau d'arme","un tire-bouchon"]
    let newValueWeaponChestContent = [15,25,30,25,5]
    let healthChestContent = ["une purée de brocoli","une barre protéinée","une whey à la banane","une framboise fraiche","un BigMac"]
    let newValueHealthChestContent = [15,25,30,25,5]
    
    
    var resultGift = ""
    
    let randomNumberChest = Int.random(in: 1..<5)
    if randomNumberChest == 2 {
        print("MICHEL MICHEL : Voir pour améliorer le code, il y a plein de doublon")
        print("\r\rWaooow ! Quelle chance :")
        if checkCategory == false { // if it's not a wizard
            let resultGiftNumber = Int(arc4random_uniform(UInt32(weaponChestContent.count)))
            resultGift = weaponChestContent[resultGiftNumber]
            let resultStrenght = newValueWeaponChestContent[resultGiftNumber]
            if randomInt == 1 { //if it's TEAM 1
                fighterArrayP1[attackerNumber].strenght = resultStrenght
                fighterArrayP1[attackerNumber].weapon = resultGift
            } else { //if it's TEAM 2
                fighterArrayP2[attackerNumber].strenght = resultStrenght
                fighterArrayP2[attackerNumber].weapon = resultGift
            }
            
        } else if checkCategory == true { // if it's Dwarf/Colossus/Warrior : Use other array
            let resultGiftNumber = Int(arc4random_uniform(UInt32(healthChestContent.count)))
            resultGift = healthChestContent[resultGiftNumber]
            let resultHealth = newValueHealthChestContent[resultGiftNumber]
            if randomInt == 1 {
                fighterArrayP1[attackerNumber].strenght = resultHealth
                fighterArrayP1[attackerNumber].weapon = resultGift
            } else {
                fighterArrayP2[attackerNumber].strenght = resultHealth
                fighterArrayP2[attackerNumber].weapon = resultGift
            }
        }
        return resultGift
    }
    return resultGift
}


/**
 randomFetichNumber : Check random Fetich number : If it's ok : resultFetich Bool become true and special action will be proposed
 */
func randomFetichNumber(randomInt : Int) -> Bool? {
    var resultFetich = false
    let randomFetichNumber = Int.random(in: 1..<11)
    
    if randomInt == 1 {
        if randomFetichNumber == fighterArrayP1[attackerNumber].numberFetich {
            resultFetich = true
        }
    } else if randomInt == 2 {
        if randomFetichNumber == fighterArrayP2[attackerNumber].numberFetich {
            resultFetich = true
        }
    }
    return resultFetich
}




/**
 healOrAttackFighter : To list with optimized code if it's an attack or a care (depend of FighterArray P1 or P2, and Category : Wizard or no)
 */
func healOrAttackFighter(fighterArray: [Fighter], checkCategory: Bool) {
    
    for nDefend in 0..<fighterArray.count {
        if fighterArray[nDefend].lifePoint > 0 {
            if !checkCategory {
                print("💢\(nDefend + 1). Attaque sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
            } else {
                print("💢\(nDefend + 1). Soin sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
            }
        }
    }
}



/**
 choiceDefender : Who receive the attack or the Care
 */
func choiceDefender(randomInt: Int, damageInLoad: Int) {
    
    if !checkCategory { // if it's not a Wizard
        if randomInt == 1 {
            print("\r\(userArray[0].gamerName) : Quel Fighter adversaire désires tu endommager ?")
            healOrAttackFighter(fighterArray: fighterArrayP2, checkCategory: checkCategory)
        } else {
            print("\r\(userArray[1].gamerName) : Quel Fighter adversaire désires tu endommager ?")
            healOrAttackFighter(fighterArray: fighterArrayP1, checkCategory: checkCategory)
        }
    } else {
        if randomInt == 1 {
            print("\r\(userArray[0].gamerName) : Quel Fighter de ta team désires tu soigner ?")
            healOrAttackFighter(fighterArray: fighterArrayP1, checkCategory: checkCategory)
        } else {
            print("\r\(userArray[1].gamerName) : Quel Fighter de ta team désires tu soigner  ?")
            healOrAttackFighter(fighterArray: fighterArrayP2, checkCategory: checkCategory)
        }
    }
    
    
    
    if let choiceDefender = readLine() {
        if let choiceDefenderLeRetour = Int(choiceDefender) {
            switch choiceDefenderLeRetour {
                //LOOP FOR CASE SITUATION
                //APPLY DAMAGE TO THE GOOD FIGHTER
            // Add History in actionArray
            case choiceDefenderLeRetour:
                if !checkCategory {  //if it's not Wizard
                    if randomInt == 1 { // if it's the team 1
                        fighterArrayP2[choiceDefenderLeRetour - 1].lifePoint -= damageInLoad // give damage to the team2
                        actionArray[4] = userArray[1].teamName
                        actionArray[5] = fighterArrayP2[choiceDefenderLeRetour - 1].name
                        actionArray[6] = fighterArrayP2[choiceDefenderLeRetour - 1].category
                        actionArray[7] = fighterArrayP2[choiceDefenderLeRetour - 1].lifePoint
                    } else {
                        fighterArrayP1[choiceDefenderLeRetour - 1].lifePoint -= damageInLoad
                        actionArray[4] = userArray[0].teamName
                        actionArray[5] = fighterArrayP1[choiceDefenderLeRetour - 1].name
                        actionArray[6] = fighterArrayP1[choiceDefenderLeRetour - 1].category
                        actionArray[7] = fighterArrayP1[choiceDefenderLeRetour - 1].lifePoint
                    }
                } else {  //if it's a Wizard
                    if randomInt == 1 { // if it's the team 1
                        fighterArrayP1[choiceDefenderLeRetour - 1].lifePoint += damageInLoad // give damage to the team2
                        actionArray[4] = userArray[0].teamName
                        actionArray[5] = fighterArrayP1[choiceDefenderLeRetour - 1].name
                        actionArray[6] = fighterArrayP1[choiceDefenderLeRetour - 1].category
                        actionArray[7] = fighterArrayP1[choiceDefenderLeRetour - 1].lifePoint
                    } else {
                        fighterArrayP2[choiceDefenderLeRetour - 1].lifePoint += damageInLoad
                        actionArray[4] = userArray[1].teamName
                        actionArray[5] = fighterArrayP2[choiceDefenderLeRetour - 1].name
                        actionArray[6] = fighterArrayP2[choiceDefenderLeRetour - 1].category
                        actionArray[7] = fighterArrayP2[choiceDefenderLeRetour - 1].lifePoint
                    }
                }
                
            default: print("Je n'ai pas compris qui reçoit le coup. On recommence : ")
            }
        }
    }
}








/**
 checkAllTeamLifePoint : Print the array of the team to check LifePoint of each Fighters
 */
func checkAllTeamLifePoint() {
    // You can check life point of each fighters
    print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")
    print("🔴Voici l'état actuel de chaque fighters de la team \(userArray[0].teamName)")
    for i in 0..<fighterArrayP1.count  {
        print("🔴Le \(fighterArrayP1[i].category) \(fighterArrayP1[i].name) possède \(fighterArrayP1[i].lifePoint) PV")
    }
    print("🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")
    print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵")
    print("🔵Voici l'état actuel de chaque fighters de la team \(userArray[1].teamName)")
    for i in 0..<fighterArrayP1.count  {
        print("🔵Le \(fighterArrayP2[i].category) \(fighterArrayP2[i].name) possède \(fighterArrayP2[i].lifePoint) PV")
    }
    print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵")
}



/**
 actionPrint : Use the actionArray to give history of the last attack and (damage or care)
 */
func  actionPrint(lifePointP1: Int, lifePointP2: Int) {
    
    print("\r\t\t\t\t\t\t\t\t\t\t\tVoici la dernière action réalisée :"
        + "\r\t\t\t\t\t\t\t\t\t\t\tLa team \(actionArray[0]) avec \(actionArray[1]) le \(actionArray[2])"
        + "\r\t\t\t\t\t\t\t\t\t\t\ta fait son action sur \(actionArray[5]) le \(actionArray[6]) de la team \(actionArray[4])."
        + "\r\t\t\t\t\t\t\t\t\t\t\tIl possède maintenant \(actionArray[7]) point de vies")
    print("\r\t\t\t\t\t\t\t\t\t\t\t🔴Score actuel de la team \(userArray[0].teamName) du joueur \(userArray[0].gamerName) : \(lifePointP1)")
    print("\r\t\t\t\t\t\t\t\t\t\t\t🔵Score actuel de la team \(userArray[1].teamName) du joueur \(userArray[1].gamerName) : \(lifePointP2)")
    
}



// LOOP FOR THE PROGRAM


while stayInProgram == true {
    principalMenu()
}
