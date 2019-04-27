//
//  Team.swift
//  Final WanHammer
//
//  Created by Erwan Paste iMac on 27/04/2019.
//  Copyright © 2019 Erwan Paste iMac. All rights reserved.
//

import Foundation
class Team {
    
    var gamerName : String
    var teamName : String
    
    static let numberOfFighters = 3
    var winCounter = 0
    var looseCounter = 0
    
    init(gamerName: String, teamName: String) {
        self.gamerName = gamerName
        self.teamName = teamName
    }
    
}

