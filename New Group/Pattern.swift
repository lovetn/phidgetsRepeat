//
//  Question.swift
//  phidgetsRepeat
//
//  Created by Lovet Nguatem on 2018-11-16.
//  Copyright © 2018 Lovet Nguatem. All rights reserved.
//


import Foundation
import Phidget22Swift
class patternFunction {
   
    let patternSequence : String
    let answer1 : Bool
    let answer2 : Bool
    let answer3 : Bool
    let answer4 : Bool
    
    init(patternForPlayer: String, playerAns1: Bool,  playerAns2: Bool,  playerAns3: Bool,  playerAns4: Bool){
        patternSequence = patternForPlayer
        answer1 = playerAns1
        answer2 = playerAns2
        answer3 = playerAns3
        answer4 = playerAns4
    }
    
}
