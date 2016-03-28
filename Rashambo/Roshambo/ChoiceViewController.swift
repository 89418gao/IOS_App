//
//  ChoiceViewController.swift
//  Roshambo
//

import UIKit

class ChoiceViewController: UIViewController {


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        let vc = segue.destinationViewController as! ResultsViewController
        vc.userChoice = getUserShape(sender as! UIButton)

    }

    // MARK: Utilities

    // The enum "Shape" represents a play or move
    private func getUserShape(sender: UIButton) -> Shape {
        // Titles are set to one of: Rock, Paper, or Scissors
        let shape = sender.titleForState(.Normal)!
        return Shape(rawValue: shape)!
    }

}
