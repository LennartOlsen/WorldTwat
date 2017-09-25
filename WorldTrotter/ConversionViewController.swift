//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Lennart Olsen on 20/09/2017.
//  Copyright © 2017 Lennart Olsen. All rights reserved.
//
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var fahrenheitLabel : UILabel!
    @IBOutlet var celciusText : UITextField!
    
    var celciusValue : Measurement<UnitTemperature>? {
        didSet {    /** Observer **/
            updateFahrenheitLabel()
        }
    }
    var fahrenheitValue : Measurement<UnitTemperature>? {
        if let celciusValue = celciusValue {
            return celciusValue.converted(to: .fahrenheit)
        } else {
            return nil
        }
    }
    
    @IBAction func celciusFieldEditingChanged(_ textField : UITextField) {
        if let text = textField.text, let value = Double(text) {
            celciusValue = Measurement(value : value, unit : .celsius)
        } else {
            celciusValue = nil
        }
    }
    
    func updateFahrenheitLabel(){
        if let fahrenheitValue = fahrenheitValue {
            fahrenheitLabel.text = numberFormatter.string(from: NSNumber(value: fahrenheitValue.value))
        } else {
            fahrenheitLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer) {
        celciusText.resignFirstResponder()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    /** Dællegation **/
    func textField(_ textField : UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeperator = string.range(of:".")
        
        if existingTextHasDecimalSeperator != nil && replacementTextHasDecimalSeperator != nil {
            return false
        }
        
        return true
    }
}
