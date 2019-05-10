//
//  Tools.swift
//  Final WanHammer
//
//  Created by E&M Life Project on 10/05/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation

class Tools {
    
    
    /**
     selectArrayTeamOneOrTwo : If it's Team 1 : Return Array1. If it's team2 : Return Array2
     */
    
    static func selectArrayTeamOneOrTwo(whichTeam : Int) -> Team {
        
        var userTeamName = geek.userArray[0]
        if whichTeam == 2 {
            userTeamName = geek.userArray[1]
            return userTeamName
        }
        return userTeamName
    }
    
    
    /**
     selectArrayTeamInverted : If it's Team 1 : Return Array2. If it's team2 : Return Array1 : Used for Wizard Care for example
     */
    
    static func selectArrayTeamInverted(whichTeam : Int) -> Team {
        
        var userTeamInverted = geek.userArray[1]
        if whichTeam == 2 {
            userTeamInverted = geek.userArray[0]
            return userTeamInverted
        }
        return userTeamInverted
    }
    
    
    /**
     selectArrayFightersOneorTwo : If it's Team 1 : Return FighterP1. If it's team2 : Return FighterP2
     */
    static func selectArrayFightersOneorTwo(whichTeam : Int) -> [Fighter] {
        
        var fighterArray = geek.fighterArrayP1
        if whichTeam == 2 {
            fighterArray = geek.fighterArrayP2
            return fighterArray
        }
        return fighterArray
    }
    
    
    /**
     selectArrayDefenderOneorTwo : If it's Team 1 : Return FighterP2. If it's team2 : Return FighterP1
     */
    static func selectArrayDefenderOneorTwo(whichTeam : Int) -> [Fighter] {
        
        var defenderArray = geek.fighterArrayP2
        if whichTeam == 2 {
            defenderArray = geek.fighterArrayP1
            return defenderArray
        }
        return defenderArray
    }
    
    
}
