//
//  CalcViewController.swift
//  LCM-HCF
//
//  Created by Omar Ahmed on 10/4/20.
//  Copyright © 2020 Omar Ahmad. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    
    
    @IBOutlet weak var LCMResult: UILabel!
    
    @IBOutlet weak var HCFResult: UILabel!
    
    @IBOutlet weak var firstNumField: UITextField!
    
    @IBOutlet weak var secondNumField: UITextField!
    
    @IBAction func calculateButton(_ sender: UIButton) {
        let num1 = Int(firstNumField.text!)
        let num2 = Int(secondNumField.text!)
        
        let LCM_HCF = calculateValues(num1!, num2!)
        let LCM = LCM_HCF[0]
        let HCF = LCM_HCF[1]
        print(LCM)
        print(HCF)
        
        LCMResult.text = "LCM=" + String(LCM)
        HCFResult.text = "HCF=" + String(HCF)
        
    }
    
    
}
