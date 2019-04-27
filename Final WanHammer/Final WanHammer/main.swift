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
            // add userInput function
            // add battleMode function
            print("Fonction à ajouter")
        case "2":
            print("Lâcheur ! 😜")
            stayInProgram = false
        default: print("je n'ai pas compris")
        }
    }
}


while stayInProgram == true {
    principalMenu()
}
