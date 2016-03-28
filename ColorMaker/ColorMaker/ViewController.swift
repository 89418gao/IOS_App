//
//  ViewController.swift
//  ColorMaker
//
//  Created by GG on 5/12/15.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redControl: UISlider!
    @IBOutlet weak var greenControl: UISlider!
    @IBOutlet weak var blueControl: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set colorView on launch
        changeColorComponent()
    }
    
    @IBAction func changeColorComponent() {
        
        // Make sure the program doesn't crash if the controls aren't connected
        if self.redControl == nil {
            return
        }
        
        let red: Float = self.redControl.value
        let green: Float = self.greenControl.value
        let blue: Float = self.blueControl.value
        let r: CGFloat = CGFloat(red)
        let g: CGFloat = CGFloat(green)
        let b: CGFloat = CGFloat(blue)
        
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

