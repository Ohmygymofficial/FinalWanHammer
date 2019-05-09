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
}

