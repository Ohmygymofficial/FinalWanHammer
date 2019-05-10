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
            historyPrint.hAttackerFActionStrenght = choiceAttackFrom(whichTeam: whichTeam)  // CHOICE ATTACKER MENU
            randomChest(whichTeam: whichTeam) // RANDOM CHEST : Sometimes, you take new weapon at the beginning of the round with a random chest
            randomFetichNumber(whichTeam: whichTeam) //FETICH NUMBER BONUS : Have to take before DEFENDER CHOICE because of the dwarf (double damage action)
            choiceDefender(whichTeam: whichTeam, damageInLoad: historyPrint.hAttackerFActionStrenght) // CHOICE DEFENDER MENU
            geek.countAction += 1 // one damage or care has been done : countAction have to be increase
            History.actionPrint(resultBonusToPrint: "")
            applyFetichBonus(whichTeam: whichTeam) // APPLY FETICH BONUS FOR THE OTHERS ATTACKERS (Warrior, Colossus, Wizard)
            randomBonus(whichTeam: whichTeam) // BONUS UNLUCK ZONE : If you're lucky, you can use your critical attack, if not you do an unlucky action
            if whichTeam == 1 { // TO SWITCH PLAYER ATTACK
                whichTeam = 2
            } else {
                whichTeam = 1
            }
        }
        print("La partie est terminée :")
        print("🔴Score final de la team \(geek.userArray[0].teamName) du joueur \(geek.userArray[0].gamerName) : \(geek.fighterArrayP1[0].lifePoint + geek.fighterArrayP1[1].lifePoint + geek.fighterArrayP1[2].lifePoint)")
        print("🔵Score final de la team \(geek.userArray[1].teamName) du joueur \(geek.userArray[1].gamerName) : \(geek.fighterArrayP2[0].lifePoint + geek.fighterArrayP2[1].lifePoint + geek.fighterArrayP2[2].lifePoint)")
        Team.addWinAndLooseValue()
    }
    
    
    /**
     choiceAttackFrom : Here we have to choose the Attacker
     */
    func choiceAttackFrom(whichTeam: Int) -> Int {
        
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
    func loopChoiceAttackFrom(fighterArray: [Fighter]) {
        
        for nAttack in 0..<fighterArray.count {
            if fighterArray[nAttack].lifePoint > 0 {  // print only if the fighter is not dead
                geek.nAttackAlive += 1 // to print the number : increase 1 2 3 ...
                geek.arrayGoodIndex[geek.nAttackAlive - 1] = nAttack // archive the good index to keep the good one in the fighterArrayP1 or P2
                print("\(geek.nAttackAlive). \(fighterArray[nAttack].name) le \(fighterArray[nAttack].category) avec \(fighterArray[nAttack].weapon) de puissance \(fighterArray[nAttack].strenght), reste PV : \(fighterArray[nAttack].lifePoint)")
            }
        }
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
            if !geek.checkCategory  { // if it's Dwarf/Colossus/Warrior : USE weaponChestContent
                weaponOrHealthInChest(weaponOrHealthArray: weaponChestContent, newValueWeaponChestContent: newValueWeaponChestContent, whichTeam: whichTeam)
            } else if geek.checkCategory { // if it's a wizard : : USE healthChestContent
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
        let fighterArray = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        Weapon.updateStrenghtAndWeapon(fighterArray: fighterArray, attackerNumber: geek.attackerNumber, resultStrenght: resultStrenght, resultGift: resultGift)
        if resultGift != "" {
            print("C'est \(resultGift) ! Tu t'en équipes !"
                + "Ta puissance d'action est maintenant de : \(historyPrint.hAttackerFActionStrenght)")
            UserSetting.pause()
        }
    }
    
    
    /**
     randomFetichNumber : Check random Fetich number : If it's ok : resultFetich Bool become true and special action will be proposed
     */
    func randomFetichNumber(whichTeam : Int) {
        
        var fetichOk = false
        let randomFetichNumber = Int.random(in: 1..<6)
        let fighterArray = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        if randomFetichNumber == fighterArray[geek.attackerNumber].numberFetich {
            fetichOk = true
        }
        
        if fetichOk {
            switch historyPrint.hAttackerFCategory {
            case Category.warrior.rawValue:
                geek.specialFetichAction = true
            case Category.dwarf.rawValue:
                let specialInLoad = Dwarf(name: (historyPrint.hAttackerFName), numberFetich: historyPrint.hAttackerLifePoint)
                specialInLoad.specialAttack(whichTeam, historyPrint.hAttackerFActionStrenght, "")
                geek.specialFetichAction = false
            case Category.colossus.rawValue:
                geek.specialFetichAction = true
            case Category.wizard.rawValue:
                geek.specialFetichAction = true
            default:
                print("Pas d'action Fétiche ce tour ci ^^") //never happen. Have to keep it because SWITCH is on the current Attacker var
            }
        }
    }
    
    
    /**
     applyFetichBonus : The Dwarf have already apply his double damage if he find FetichNumber...but for the other : We need another function
     */
    func applyFetichBonus(whichTeam : Int) {
        
        if geek.specialFetichAction {
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
            geek.specialFetichAction = false
        }
    }
    
    
    /**
     choiceDefender : Who receive the attack or the Care
     */
    func choiceDefender(whichTeam: Int, damageInLoad: Int) {
        
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
    func healOrAttackFighter(fighterArray: [Fighter], healOrAttack: String, healOrAttack2 : String, userTeam: Team) {
        
        
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
     randomBONUS : Random BONUS (depend of Wizard or no)
     */
    func randomBonus(whichTeam: Int) {
        
        let randomBonusZone = Int.random(in: 1..<20)
        let category = historyPrint.hAttackerFCategory
        let userTeam = Tools.selectArrayTeamOneOrTwo(whichTeam: whichTeam) // constant for the defender action : Good Array, Good Fighter, depending of which Team and Category
        let userTeamInverted = Tools.selectArrayTeamInverted(whichTeam: whichTeam)
        let defenderArray = Tools.selectArrayDefenderOneorTwo(whichTeam: whichTeam)
        let defenderArrayInverted = Tools.selectArrayFightersOneorTwo(whichTeam: whichTeam)
        
        
        if randomBonusZone == 19 {  //BONUS ZONE : GOOD ACTION
            geek.bonusOrUnluckZone = true // used later for print final result
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
                historyPrint.updateHistoryDefenderDamage(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(bonusZoneWizard.count)))
                resultBonusToPrint = bonusZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderCare(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😎😎😎😎  BONUS ZONE  😎😎😎😎")
            History.actionPrint(resultBonusToPrint: resultBonusToPrint)
            geek.bonusOrUnluckZone = false
        }
        
        
        if randomBonusZone == 1 { //UNLUCK ZONE
            geek.fromUnluckZone = true
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
                historyPrint.updateHistoryDefenderDamage(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArrayInverted, userTeamName: userTeam.teamName)
            case "Magicien":
                let resultNumberBonus = Int(arc4random_uniform(UInt32(unluckyZoneWizard.count)))
                resultBonusToPrint = unluckyZoneWizard[resultNumberBonus]
                historyPrint.hAttackerFActionStrenght = instantCareValue[resultNumberBonus]
                historyPrint.updateHistoryDefenderCare(iDefender: geek.defenderNumber, damageInLoad: historyPrint.hAttackerFActionStrenght, fighterArray: defenderArray, userTeamName: userTeamInverted.teamName)
            default:
                print("Pas d'action BONUS ce tour ci ^^")
            }
            print("\r\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t😩😩😩😩  UNLUCK ZONE  😩😩😩😩")
            History.actionPrint(resultBonusToPrint: resultBonusToPrint)
            geek.fromUnluckZone = false
        }
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
