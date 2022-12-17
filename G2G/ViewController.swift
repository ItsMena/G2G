//
//  ViewController.swift
//  G2G
//
//  Created by Mena Abdelmalak on 11/28/22.
//

import UIKit
import BraintreeDropIn

class ViewController: UIViewController {

    let pvc=PaymentViewController()
    private let notificationCenter=NotificationCenter.default
    
    
    @IBOutlet var percentComplete: UILabel!
    @IBOutlet var percentBar: UIProgressView!
    
   
    var amountGoal:Float=5000
    var amountPaid:Float=0
    let defaults=UserDefaults.standard
    var calculation:Float=0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedPercent()// Show Progress Bar and label with saved data
        notificationCenter.addObserver(self, selector: #selector(updatePercent), name: NSNotification.Name("paymentProcessed"), object: nil)//recieves requests of payments
        
    }
    func savedPercent(){
        let saved=defaults.float(forKey: "SavedCalculation10")
        let roundedSaved=round(saved*100)/100
        percentBar.setProgress(roundedSaved/100, animated: true)
        percentComplete.text!="\(roundedSaved) %"
    }
    
    @objc func updatePercent(_ notification:NSNotification){
        let text=notification.object as! String?
        let textConversion=NumberFormatter().number(from: text!)!.floatValue
        amountPaid=amountPaid+textConversion
        defaults.set(calculation,forKey:"SavedCalculation10")
        calculation=(amountPaid/amountGoal)*100
        defaults.set(calculation,forKey: "SavedCalculation10")
        savedPercent()
        print(calculation)
        
        
    }
    


}

