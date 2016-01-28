//
//  ViewController.swift
//  First Calculator
//
//  Created by Andrew2 on 1/26/16.
//  Copyright © 2016 Andrew. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl : UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation : Operation = Operation.Empty
    var result = ""
    
    
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        //do this(try assigning sound to btn sound), if there is some sort of problem, then catch it in the err var as an error. Later, prnt the error on the console
        
    
    }
    
    @IBAction func numPresses(btn:UIButton!) {
        //the bttn you pressed will be droped into function via the parameter, that is why we label it as a UIButton
        
        playSound()
        
        runningNumber += "\(btn.tag)"
        //btn.tag will be the number
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    func processOperation (op: Operation) {
       playSound()
        if currentOperation != Operation.Empty {
            //run math
            
            //user selected an operator but then selected another operator without entering a number
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result

                
            }

                       currentOperation = op
            
            
        } else {
            //This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

