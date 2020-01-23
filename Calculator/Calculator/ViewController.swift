//
//  ViewController.swift
//  Calculator
//
//  Created by Diogo Bettencourt on 22/01/2020.
//  Copyright © 2020 Diogo Bettencourt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Calculator Variables
    var numbers: [String] = [];
    var operators: [String] = [];
    var operation: Int = 0;
    
    // Dark Mode Variable
    var darkMode: Bool = true;
    
    @IBOutlet weak var results: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        resetCalculator()
    }
    
    @IBAction func numbers(_ sender: UIButton) {

        if (numbers.count == operators.count) {
            numbers.append(String(sender.tag-1));
        } else {
            numbers[numbers.count - 1] = numbers[numbers.count-1] + String(sender.tag-1);
        }
    
        results.text = results.text! + String(sender.tag-1);
        
    }
        
    @IBAction func buttons(_ sender: UIButton) {
        
        if sender.tag != 11 && sender.tag != 16 {
            
            if (operators.count == numbers.count) {
                return;
            }
            
            if sender.tag == 12 { //Divide
                results.text = results.text! + "/";
                operators.append("/");
            }
            
            if sender.tag == 13 { //Multiply
                results.text = results.text! + "*";
                operators.append("*");
            }
            
            if sender.tag == 14 { //Subtract
                results.text = results.text! + "-";
                operators.append("-");
            }
            
            if sender.tag == 15 { //Add
                results.text = results.text! + "+";
                operators.append("+");
            }
            
            operation = sender.tag;
            
        }
        
        if sender.tag == 16 && numbers.count >= 2 && operators.count >= 1 {
            
            var finalResults: String = "";
            var operatorNumber: Int = 0;
            
            for number in numbers {
                finalResults = finalResults + number;
                
                if (operatorNumber < operators.count) {
                    finalResults = finalResults + operators[operatorNumber];
                    operatorNumber = operatorNumber + 1;
                }
            }
            
            let operation: NSExpression = NSExpression(format: finalResults);
            let result: NSNumber = operation.expressionValue(with: nil, context: nil) as! NSNumber;
            
            finalResults = formatNumber(number: result.doubleValue);
            results.text = finalResults;
        }
        
        if sender.tag == 11 {
            resetCalculator();
        }
        
    }
  
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var darkModeInfo: UILabel!
    
    @IBAction func darkMode(_ sender: UISwitch) {
        
        if (sender.isOn) {
            background.backgroundColor = .black
            results.textColor = .white;
            darkModeInfo.textColor = .white;
        }
        
        if (!sender.isOn) {
            background.backgroundColor = .white;
            results.textColor = .black;
            darkModeInfo.textColor = .black;
        }
        
    }
    
    func isDouble(number: Double) -> Bool {
        return floor(number) == number;
    }
    
    func formatNumber(number: Double) -> String {
        if isDouble(number: number) {
            return String(Int(number));
        } else {
            return String(number);
        }
    }
    
    func resetCalculator() {
        results.text = "";
        numbers.removeAll();
        operators.removeAll();
        operation = 0;
    }
    
}

