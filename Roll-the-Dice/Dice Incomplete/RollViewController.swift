//
//  RollViewController.swift
//  Dice
//
//  Created by GG on 5/16/15.
//  Copyright (c) 2015 GG. All rights reserved.
//

import UIKit

class RollViewController: UIViewController {
    /**
    * Randomly generates an Int from 1 to 6
    */
    func randomDiceValue() -> Int {
        // Generate a random Int32 using arc4Random
        let randomValue = 1 + arc4random() % 6
        
        // Return a more convenient Int, initialized with the random value
        return Int(randomValue)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! DiceViewController
        controller.firstValue = self.randomDiceValue()
        controller.secondValue = self.randomDiceValue()
        
    }

    @IBAction func rollTheDice() {
        performSegueWithIdentifier("rollDice", sender: self)
    }
    
    
}

