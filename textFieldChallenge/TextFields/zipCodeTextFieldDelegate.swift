//
//  zipCodeTextFieldDelegate.swift
//  TextFields
//
//  Created by GG on 5/27/15.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import UIKit

class zipCodeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        var newText = textField.text! as NSString
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        return newText.length <= 5

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}