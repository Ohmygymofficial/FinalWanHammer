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
     selectArrayTeamOneOrTwo : If it's Team 1 : Return Array1. If it's team2 : Return Array2
     */
    
    static func selectArrayTeamOneOrTwo(whichTeam : Int) -> Team {
        
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
    
    static func selectArrayTeamInverted(whichTeam : Int) -> Team {
        
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
    static func selectArrayFightersOneorTwo(whichTeam : Int) -> [Fighter] {
        
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
    static func selectArrayDefenderOneorTwo(whichTeam : Int) -> [Fighter] {
        
        var defenderArray = wanHammer.fighterArrayP2
        if whichTeam == 2 {
            defenderArray = wanHammer.fighterArrayP1
            return defenderArray
        }
        return defenderArray
    }
    
    
    /**
     addWinAndLooseValue : At the end of the Game, give +1 to the value Win or Loose for each Team
     */
    
    static func addWinAndLooseValue () {
        
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
        UserSetting.pause()
    }
    
    
    /**
     resetFighters : Function to reset All the parameters of each Fighters on each teams
     */
    
    static func resetFighters(fighterArray: [Fighter],userArray: Team, symbol: String) {
        
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

    
}

