//
//  ViewController.swift
//  phidgetsRepeat
//
//  Created by Lovet Nguatem on 2018-11-15.
//  Copyright © 2018 Lovet Nguatem. All rights reserved.
//

import UIKit
import Phidget22Swift


class ViewController: UIViewController {
    
    let allPatterns = patterns()
    
    //button variables
      let button0 = DigitalInput()
      let button1 = DigitalInput()
      let led2 = DigitalOutput()
      let led3 = DigitalOutput()
    var buttonpressed : Bool = false
    var patternNumber : Int = 0
    var buttonOrder : Int = 0
    var pickedAnswer1 : Bool = false
    var pickedAnswer2 : Bool = false
    var pickedAnswer3 : Bool = false
    var pickedAnswer4 : Bool = false
    var score : Int = 0
    
   
    
    @IBOutlet weak var partternLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
   
    
    func attach_handler(sender: Phidget){
        do{
            if(try sender.getHubPort() == 0){
                print("Button 0 Attached")
            }
            else{
                print("Button 1 Attached")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    func state_change_button0(sender:DigitalInput, state:Bool){
        do {
            if(state == true){
//                print("Button Green Pressed")
                try led2.setState(true)
                
                if (buttonOrder == 0){
                    // START THE GAME
                    nextPattern()
                    buttonOrder += 1
                }
                else if (buttonOrder == 1){
                    pickedAnswer1 = true
                    buttonOrder += 1
                }
                else if (buttonOrder == 2){
                    pickedAnswer2 = true
                    buttonOrder += 1
                }
                else if (buttonOrder == 3){
                    pickedAnswer3 = true
                    buttonOrder += 1
                }
                else if (buttonOrder == 4){
                    pickedAnswer4 = true
                    
                    //CHECK THE ANSWERS
                    checkAnswers()
                    updateUI()
                    patternNumber += 1
                    nextPattern()
                }
                
            }
            else{
//                print("Button Green Not Pressed")
                try led2.setState(false)
                
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }

    }
    
    func state_change_button1(sender:DigitalInput, state:Bool){
        do {
            if(state == true){
//                print("Button Green Pressed")
                try led3.setState(true)
                
                if (buttonOrder == 0){
                    // START THE GAME
                    nextPattern()
                    buttonOrder += 1
                }
                else if (buttonOrder == 1){
                    pickedAnswer1 = false
                    buttonOrder += 1
                }
                else if (buttonOrder == 2){
                    pickedAnswer2 = false
                    buttonOrder += 1
                }
                else if (buttonOrder == 3){
                    pickedAnswer3 = false
                    buttonOrder += 1
                }
                else if (buttonOrder == 4){
                    pickedAnswer4 = false
                    
                    //CHECK THE ANSWERS
                    checkAnswers()
                    updateUI()
                    patternNumber += 1
                    nextPattern()
                }
                
            }
            else{
//                print("Button Green Not Pressed")
                try led3.setState(false)
                
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func updateUI(){
        
        DispatchQueue.main.async {
            self.scoreLabel.text = "\(self.score)"
            
        }
        
    }
    
    func nextPattern(){
        if patternNumber <= 2 {
            DispatchQueue.main.async {
                self.partternLabel.text = self.allPatterns.list[self.patternNumber].patternSequence
                self.scoreLabel.text = ("score: \(self.score)")
                self.updateUI()
        }
        }else {
            DispatchQueue.main.async {
                self.answerLabel.text = "done"
                self.partternLabel.text = ""
            }
             let alert = UIAlertController( title: "Awsome", message: "You've finished the game", preferredStyle: .alert)
              let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction)in self.startOver()
            
        })
        
            alert.addAction(restartAction)
            
        present(alert, animated: true, completion: nil)
        
        
    }
    }
   func startOver() {
    score = 0
   patternNumber = 0
    nextPattern()
    }
    
    
    
    func checkAnswers() {
        let correctAnswer1 = allPatterns.list[patternNumber].answer1
        let correctAnswer2 = allPatterns.list[patternNumber].answer2
        let correctAnswer3 = allPatterns.list[patternNumber].answer3
        let correctAnswer4 = allPatterns.list[patternNumber].answer4
        
        if (correctAnswer1 == pickedAnswer1 && correctAnswer2 == pickedAnswer2 && correctAnswer3 == pickedAnswer3 && correctAnswer4 == pickedAnswer4) {
            print("correct")
            DispatchQueue.main.async {
                
                self.answerLabel.text = "You are correct"
                self.score = self.score + 1
            }
        } else {
            print("incorrect")
            DispatchQueue.main.async {
                self.answerLabel.text = "incorrect"
            }
        }
        print(pickedAnswer1)
        print(pickedAnswer2)
        print(pickedAnswer3)
        print(pickedAnswer4)
        
        buttonOrder = 1
        
    }
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        partternLabel.text = "Click a button to start"
        
        
        do{
            
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            try button0.setDeviceSerialNumber(528055)
            try button0.setHubPort(0)
            try button0.setIsHubPortDevice(true)
            
            try button1.setDeviceSerialNumber(528055)
            try button1.setHubPort(1)
            try button1.setIsHubPortDevice(true)
            
            try led2.setDeviceSerialNumber(528055)
            try led2.setHubPort(2)
            try led2.setIsHubPortDevice(true)
            
            try led3.setDeviceSerialNumber(528055)
            try led3.setHubPort(3)
            try led3.setIsHubPortDevice(true)
            
            let _ = button0.stateChange.addHandler(state_change_button0)
            let _ = button1.stateChange.addHandler(state_change_button1)
            
            let _ = button0.attach.addHandler(attach_handler)
            let _ = button1.attach.addHandler(attach_handler)
            let _ = led2.attach.addHandler(attach_handler)
            let _ = led3.attach.addHandler(attach_handler)

            
            try button0.open()
            try button1.open()
            try led2.open()
            try led3.open()

        } catch let err as PhidgetError {
            print ("phidget Error" + err.description)
        } catch{
        }
        
     }
}


//let firstPattern = allPatterns.list[0]
//partternLabel.text = firstPattern.patternSequence
