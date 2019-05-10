//
//  WanHammerGame.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 10/05/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation


class WanHammerGame {
    
    var stayInProgram = true // BOOL to stay in program
    var countAction = 0 // initialize countAction to check if it's the first Round, and also for the next Battle
    var numberOfTeam = 0 // to switch team One and team Two
    var numberOfWizard = 0 // Because we can't have only Wizard in a team
    var numberOfFighter = 1 // to stop at 3 fighters
    var checkCategory = false // Wizard or no ?
    var attackerNumber = 0 // needed to select the good attacker in Array
    var defenderNumber = 0 // needed to select the good defender in Array
    var specialFetichAction = false // True if the fetich number is activate
    var fromUnluckZone = false // Bool to check is the attacker come from UnluckZone
    var bonusOrUnluckZone = false //Use to edit different sort of message
    var nDefendAlive = 0 // To print only the aliveDefender
    var nAttackAlive = 0 // To print only the aliveAttacker
    var revenge = false // to propose revenge
    
    
    // MARK: Array declaration
    var fighterArrayP1 = [Fighter]()   // for the team1
    var fighterArrayP2 = [Fighter]()  // for the team2
    var userArray = [Team]()  //  to archive User's Name / total LifePoint / Round Win and loose
    var arrayGoodIndex = [0,1,2] // this is for keep the good IndexNumber in Menu Defender/Attacker choice.
    
    
    
    // MARK: LOOP FOR THE PROGRAM
    func InTheGame() {
        while wanHammer.stayInProgram {
            
            if !wanHammer.revenge { // If it's the first WanHammer, launch the principalMenu
                Message.principalMenu()
            } else { // print another menu to continue next Battle
                Message.RevengeMenu()
            }
                Message.userInput() // UserInput (Gamer's Name, Team Name)
        }
    }
    

    
    /**
     chooseFighter : Menu to choose category of fighters : 1 2 3 4
     */
    func chooseFighter() {
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
                    addFighter(category: Category.warrior)
                case "2":
                    addFighter(category: Category.dwarf)
                case "3":
                    addFighter(category: Category.colossus)
                case "4":
                    if wanHammer.numberOfWizard >= 2 {
                        print("Désolé, vous ne pouvez pas choisir que des magiciens dans votre Team ;)")
                        return chooseFighter()
                    }
                    addFighter(category: Category.wizard)
                case "5":
                    Message.FightersSettings()
                    
                    Message.pause()
                    chooseFighter()
                    
                default:
                    print("Je n'ai pas compris ton choix")
                    chooseFighter()
                }
            }
            // numberOfFighter += 1
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
            wanHammer.numberOfFighter += 1
        }
        print("Tu as choisi \(wanHammer.numberOfFighter - 1) fighters") // print when 3 fighters have been choosen
        wanHammer.numberOfFighter = 1 // reset var to 1
    }
    
    
    /**
     addFighter : In this function : Adding fighter in the good user Array
     */
    func addFighter(category: Category) {
        
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
    func nameOfTheFighter() -> String {
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
    func numberFetich() -> Int {
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
     battleMode : Step by step : We have to choose attacker, chest, Fetich zone, Defendeur, Bonus Zone
     */
    func battleMode() {
        print("\r\r\r\r\r😈😈 Tous les combattants sont en place : Presser une touche pour que le WANHAMMER continu !😈😈 ")
        Message.pause()
        lifePointConvert() // initialize userArray[].Lifepoint value to check if one TEAM is DEAD
        if !wanHammer.revenge {
            checkAllTeamLifePoint() // Print all the fighters LifePoint only if it's the First Battle
        }
        Message.pause()
        var whichTeam : Int = 1 //Variable for random choice, or logical choice
        while wanHammer.userArray[0].lifeTeam > 0, wanHammer.userArray[1].lifeTeam  > 0 { // LOOP HERE IF THERE IS AT LEAST ONE FIGHTER ALIVE IN EACH TEAM
            if wanHammer.countAction == 0 { //Random choice for the First Player who give the first attack
                whichTeam = Int.random(in: 1..<3)
            }
            historyPrint.hAttackerFActionStrenght = choiceAttackFrom(whichTeam: whichTeam)  // CHOICE ATTACKER MENU
            randomChest(whichTeam: whichTeam) // RANDOM CHEST : Sometimes, you take new weapon at the beginning of the round with a random chest
            randomFetichNumber(whichTeam: whichTeam) //FETICH NUMBER BONUS : Have to take before DEFENDER CHOICE because of the dwarf (double damage action)
            choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght) // CHOICE DEFENDER MENU
            wanHammer.countAction += 1 // one damage or care has been done : countAction have to be increase
            historyPrint.actionPrint(resultBonusToPrint: "")
            applyFetichBonus(whichTeam: whichTeam) // APPLY FETICH BONUS FOR THE OTHERS ATTACKERS (Warrior, Colossus, Wizard)
            randomBonus(whichTeam: whichTeam) // BONUS UNLUCK ZONE : If you're lucky, you can use your critical attack, if not you do an unlucky action
            if whichTeam == 1 { // TO SWITCH PLAYER ATTACK
                whichTeam = 2
            } else {
                whichTeam = 1
            }
        }
        print("La partie est terminée :")
        print("🔴Score final de la team \(wanHammer.userArray[0].teamName) du joueur \(wanHammer.userArray[0].gamerName) : \(wanHammer.fighterArrayP1[0].lifePoint + wanHammer.fighterArrayP1[1].lifePoint + wanHammer.fighterArrayP1[2].lifePoint)")
        print("🔵Score final de la team \(wanHammer.userArray[1].teamName) du joueur \(wanHammer.userArray[1].gamerName) : \(wanHammer.fighterArrayP2[0].lifePoint + wanHammer.fighterArrayP2[1].lifePoint + wanHammer.fighterArrayP2[2].lifePoint)")
        addWinAndLooseValue()
    }
    
    
    /**
     choiceAttackFrom : Here we have to choose the Attacker
     */
    func choiceAttackFrom(whichTeam: Int) -> Int {
        
        wanHammer.nAttackAlive = 0 // reset to check good choice while fighters were dead
        let userTeamName = selectArrayTeamOneOrTwo(whichTeam: whichTeam) //take the good UserArray for the function
        let fighterArray = selectArrayFightersOneorTwo(whichTeam: whichTeam) //take the good FighterArray for the function
        print("\r\r\r\(userTeamName.symbol) \(userTeamName.gamerName) de la Team \(userTeamName.teamName) : Il te reste \(userTeamName.lifeTeam) PV"
            + "\r Avec quel Fighter désires-tu agir ?")
        loopChoiceAttackFrom(fighterArray: fighterArray)
        
        if let choiceAttacker = readLine() { // Check User Choice
            if var choiceAttackerLoop = Int(choiceAttacker) { // Check if it's Int
                if choiceAttackerLoop <= 0 || choiceAttackerLoop > wanHammer.nAttackAlive { // If the user Choice is not in the proposition 0 to ... nAttackAline : print :
                    print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                    return choiceAttackFrom(whichTeam: whichTeam)
                }
                choiceAttackerLoop = wanHammer.arrayGoodIndex[choiceAttackerLoop - 1] // Adjust value to keep the good index (if fighter is dead / fighters are dead)
                switch choiceAttackerLoop {
                case choiceAttackerLoop:
                    UpdateHistoryAttacker(choiceAttackerLoop: choiceAttackerLoop, fighterArray : fighterArray, userTeamName : userTeamName.teamName)
                    wanHammer.attackerNumber = choiceAttackerLoop // keep  in variable to use for Chest modification value
                    if historyPrint.hAttackerFCategory == Category.wizard.rawValue {
                        wanHammer.checkCategory = true
                    } else {
                        wanHammer.checkCategory = false
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
    func loopChoiceAttackFrom(fighterArray: [Fighter]) {
        
        for nAttack in 0..<fighterArray.count {
            if fighterArray[nAttack].lifePoint > 0 {  // print only if the fighter is not dead
                wanHammer.nAttackAlive += 1 // to print the number : increase 1 2 3 ...
                wanHammer.arrayGoodIndex[wanHammer.nAttackAlive - 1] = nAttack // archive the good index to keep the good one in the fighterArrayP1 or P2
                print("\(wanHammer.nAttackAlive). \(fighterArray[nAttack].name) le \(fighterArray[nAttack].category) avec \(fighterArray[nAttack].weapon) de puissance \(fighterArray[nAttack].strenght), reste PV : \(fighterArray[nAttack].lifePoint)")
            }
        }
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
    func randomChest(whichTeam : Int) {
        
        // Array Chest Content and value
        let weaponChestContent = ["une épée dorée","une hâche de Rahan","une grenade","un fléau d'arme","un tire-bouchon"]
        let healthChestContent = ["une purée de brocoli","une barre protéinée","une whey à la banane","une framboise fraiche","un BigMac"]
        let newValueWeaponChestContent = [15,25,30,25,5]
        
        // var resultGift = ""
        let randomNumberChest = Int.random(in: 1..<5)
        if randomNumberChest == 2 {
            print("\r\rWaooow ! Quelle chance !! Un coffre est apparu devant toi !")
            if !wanHammer.checkCategory  { // if it's Dwarf/Colossus/Warrior : USE weaponChestContent
                weaponOrHealthInChest(weaponOrHealthArray: weaponChestContent, newValueWeaponChestContent: newValueWeaponChestContent, whichTeam: whichTeam)
            } else if wanHammer.checkCategory { // if it's a wizard : : USE healthChestContent
                weaponOrHealthInChest(weaponOrHealthArray: healthChestContent, newValueWeaponChestContent: newValueWeaponChestContent, whichTeam: whichTeam)
            }
        }
    }
    
    
    /**
     weaponOrHealthInChest : To choose good Array : Weapon or Health, depend of category
     */
    func weaponOrHealthInChest(weaponOrHealthArray: Array<String>, newValueWeaponChestContent: Array<Int>, whichTeam: Int) {
        
        var resultGift = ""
        let resultGiftNumber = Int(arc4random_uniform(UInt32(weaponOrHealthArray.count)))
        resultGift = weaponOrHealthArray[resultGiftNumber]
        let resultStrenght = newValueWeaponChestContent[resultGiftNumber]
        let fighterArray = selectArrayFightersOneorTwo(whichTeam: whichTeam)
        updateStrenghtAndWeapon(fighterArray: fighterArray, attackerNumber: wanHammer.attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
        if resultGift != "" {
            print("C'est \(resultGift) ! Tu t'en équipes !"
                + "Ta puissance d'action est maintenant de : \(historyPrint.hAttackerFActionStrenght)")
            Message.pause()
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
    func randomFetichNumber(whichTeam : Int) {
        
        var fetichOk = false
        let randomFetichNumber = Int.random(in: 1..<6)
        let fighterArray = selectArrayFightersOneorTwo(whichTeam: whichTeam)
        if randomFetichNumber == fighterArray[wanHammer.attackerNumber].numberFetich {
            fetichOk = true
        }
        
        if fetichOk {
            switch historyPrint.hAttackerFCategory {
            case Category.warrior.rawValue:
                wanHammer.specialFetichAction = true
            case Category.dwarf.rawValue:
                let specialInLoad = Dwarf(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
                wanHammer.specialFetichAction = false
            case Category.colossus.rawValue:
                wanHammer.specialFetichAction = true
            case Category.wizard.rawValue:
                wanHammer.specialFetichAction = true
            default:
                print("Pas d'action Fétiche ce tour ci ^^") //never happen. Have to keep it because SWITCH is on the current Attacker var
            }
        }
    }
    
    
    /**
     applyFetichBonus : The Dwarf have already apply his double damage if he find FetichNumber...but for the other : We need another function
     */
    func applyFetichBonus(whichTeam : Int) {
        
        if wanHammer.specialFetichAction {
            if historyPrint.hAttackerFCategory == Category.warrior.rawValue { //SPECIAL FETICH for the Warrior : Double Attack, so launch second attack after firstDamage
                let specialInLoad = Warrior(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            if historyPrint.hAttackerFCategory == Category.colossus.rawValue { // SPECIAL FETICH for the Colossus : entiere Double Turn
                let specialInLoad = Colossus(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            if historyPrint.hAttackerFCategory == Category.wizard.rawValue { // SPECIAL FETICH for the Magician : Loop damage for all the opponent lifePoint Array
                let specialInLoad = Wizard(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
            }
            wanHammer.specialFetichAction = false
        }
    }
    
    
    /**
     healOrAttackFighter : To list with optimized code if it's an attack or a care (depend of FighterArray P1 or P2, and Category : Wizard or no)
     */
    func healOrAttackFighter(fighterArray: [Fighter], healOrAttack: String, healOrAttack2 : String, userTeam: Team) {
        
        
        wanHammer.nDefendAlive = 0 // reset to check good choice while fighters were dead
        print("\r\(userTeam.symbol) \(userTeam.gamerName) : Quel Fighter désires-tu \(healOrAttack) ?")
        
        for nDefend in 0..<fighterArray.count {
            if fighterArray[nDefend].lifePoint > 0 {
                wanHammer.nDefendAlive += 1
                wanHammer.arrayGoodIndex[wanHammer.nDefendAlive - 1] = nDefend
                print("💢\(wanHammer.nDefendAlive). \(healOrAttack2) sur \(fighterArray[nDefend].name) le \(fighterArray[nDefend].category), reste \(fighterArray[nDefend].lifePoint) PV ")
            }
        }
    }
    
    
    
    /**
     choiceDefender : Who receive the attack or the Care
     */
    func choiceDefender(whichTeam: Int, damageInLoad: Int) {
        
        let userTeam = selectArrayTeamOneOrTwo(whichTeam: whichTeam) // constant for the defender action : Good Array, Good Fighter, depending of which Team and Category
        let userTeamInverted = selectArrayTeamInverted(whichTeam: whichTeam)
        let defenderArray = selectArrayDefenderOneorTwo(whichTeam: whichTeam)
        let defenderArrayInverted = selectArrayFightersOneorTwo(whichTeam: whichTeam)
        
        if !wanHammer.checkCategory { // if it's not a Wizard
            let healOrAttack = "endommager"
            let healOrAttack2 = "Attaque"
            healOrAttackFighter(fighterArray: defenderArray, healOrAttack: healOrAttack, healOrAttack2 : healOrAttack2, userTeam: userTeam)
        } else { // If it's WIZARD : Then array of the fighter will be different because it's a care for the team of the Wizard
            let healOrAttack = "soigner"
            let healOrAttack2 = "Soin"
            healOrAttackFighter(fighterArray: defenderArrayInverted, healOrAttack: healOrAttack, healOrAttack2: healOrAttack2, userTeam: userTeam)
        }
        
        
        if let choicetoDefend = readLine() {
            if var choiceDefenderLeRetour = Int(choicetoDefend) {
                if choiceDefenderLeRetour <= 0 || choiceDefenderLeRetour > wanHammer.nDefendAlive {
                    print("Vous ne pouvez choisir qu'un numéro correspondant au choix proposé : On recommence ^^")
                    let _ = choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
                }
                choiceDefenderLeRetour = wanHammer.arrayGoodIndex[choiceDefenderLeRetour - 1] // to take again the good Index
                switch choiceDefenderLeRetour {
                    //LOOP FOR CASE SITUATION
                //APPLY DAMAGE TO THE GOOD FIGHTER
                case choiceDefenderLeRetour:
                    if !wanHammer.checkCategory {  //if it's not Wizard
                        updateHistoryDefenderDamage(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
                    } else {  //if it's a Wizard
                        updateHistoryDefenderCare(choiceDefenderLeRetour: choiceDefenderLeRetour, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
                    }
                default: print("Je n'ai pas compris qui reçoit le coup. On recommence : ")
                }
                wanHammer.defenderNumber = choiceDefenderLeRetour // update var defenderNumber
            } else {
                print("Vous devez saisir le chiffre d'un défenseur : On recommence ^^")
                let _ = choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght)
            }
        }
    }
    
    
    /**
     func updateHistoryDefenderDamage : to update damage & History of the last FIGHTER'S ACTION
     */
    func updateHistoryDefenderDamage(choiceDefenderLeRetour: Int, damageInLoad: Int, fighterArray: [Fighter], userTeamName: String) {
        
        var alreadyDead = false
        var defenderRandomNumber = 0
        
        if wanHammer.fromUnluckZone { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
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
        
        var defenderRandomNumber = 0
        
        if wanHammer.fromUnluckZone { // if this action come from UNLUCK ZONE, damage will be activate for random alive Fighter in the opponent Array
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
    func randomBonus(whichTeam: Int) {
        
        let randomBonusZone = Int.random(in: 1..<20)
        let category = historyPrint.hAttackerFCategory
        let userTeam = selectArrayTeamOneOrTwo(whichTeam: whichTeam) // constant for the defender action : Good Array, Good Fighter, depending of which Team and Category
        let userTeamInverted = selectArrayTeamInverted(whichTeam: whichTeam)
        let defenderArray = selectArrayDefenderOneorTwo(whichTeam: whichTeam)
        let defenderArrayInverted = selectArrayFightersOneorTwo(whichTeam: whichTeam)
        
        
        if randomBonusZone == 19 {  //BONUS ZONE : GOOD ACTION
            wanHammer.bonusOrUnluckZone = true // used later for print final result
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
                updateHistoryDefenderDamage(choiceDefenderLeRetour: wanHammer.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(bonusZoneWizard.count)))
                resultBonusToPrint = bonusZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                updateHistoryDefenderCare(choiceDefenderLeRetour: wanHammer.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😎😎😎😎  BONUS ZONE  😎😎😎😎")
            historyPrint.actionPrint(resultBonusToPrint: resultBonusToPrint)
            wanHammer.bonusOrUnluckZone = false
        }
        
        
        if randomBonusZone == 1 { //UNLUCK ZONE
            wanHammer.fromUnluckZone = true
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
                updateHistoryDefenderDamage(choiceDefenderLeRetour: wanHammer.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(unluckyZoneWizard.count)))
                resultBonusToPrint = unluckyZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                updateHistoryDefenderCare(choiceDefenderLeRetour: wanHammer.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😩😩😩😩  UNLUCK ZONE  😩😩😩😩")
            historyPrint.actionPrint(resultBonusToPrint: resultBonusToPrint)
            wanHammer.fromUnluckZone = false
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
        displayTeamAndFighterLifePoint(userArray: wanHammer.userArray[0], fighterArray: wanHammer.fighterArrayP1, symbol: "🔴")
        displayTeamAndFighterLifePoint(userArray: wanHammer.userArray[1], fighterArray: wanHammer.fighterArrayP2, symbol: "🔵")
    }
    
    
    /**
     lifePointConvert : To convert negative lifePoint to 0 and can have good addition in the final result
     */
    func lifePointConvert() {
        
        //to reset negative count to 0 and don't have error in addition mode
        for n in 0..<wanHammer.fighterArrayP1.count {
            if wanHammer.fighterArrayP1[n].lifePoint < 0 {
                wanHammer.fighterArrayP1[n].lifePoint = 0
            }
        }
        for n in 0..<wanHammer.fighterArrayP2.count {
            if wanHammer.fighterArrayP2[n].lifePoint < 0 {
                wanHammer.fighterArrayP2[n].lifePoint = 0
            }
        }
        // update userArray Life Team
        wanHammer.userArray[0].lifeTeam = wanHammer.fighterArrayP1[0].lifePoint + wanHammer.fighterArrayP1[1].lifePoint + wanHammer.fighterArrayP1[2].lifePoint
        wanHammer.userArray[1].lifeTeam = wanHammer.fighterArrayP2[0].lifePoint + wanHammer.fighterArrayP2[1].lifePoint + wanHammer.fighterArrayP2[2].lifePoint
        
    }
    
    
    /**
     demoMode: Fighter/teamName/UserName selected by the program
     */
    func demoMode() {
        
        //Create FAKE USER and TEAM
        var teamDemo = Team(gamerName: "Jean", teamName: "JeanBute")
        teamDemo.symbol = "🔴"
        wanHammer.userArray.append(teamDemo)
        teamDemo = Team(gamerName: "Luc", teamName: "LuckYTeam")
        teamDemo.symbol = "🔵"
        wanHammer.userArray.append(teamDemo)
        
        //CREATE FIGHTERS
        for i in 1...6 {
            
            if i == 1 {
                let fighterInLoad = Dwarf(name: ("Kulk.J"), numberFetich: i)
                wanHammer.fighterArrayP1.append(fighterInLoad)
            }
            
            if i == 2 {
                let fighterInLoad = Colossus(name: ("Bouh.J"), numberFetich: i)
                wanHammer.fighterArrayP1.append(fighterInLoad)
            }
            
            if i == 3 {
                let fighterInLoad = Warrior(name: ("Jean.J"), numberFetich: i)
                wanHammer.fighterArrayP1.append(fighterInLoad)
            }
            if i == 4 {
                let fighterInLoad = Wizard(name: ("Magik.L"), numberFetich: i)
                wanHammer.fighterArrayP2.append(fighterInLoad)
            }
            
            if i == 5 {
                let fighterInLoad = Warrior(name: ("Luc.L"), numberFetich: i)
                wanHammer.fighterArrayP2.append(fighterInLoad)
            }
            
            if i == 6 {
                let fighterInLoad = Colossus(name: ("owww.L"), numberFetich: i - 2)
                wanHammer.fighterArrayP2.append(fighterInLoad)
            }
        }
        
    }
    
    
    /**
     addWinAndLooseValue : At the end of the Game, give +1 to the value Win or Loose for each Team
     */
    
    func addWinAndLooseValue () {
        
        wanHammer.revenge = true
        if wanHammer.userArray[0].lifeTeam < wanHammer.userArray[1].lifeTeam {
            wanHammer.userArray[0].looseCounter += 1
            wanHammer.userArray[1].winCounter += 1
            print("\rUn point de Victoire pour la team \(wanHammer.userArray[1].teamName)"
                + "\rBravo à toi \(wanHammer.userArray[1].gamerName) !!!")
        } else {
            wanHammer.userArray[1].looseCounter += 1
            wanHammer.userArray[0].winCounter += 1
            print("\rUn point de Victoire pour la team \(wanHammer.userArray[0].teamName)"
                + "\rBravo à toi \(wanHammer.userArray[0].gamerName) !!!")
        }
        Message.pause()
    }
    
    
    /**
     resetFighters : Function to reset All the parameters of each Fighters on each teams
     */
    
    func resetFighters(fighterArray: [Fighter],userArray: Team, symbol: String) {
        
        for i in 0..<fighterArray.count {
            if fighterArray[i].category == "Combattant" {
                fighterArray[i].lifePoint = 100
                fighterArray[i].strenght = 10
                fighterArray[i].weapon = Weapon.sword.rawValue
            }
            if fighterArray[i].category == "Nain" {
                fighterArray[i].lifePoint = 80
                fighterArray[i].strenght = 20
                fighterArray[i].weapon = Weapon.axe.rawValue
            }
            if fighterArray[i].category == "Colosse" {
                fighterArray[i].lifePoint = 200
                fighterArray[i].strenght = 5
                fighterArray[i].weapon = Weapon.fist.rawValue
            }
            if fighterArray[i].category == "Magicien" {
                fighterArray[i].lifePoint = 125
                fighterArray[i].strenght = 15
                fighterArray[i].weapon = Weapon.wand.rawValue
            }
        }
        
        print ("\r\rTeam \(userArray.teamName) Voici ton tableau de combattants : Ils sont tous FRAIS à nouveau :) ")
        for i in 0...fighterArray.count - 1{
            print("\(symbol) Le \(fighterArray[i].category) : \(fighterArray[i].name), Force \(fighterArray[i].strenght), avec \(fighterArray[i].weapon). PV \(fighterArray[i].lifePoint)")
        }
        
        
    }
    
    
    /**
     selectArrayTeamOneOrTwo : If it's Team 1 : Return Array1. If it's team2 : Return Array2
     */
    
    func selectArrayTeamOneOrTwo(whichTeam : Int) -> Team {
        
        var userTeamName = wanHammer.userArray[0]
        if whichTeam == 2 {
            userTeamName = wanHammer.userArray[1]
            return userTeamName
        }
        return userTeamName
    }
    
    
    /**
     selectArrayTeamInverted : If it's Team 1 : Return Array2. If it's team2 : Return Array1 : Used for Wizard Care for example
     */
    
    func selectArrayTeamInverted(whichTeam : Int) -> Team {
        
        var userTeamInverted = wanHammer.userArray[1]
        if whichTeam == 2 {
            userTeamInverted = wanHammer.userArray[0]
            return userTeamInverted
        }
        return userTeamInverted
    }
    
    
    /**
     selectArrayFightersOneorTwo : If it's Team 1 : Return FighterP1. If it's team2 : Return FighterP2
     */
    func selectArrayFightersOneorTwo(whichTeam : Int) -> [Fighter] {
        
        var fighterArray = wanHammer.fighterArrayP1
        if whichTeam == 2 {
            fighterArray = wanHammer.fighterArrayP2
            return fighterArray
        }
        return fighterArray
    }
    
    
    /**
     selectArrayDefenderOneorTwo : If it's Team 1 : Return FighterP2. If it's team2 : Return FighterP1
     */
    func selectArrayDefenderOneorTwo(whichTeam : Int) -> [Fighter] {
        
        var defenderArray = wanHammer.fighterArrayP2
        if whichTeam == 2 {
            defenderArray = wanHammer.fighterArrayP1
            return defenderArray
        }
        return defenderArray
    }
    
    
    func thanksAtTheEnd() {
        print("Merci ! J'espère que vous avez trouvé ça divertissant ^^")
    }
}
