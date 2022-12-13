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
    
   
    var amountGoal=Float(5000)
    var amountPaid=Float(0)
    var calculation=Float(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationCenter.addObserver(self, selector: #selector(updatePercent), name: NSNotification.Name("paymentProcessed"), object: nil)
        percentBar.setProgress(0, animated: true)
        
    }
    
    @objc func updatePercent(_ notification:NSNotification){
        let text=notification.object as! String?
        let textConversion=NumberFormatter().number(from: text!)!.floatValue
        amountPaid=amountPaid+textConversion
        calculation=(amountPaid/amountGoal)*100
        percentBar.setProgress(calculation/100, animated: true)
        print(calculation)
        percentComplete.text!="\(calculation) %"
        
     //   amountPaid=amountPaid+(Int(pvc.paymentAmount.text!)
      //  let totalProgress = Float(amountPaid)/Float(amountGoal)
       // percentBar.setProgress(totalProgress, animated: true)
        //let x:String=pvc.paymentAmount.text!
        //self.percentComplete.text=x
        
    }
    


}

