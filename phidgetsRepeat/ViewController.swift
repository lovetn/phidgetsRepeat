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
//button variables
      let button0 = DigitalInput()
      let button1 = DigitalInput()
      let led2 = DigitalOutput()
      let led3 = DigitalOutput()
   
    
    @IBOutlet weak var partternLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
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
                print("Button Green Pressed")
                try led2.setState(true)
                
            }
            else{
                print("Button Green Not Pressed")
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
                print("Button Green Pressed")
                try led3.setState(true)
                
            }
            else{
                print("Button Green Not Pressed")
                try led3.setState(false)
                
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    

        
        
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
