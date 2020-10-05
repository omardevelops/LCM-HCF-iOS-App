//
//  ViewController.swift
//  LCM-HCF
//
//  Created by Omar Ahmed on 10/3/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Class variables
    var firstNum = 80
    var secondNum = 120
    var victory = false // Variable used to allow user to move to next level
    
    // Each index corresponds to a pair of numbers from these lists
    let numsList1 = [14, 36, 81, 80, 15, 7, 98, 52, 16, 18, 66, 102, 505]
    let numsList2 = [35, 4, 54, 120, 22, 7, 30, 10, 32, 240, 96, 201, 105]
    
    var listIndex = 0 // Index for both lists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateNumbers()
    }
    
    func generateNumbers() {
        submitButtonOut.setTitle("Submit", for: .normal)
        submitButtonOut.backgroundColor = UIColor.systemGreen
        firstNumLabel.textColor = UIColor.black
        
        firstNum = numsList1[listIndex]
        secondNum = numsList2[listIndex]
        
        firstNumLabel.text = "lvl" + String(listIndex+1) + ": " + String(firstNum) + " & " +  String(secondNum)
        secondNumLabel.text = " "
        
        if(listIndex < numsList1.count - 1) {
            listIndex = listIndex+1
        } else {
            listIndex = 0
        }
    }
    
    func getPrimeFactors(_ myNumber: Int) -> [Int] {
        var primeFactors = [Int]()
        var n = myNumber
        var d = 2 // Starting from the lowest possible prime factor
        
        while (n > 1) {
            while(n % d == 0) {
                primeFactors.append(d) // Adds prime factor
                n /= d // Reduces the number by that prime factor
            }
            d = d + 1
        }
        
        return primeFactors
    }
    
    func getIntersection(array1 : [Int], array2 : [Int]) -> [Int] {
        return array2.filter(array1.contains) // An alternative way to find intersection, may not be used anymore due to a bug
    }
    
    func calculateValues(_ num1 : Int,_ num2 : Int) -> [Int] {
        let firstNum = num1
        let secondNum = num2

        var firstPrimeFactors = getPrimeFactors(firstNum)
        var secondPrimeFactors = getPrimeFactors(secondNum)
        var intersectPrimes = [Int]() // Initialize to add intersection of both arrays
        
        print(firstPrimeFactors)
        print(secondPrimeFactors)
        print(intersectPrimes)

        // The Venn Diagram section
        // Common elements in both arrays are removed from their array into intersection array

        for num in firstPrimeFactors {
            let index1 = firstPrimeFactors.firstIndex(of: num)
            if let index2 = secondPrimeFactors.firstIndex(of: num) {
                intersectPrimes.append(secondPrimeFactors.remove(at: index2))
                firstPrimeFactors.remove(at: index1!)
            }
            
        }

        var LCM = 1
        var HCF = 1

        for element in intersectPrimes {
            LCM *= element
            HCF *= element
        }

        for element in firstPrimeFactors {
            LCM *= element
        }

        for element in secondPrimeFactors {
            LCM *= element
        }

        return [LCM, HCF]
    }
    
    
    // Outlets and Actions Declarations
    @IBOutlet weak var firstNumLabel: UILabel!
    
    @IBOutlet weak var secondNumLabel: UILabel!
    
    @IBOutlet weak var LCM_Field: UITextField!
    
    @IBOutlet weak var HCF_Field: UITextField!
    
    @IBOutlet weak var submitButtonOut: UIButton!
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        
        if(victory) {
            victory = false
            generateNumbers()
        } else {
        
        let LCM_HCF = calculateValues(firstNum, secondNum)
        let LCM = LCM_HCF[0]
        let HCF = LCM_HCF[1]

        let userLCMInput = Int(LCM_Field.text ?? "nil") ?? -1
        let userHCFInput = Int(HCF_Field.text ?? "nil") ?? -1
            
        if (userLCMInput <= 0 || userHCFInput <= 0) {
                let alert = UIAlertController(title: "Invalid values!", message: "Make sure to enter a positive integer.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                self.present(alert, animated: true)
        }
        
        else if (userLCMInput == LCM && userHCFInput == HCF) {
            victory = true
            firstNumLabel.textColor = UIColor.systemGreen
            
            secondNumLabel.text = "Both correct! :)"
            secondNumLabel.textColor = UIColor.systemGreen
            
            
            submitButtonOut.setTitle("Next Level", for: .normal)
            submitButtonOut.backgroundColor = UIColor.systemBlue
            
        }
        else if (userLCMInput == LCM && userHCFInput != HCF) {
            firstNumLabel.textColor = UIColor.systemRed
            
            secondNumLabel.text = "HCF is wrong!"
            secondNumLabel.textColor = UIColor.systemRed
            
        }
        else if (userLCMInput != LCM && userHCFInput == HCF) {
            firstNumLabel.textColor = UIColor.systemRed
            
            secondNumLabel.text = "LCM is wrong!"
            secondNumLabel.textColor = UIColor.systemRed
            
        }
        else {
            firstNumLabel.textColor = UIColor.systemRed
            
            secondNumLabel.text = "Both wrong :("
            secondNumLabel.textColor = UIColor.systemRed
        }
            
        }
        
    }
    
    


}

