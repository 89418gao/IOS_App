//
//  RandColorDelegate.swift
//  TextFields
//
//  Created by GG on 5/24/15.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import UIKit

class RandColorDelegate: NSObject, UITextFieldDelegate {
    
    let colors = [UIColor.redColor(),
                  UIColor.orangeColor(), UIColor.yellowColor(),
                  UIColor.greenColor(), UIColor.blueColor(),
                  UIColor.purpleColor(), UIColor.brownColor()];
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        textField.textColor = self.randomColor()
        return true
    }
    
    func randomColor() -> UIColor{
        let randomIndex = Int(arc4random() % UInt32(colors.count))
        
        return colors[randomIndex]
    }
}
