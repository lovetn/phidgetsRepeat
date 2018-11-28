//
//  QuestionBank.swift
//  phidgetsRepeat
//
//  Created by Lovet Nguatem on 2018-11-16.
//  Copyright © 2018 Lovet Nguatem. All rights reserved.
//

import Foundation

import UIKit

class patterns{
    
    var list = [patternFunction]()
    
    init(){
     
        let item = patternFunction(patternForPlayer: "red-red-red-green", playerAns1: false, playerAns2: false, playerAns3: false, playerAns4: true)
        
        list.append(item)
       
        list.append(patternFunction(patternForPlayer: "Green, Green, Red, Red", playerAns1: true, playerAns2: true, playerAns3: false, playerAns4: false))

        list.append(patternFunction(patternForPlayer: "Red, Green, Red, Green", playerAns1: false, playerAns2: true, playerAns3: false, playerAns4: true))

}

}
