//
//  main.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation


// MARK: var declaration
var stayInProgram = true // BOOL to stay in program
var numberOfTeam = 0 // to switch team One and team Two
var numberOfWizard = 0 // Because we can't have only Wizard in a team
var numberOfFighter = 1 // to stop at 3 fighters
var checkCategory = false
var attackerNumber = 0
var defenderNumber = 0
var defenderRandomNumber = 0
var specialFetichAction = false
let  historyPrint = History()
var fromUnluckZone = false
var bonusOrUnluckZone = false
var nDefendAlive = 0
var nAttackAlive = 0
var alreadyDead = false




// MARK: Array declaration
var fighterArrayP1 = [Fighter]()   // for the team1
var fighterArrayP2 = [Fighter]()  // for the team2
var userArray = [Team]()  //  to archive User's Name / total LifePoint / Round Win and loose
var arrayGoodIndex = [0,1,2]



/**
 principalMenu : ask if User want to stay or quit program
 */
func principalMenu() {
    //Start With "Welcome print"
    print("Bienvenue dans le WANHAMMER")
    print("\rQue voulez vous faire ?"
        + "\n1. ▶ Entrer dans le WANHAMMER"
        + "\n2. ❌ Je ne veux pas me battre"
        + "\n3. Attribution auto des équipes")
    
    if let choiceMenu1 = readLine() {
        switch choiceMenu1 {
        case "1":
            userInput()
            battleMode()
            print("Fonction à ajouter")
        case "2":
            print("Lâcheur ! 😜")
            stayInProgram = false
        case "3":
            demoMode()
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
                addFighter(category: Category.warrior)
            case "2":
                addFighter(category: Category.dwarf)
            case "3":
                addFighter(category: Category.colossus)
            case "4":
                if numberOfWizard >= 2 {
                    print("Désolé, vous ne pouvez pas choisir que des magiciens dans votre Team ;)")
                    chooseFighter()
                }
                addFighter(category: Category.wizard)
            case "5":
                print("Voici les caractéristiques des personnages :"
                    + "\n 🗡 Le combattant : PV : 100, Dégâts : 10, Action : 1, spécial : Double Attaque"
                    + "\n 👨‍🎤 Le nain : PV : 80, Arme : Hâche, Dégâts : 20, Action : 1, spécial : Double Dégâts"
                    + "\n 👹 Le colosse : PV : 200, Dégâts : 5, Action : 1, spécial : Frayeur (Adversaire perd son tour)"
                    + "\n 🧙‍♀️ Le magicien : PV : 150, Soins : +15, Action : 1, spécial : FireBall dégâts 30")
                
                print("Presser une touche pour continuer")
                if readLine() != nil {
                    chooseFighter()
                }
            default:
                print("Je n'ai pas compris ton choix")
                chooseFighter()
            }
        }
        // numberOfFighter += 1
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
    numberOfFighter += 1
    }
    print("Tu as choisi \(numberOfFighter - 1) fighters")
    numberOfFighter = 1
}



/**
 addFighter : In this function : Adding fighter in the good user Array
 */
func addFighter(category: Category) {
    
    print("\rOk pour le \(category) !")
    let nameOfTheFighterOk = nameOfTheFighter()
    let numberFetichOk = numberFetich()
    var fighterInLoad = Fighter(name: "", numberFetich: 0)
    switch category {
    case .warrior:
        fighterInLoad = Warrior(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case .dwarf:
        fighterInLoad = Dwarf(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case .colossus:
        fighterInLoad = Colossus(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
    case .wizard:
        fighterInLoad = Wizard(name: nameOfTheFighterOk, numberFetich: numberFetichOk)
        numberOfWizard += 1
    }
    if numberOfTeam == 0 { // add new object in the good Array depend of it's the TEAM 1 or the TEAM 2
        fighterArrayP1.append(fighterInLoad)
    } else if numberOfTeam == 1 {
        fighterArrayP2.append(fighterInLoad)
    }
}



/**
 nameOfTheFighter : ask name of each fighter
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
        print("Quel est ton numéro fétiche entre 1 et 5 ")
        if let numberTest = readLine() {
            if let numberTestOk = Int(numberTest) {
                if numberTestOk > 0, numberTestOk < 6 {
                    return numberTestOk
                } else {
                    print("Le chiffre doit être supérieur à 0, et inférieur à 6")
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
    if readLine() != nil {
        
        lifePointConvert() // initialize userArray[].Lifepoint value to check if one TEAM is DEAD
        checkAllTeamLifePoint() // Print all the fighters LifePoint
        print("Appuyer sur la touche ENTRER pour continuer")
        
        if readLine() != nil {
            var countAction = 0 // initialize countAction to check if it's the first Round
            var randomInt : Int = 1 //Variable for random choice, or logical choice
            while userArray[0].lifeTeam > 0 || userArray[1].lifeTeam  > 0 { // LOOP HERE IF THERE IS AT LEAST ONE FIGHTER ALIVE IN EACH TEAM
                if countAction == 0 { //Random choice for the First Player who give the first attack
                    randomInt = Int.random(in: 1..<3)
                }
                if readLine() != nil {
                    // CHOICE ATTACKER MENU
                    historyPrint.hAttackerFActionStrenght = choiceAttackFrom(randomInt: randomInt)
                    
                    // RANDOM CHEST : Sometimes, you take new weapon at the beginning of the round with a random chest
                    randomChest(randomInt: randomInt)
                    
                    //FETICH NUMBER BONUS : Have to take before DEFENDER CHOICE because of the dwarf (double damage action)
                    randomFetichNumber(randomInt: randomInt)
                    
                    // CHOICE DEFENDER MENU
                    choiceDefender(randomInt: randomInt, damageInLoad: historyPrint.hAttackerFActionStrenght)
                    
                    // one damage or care has been done : countAction have to be increase
                    countAction += 1
                    
                    // print Result only if at least one action was ok
                    if countAction != 0 {
                        historyPrint.actionPrint(resultBonusToPrint: "")
                    }
                    
                    // APPLY FETICH BONUS FOR THE OTHERS ATTACKERS (Warrior, Colossus, Wizard)
                    applyFetichBonus(randomInt: randomInt)
                }
                
                
                if readLine() != nil {
                    // BONUS UNLUCK ZONE : If you're lucky, you can use your critical attack, if not you do an unlucky action
                    randomBonus(randomInt: randomInt)
                    
                    // TO SWITCH PLAYER ATTACK
                    if randomInt == 1 {
                        randomInt = 2
                    } else {
                        randomInt = 1
                    }
                }
            }
            print("La partie est terminée :")
            print("🔴Score final de la team \(userArray[0].teamName) du joueur \(userArray[0].gamerName) : \(fighterArrayP1[0].lifePoint + fighterArrayP1[1].lifePoint + fighterArrayP1[2].lifePoint)")
            print("🔵Score final de la team \(userArray[1].teamName) du joueur \(userArray[1].gamerName) : \(fighterArrayP2[0].lifePoint + fighterArrayP2[1].lifePoint + fighterArrayP2[2].lifePoint)")
            addWinAndLooseValue()
            
        }
    }
}


/**
 loopChoiceAttackFrom : Func to print the attacker list with a loop
 */

func loopChoiceAttackFrom(fighterArray : [Fighter]) {
    
    for nAttack in 0..<fighterArray.count {
        if fighterArray[nAttack].lifePoint > 0 {  // print only if the fighter is not dead
            nAttackAlive += 1 // to print the number : increase 1 2 3 ...
            arrayGoodIndex[nAttackAlive - 1] = nAttack // archive the good index to keep the good one in the fighterArrayP1 or P2
            print("\(nAttackAlive). \(fighterArray[nAttack].name) le \(fighterArray[nAttack].category) avec \(fighterArray[nAttack].weapon) de puissance \(fighterArray[nAttack].strenght), reste PV : \(fighterArray[nAttack].lifePoint)")
        }
    }
}





/**
 choiceAttackFrom : Here we have to choose the Attacker
 */
func choiceAttackFrom(randomInt: Int) -> Int {
    
    nAttackAlive = 0 // reset to check good choice while fighters were dead
    if randomInt == 1 {
        print("\r\r\r🔴\(userArray[0].gamerName) de la Team \(userArray[0].teamName) : Il te reste \(userArray[0].lifeTeam) PV"
            + "\r Avec quel Fighter désires tu agir ?")
        loopChoiceAttackFrom(fighterArray: fighterArrayP1)
    } else {
        print("\r\r\r🔵\(userArray[1].gamerName) de la Team \(userArray[1].teamName) : Il te reste \(userArray[1].lifeTeam) PV"
            + "\r Avec quel Fighter désires tu agir ?")
        loopChoiceAttackFrom(fighterArray: fighterArrayP2)
    }
    
    if let choiceAttacker = readLine() { // Check User Choice
        if var choiceAttackerLoop = Int(choiceAttacker) {
            if choiceAttackerLoop <= 0 || choiceAttackerLoop > nAttackAlive {
                print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                return choiceAttackFrom(randomInt: randomInt)
            }
            choiceAttackerLoop = arrayGoodIndex[choiceAttackerLoop - 1]
            switch choiceAttackerLoop {
            case choiceAttackerLoop:
                if randomInt == 1 {
                    UpdateHistoryAttacker(choiceAttackerLoop: choiceAttackerLoop, fighterArray : fighterArrayP1, userTeamName : userArray[0].teamName )
                } else if randomInt == 2 {
                    UpdateHistoryAttacker(choiceAttackerLoop: choiceAttackerLoop, fighterArray : fighterArrayP2, userTeamName : userArray[1].teamName )
                }
                attackerNumber = choiceAttackerLoop // keep  in variable to use for Chest modification value
                if historyPrint.hAttackerFCategory == "Magicien" {
                    checkCategory = true
                } else {
                    checkCategory = false
                }
                return historyPrint.hAttackerFActionStrenght
            default: print("Je n'ai pas compris qui donne l'attaque. On recommence : ")
            }
        }
        print("Vous devez choisir un chiffre attaquant. On recommence : ")
        return choiceAttackFrom(randomInt: randomInt)
    }
    return choiceAttackFrom(randomInt: randomInt)
}



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
 randomChest : Random Chest appear   and content its different (depend of Wizard or no)
 */
func randomChest(randomInt : Int) {
    
    // Array Chest Content and value
    let weaponChestContent = ["une épée dorée","une hâche de Rahan","une grenade","un fléau d'arme","un tire-bouchon"]
    let healthChestContent = ["une purée de brocoli","une barre protéinée","une whey à la banane","une framboise fraiche","un BigMac"]
    let newValueWeaponChestContent = [15,25,30,25,5]
    
    var resultGift = ""
    let randomNumberChest = Int.random(in: 1..<3)
    if randomNumberChest == 2 {
        print("\r\rWaooow ! Quelle chance !! Un coffre est apparu devant toi !")
        if !checkCategory  { // if it's Dwarf/Colossus/Warrior : USE weaponChestContent
            let resultGiftNumber = Int(arc4random_uniform(UInt32(weaponChestContent.count)))
            resultGift = weaponChestContent[resultGiftNumber]
            let resultStrenght = newValueWeaponChestContent[resultGiftNumber]
            if randomInt == 1 { //if it's TEAM 1  take strenght in P1
                updateStrenghtAndWeapon(fighterArray: fighterArrayP1, attackerNumber: attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
            } else { //if it's TEAM 2  take strenght in P2
                updateStrenghtAndWeapon(fighterArray: fighterArrayP2, attackerNumber: attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
            }
        } else if checkCategory { // if it's a wizard : : USE healthChestContent
            let resultGiftNumber = Int(arc4random_uniform(UInt32(healthChestContent.count)))
            resultGift = healthChestContent[resultGiftNumber]
            let resultStrenght = newValueWeaponChestContent[resultGiftNumber]
            if randomInt == 1 { //if it's TEAM 1  take strenght in P1
                updateStrenghtAndWeapon(fighterArray: fighterArrayP1, attackerNumber: attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
            } else { //if it's TEAM 2  take strenght in P2
                updateStrenghtAndWeapon(fighterArray: fighterArrayP2, attackerNumber: attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
            }
        }
        if resultGift != "" {
            print("C'est \(resultGift) ! Tu t'en équipes !"
            + "Ta puissance d'action est maintenant de : \(historyPrint.hAttackerFActionStrenght)")
        }
    }
}



/**
 updateStrenghtAndWeapon : For update the weapon and Strenght of the good FighterArray with the good GIFT
 */

func updateStrenghtAndWeapon(fighterArray: [Fighter], attackerNumber: Int, resultStrenght: Int, resultGift: String) {
    
    fighterArray[attackerNumber].strenght = resultStrenght
    historyPrint.hAttackerFActionStrenght = fighterArray[attackerNumber].strenght
    fighterArray[attackerNumber].weapon = resultGift
    
}


/**
 randomFetichNumber : Check random Fetich number : If it's ok : resultFetich Bool become true and special action will be proposed
 */
func randomFetichNumber(randomInt : Int) {
    
    var fetichOk = false
    
    let randomFetichNumber = Int.random(in: 1..<6)
    if randomInt == 1 {
        if randomFetichNumber == fighterArrayP1[attackerNumber].numberFetich {
            fetichOk = true
        }
    }
    if randomInt == 2 {
        if randomFetichNumber == fighterArrayP2[attackerNumber].numberFetich {
            fetichOk = true
        }
    }
    
    if fetichOk {
        
        switch historyPrint.hAttackerFCategory {
        case "Combattant":
            specialFetichAction = true
        case "Nain":
            let specialInLoad = Dwarf(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
            specialInLoad.specialDwarf()
        case "Colosse":
            specialFetichAction = true
        case "Magicien":
            specialFetichAction = true
        default:
            print("Pas d'action Fétiche ce tour ci ^^")
        }
    }
}


/**
 applyFetichBonus : The Dwarf have already apply his double damage if he find FetichNumber...but for the other : We need another function
 */
func applyFetichBonus(randomInt : Int) {
    
    //SPECIAL FETICH for the Warrior : Double Attack, so launch second attack after firstDamage
    if specialFetichAction == true,  historyPrint.hAttackerFCategory == "Combattant" {
        let specialInLoad = Warrior(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
        specialInLoad.specialWarrior(randomInt: randomInt, damageInLoad: historyPrint.hAttackerFActionStrenght, resultBonusToPrint: "")
    }
    
    // SPECIAL FETICH for the Colossus : entiere Double Turn
    if specialFetichAction == true,  historyPrint.hAttackerFCategory == "Colosse" {
        let specialInLoad = Colossus(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
        specialInLoad.specialColossus(randomInt: randomInt, damageInLoad: historyPrint.hAttackerFActionStrenght, resultBonusToPrint: "")
    }
    
    // SPECIAL FETICH for the Magician : Loop damage for all the opponent lifePoint Array
    if specialFetichAction == true,  historyPrint.hAttackerFCategory == "Magicien" {
        let specialInLoad = Wizard(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
        specialInLoad.specialWizard(randomInt: randomInt, resultBonusToPrint: "")
    }
    
}



/**
 healOrAttackFighter : To list with optimized code if it's an attack or a care (depend of FighterArray P1 or P2, and Category : Wizard or no)
 */
func healOrAttackFighter(fighterArray: [Fighter], checkCategory: Bool, userGamerName : String, symbol : String) {
    
    
    nDefendAlive = 0 // reset to check good choice while fighters were dead
    if !checkCategory {
        print("\r\(symbol) \(userGamerName) : Quel Fighter adversaire désires tu endommager ?")
    } else {
        print("\r\(symbol) \(userGamerName) : Quel Fighter désires tu soigner ?")
    }
    
    for nDefend in 0..<fighterArray.count {
        if fighterArray[nDefend].lifePoint > 0 {
            nDefendAlive += 1
            arrayGoodIndex[nDefendAlive - 1] = nDefend
            if !checkCategory {
                print("💢\(nDefendAlive). Attaque sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
            } else {
                print("💢\(nDefendAlive). Soin sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
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
            healOrAttackFighter(fighterArray: fighterArrayP2, checkCategory: checkCategory, userGamerName: userArray[0].gamerName, symbol : "🔴" )
        } else {
            healOrAttackFighter(fighterArray: fighterArrayP1, checkCategory: checkCategory, userGamerName: userArray[1].gamerName, symbol :"🔵")
        }
    } else {
        if randomInt == 1 {
            healOrAttackFighter(fighterArray: fighterArrayP1, checkCategory: checkCategory, userGamerName: userArray[1].gamerName, symbol :"🔵")
        } else {
            healOrAttackFighter(fighterArray: fighterArrayP2, checkCategory: checkCategory, userGamerName: userArray[0].gamerName, symbol : "🔴" )
        }
    }
    
    
    
    if let choicetoDefend = readLine() {
        if var choiceDefenderLeRetour = Int(choicetoDefend) {
            if choiceDefenderLeRetour <= 0 || choiceDefenderLeRetour > nDefendAlive {
                print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                let _ = choiceDefender(randomInt: randomInt, damageInLoad: historyPrint.hAttackerFActionStrenght)
            }
            choiceDefenderLeRetour = arrayGoodIndex[choiceDefenderLeRetour - 1] // to take again the good Index
            switch choiceDefenderLeRetour {
                //LOOP FOR CASE SITUATION
                //APPLY DAMAGE TO THE GOOD FIGHTER
            case choiceDefenderLeRetour:
                if !checkCategory {  //if it's not Wizard
                    if randomInt == 1 { // if it's the team 1
                        updateHistoryDefenderDamage(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
                    } else {
                        updateHistoryDefenderDamage(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
                    }
                } else {  //if it's a Wizard
                    if randomInt == 1 { // if it's the team 1
                        updateHistoryDefenderCare(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
                    } else {
                        updateHistoryDefenderCare(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
                    }
                }
                
            default: print("Je n'ai pas compris qui reçoit le coup. On recommence : ")
            }
            defenderNumber = choiceDefenderLeRetour // update var defenderNumber
        } else {
            print("Vous devez saisir le chiffre d'un défenseur : On recommence ^^")
            let _ = choiceDefender(randomInt: randomInt, damageInLoad: historyPrint.hAttackerFActionStrenght)
        }
    }
}


/**
 func updateHistoryDefenderDamage : to update damage & History of the last FIGHTER'S ACTION
 */
func updateHistoryDefenderDamage(choiceDefenderLeRetour: Int, damageInLoad: Int, fighterArray: [Fighter], userTeamName: String) {
    
    if fromUnluckZone == true { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
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
    if fighterArray[choiceDefenderLeRetour].lifePoint <= 0 {
        alreadyDead = true
    }
    
    historyPrint.hDefenderTeamName = userTeamName
    historyPrint.hDefenderFName = fighterArray[choiceDefenderLeRetour].name
    historyPrint.hDefenderFCategory = fighterArray[choiceDefenderLeRetour].category
    fighterArray[choiceDefenderLeRetour].lifePoint -= historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
    historyPrint.hDefenderFLifePoint = fighterArray[choiceDefenderLeRetour].lifePoint //the others var in History to explain
    if fighterArray[choiceDefenderLeRetour].lifePoint <= 0 {
        if alreadyDead {
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 IL S'ACHAAAAAAARNE : \(fighterArray[choiceDefenderLeRetour].name) le \(fighterArray[choiceDefenderLeRetour].category) est déjà mort...au sol ! 🦴🦴🦴 Mais pourtant : ")
        } else {
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t🦴🦴🦴 WOWWWW LE WANHAMMER SE REDUIT : \(fighterArray[choiceDefenderLeRetour].name) le \(fighterArray[choiceDefenderLeRetour].category) est mort ! 🦴🦴🦴")
        }
    }
}


/**
 func updateHistoryDefenderCare : to update damage & History of the last WIZARD'S ACTION
 */

func updateHistoryDefenderCare(choiceDefenderLeRetour: Int, damageInLoad: Int, fighterArray: [Fighter], userTeamName: String) {
    
    if fromUnluckZone == true { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
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
    historyPrint.hDefenderFName = fighterArray[choiceDefenderLeRetour].name
    historyPrint.hDefenderFCategory =  fighterArray[choiceDefenderLeRetour].category
    fighterArray[choiceDefenderLeRetour].lifePoint += historyPrint.hAttackerFActionStrenght //update LifePoint in FighterArray
    historyPrint.hDefenderFLifePoint = fighterArray[choiceDefenderLeRetour].lifePoint //the others var in History to explain
}



/**
 randomBONUS : Random BONUS (depend of Wizard or no)
 */
func randomBonus(randomInt: Int) {
    
    let randomBonusZone = Int.random(in: 0..<2)
    let category = historyPrint.hAttackerFCategory
    
    if randomBonusZone == 0 {  //BONUS ZONE
        bonusOrUnluckZone = true
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
            if randomInt == 1 { // apply damage to the good team
                updateHistoryDefenderDamage(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
            } else {
                updateHistoryDefenderDamage(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
            }
        case "Magicien":
            let resultNumberBonus = Int(arc4random_uniform(UInt32(bonusZoneWizard.count)))
            resultBonusToPrint = bonusZoneWizard[resultNumberBonus]
            historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
            if randomInt == 1 { // apply care to the good team
                updateHistoryDefenderCare(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
            } else {
                updateHistoryDefenderCare(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
            }
        default:
            print("Pas d'action BONUS ce tour ci ^^")
        }
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😎😎😎😎  BONUS ZONE  😎😎😎😎")
        actionPrint(resultBonusToPrint: resultBonusToPrint)
        bonusOrUnluckZone = false
    }
    
    
    if randomBonusZone == 1 { //UNLUCK ZONE
        fromUnluckZone = true
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
            if randomInt == 1 { // apply damage to the attacker Team ... unluck !
                updateHistoryDefenderDamage(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
            } else {
                updateHistoryDefenderDamage(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
            }
        case "Magicien":
            let resultNumberBonus = Int(arc4random_uniform(UInt32(unluckyZoneWizard.count)))
            resultBonusToPrint = unluckyZoneWizard[resultNumberBonus]
            historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
            if randomInt == 1 { // apply care to the opponent team ... unluck !
                updateHistoryDefenderCare(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP2, userTeamName: userArray[1].teamName)
            } else {
                updateHistoryDefenderCare(choiceDefenderLeRetour: defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: fighterArrayP1, userTeamName: userArray[0].teamName)
            }
        default:
            print("Pas d'action BONUS ce tour ci ^^")
        }
        print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😩😩😩😩  UNLUCK ZONE  😩😩😩😩")
        actionPrint(resultBonusToPrint: resultBonusToPrint)
        fromUnluckZone = false
    }
}



/**
 displayTeamAndFighterLifePoint : To loop on the good Fighter and user Array
 */


func displayTeamAndFighterLifePoint(userArray: Team, fighterArray : [Fighter], symbol : String ) {
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
func checkAllTeamLifePoint() {
    displayTeamAndFighterLifePoint(userArray: userArray[0], fighterArray: fighterArrayP1, symbol: "🔴")
    displayTeamAndFighterLifePoint(userArray: userArray[1], fighterArray: fighterArrayP2, symbol: "🔵")
}



/**
 actionPrint : Print different message to inform about history and lifePoint
 */
func  actionPrint(resultBonusToPrint: String) {
    
    lifePointConvert() // if BONUS OR UNLUCKY ZONE has been used
    // take a var to print different word (depend of category : Wizard or no)
    var attackOrCare = ""
    var gainOrLoose = ""
    if checkCategory {
        attackOrCare = "un soin"
        gainOrLoose = "reçoit"
    } else {
        attackOrCare = "une attaque"
        gainOrLoose = "perd"
    }
    
    if bonusOrUnluckZone == true || fromUnluckZone == true {
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
    print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tCelui-ci \(gainOrLoose) \(historyPrint.hAttackerFActionStrenght) PV et en possède maintenant \(historyPrint.hDefenderFLifePoint)")
}



/**
 lifePointConvert : To convert negative lifePoint to 0 and can have good addition in the final result
 */
func lifePointConvert() {
    
    //to reset negative count to 0 and don't have error in addition mode
    for n in 0..<fighterArrayP1.count {
        if fighterArrayP1[n].lifePoint < 0 {
            fighterArrayP1[n].lifePoint = 0
        }
    }
    for n in 0..<fighterArrayP2.count {
        if fighterArrayP2[n].lifePoint < 0 {
            fighterArrayP2[n].lifePoint = 0
        }
    }
    
    
    // update userArray Life Team
    userArray[0].lifeTeam = fighterArrayP1[0].lifePoint + fighterArrayP1[1].lifePoint + fighterArrayP1[2].lifePoint
    userArray[1].lifeTeam = fighterArrayP2[0].lifePoint + fighterArrayP2[1].lifePoint + fighterArrayP2[2].lifePoint
    
}

func demoMode() {
    
    //Create FAKE USER and TEAM
    var teamDemo = Team(gamerName: "Jean", teamName: "JeanBute")
    userArray.append(teamDemo)
    teamDemo = Team(gamerName: "Luc", teamName: "LuckYTeam")
    userArray.append(teamDemo)
    
    //CREATE FIGHTERS
    for i in 1...6 {
        
        if i == 1 {
            let fighterInLoad = Dwarf(name: ("Kulk.J"), numberFetich: i)
            fighterArrayP1.append(fighterInLoad)
        }
        
        if i == 2 {
            let fighterInLoad = Colossus(name: ("Bouh.J"), numberFetich: i)
            fighterArrayP1.append(fighterInLoad)
        }
        
        if i == 3 {
            let fighterInLoad = Warrior(name: ("Jean.J"), numberFetich: i)
            fighterArrayP1.append(fighterInLoad)
        }
        if i == 4 {
            let fighterInLoad = Wizard(name: ("Magik.L"), numberFetich: i)
            fighterArrayP2.append(fighterInLoad)
        }
        
        if i == 5 {
            let fighterInLoad = Warrior(name: ("Luc.L"), numberFetich: i)
            fighterArrayP2.append(fighterInLoad)
        }
        
        if i == 6 {
            let fighterInLoad = Colossus(name: ("owww.L"), numberFetich: i - 2)
            fighterArrayP2.append(fighterInLoad)
        }
    }
    battleMode()
    
}



/**
 addWinAndLooseValue : At the end of the Game, give +1 to the value Win or Loose for each Team
 */

func addWinAndLooseValue () {
    
    if userArray[0].lifeTeam < userArray[1].lifeTeam {
        userArray[0].looseCounter += 1
        userArray[1].winCounter += 1
        print("Un point de Victoire pour la team \(userArray[1].teamName) de \(userArray[1].gamerName)")
    } else {
        userArray[1].looseCounter += 1
        userArray[0].winCounter += 1
        print("Un point de Victoire pour la team \(userArray[0].teamName) de \(userArray[0].gamerName)")
    }
}

// LOOP FOR THE PROGRAM


while stayInProgram == true {
    principalMenu()
}
