//
//  PaymentViewController.swift
//  G2G
//
//  Created by Mena Abdelmalak on 12/10/22.
//

import UIKit
import BraintreeDropIn
class PaymentViewController: UIViewController, UITextFieldDelegate {
    
    var braintreeClient: BTAPIClient!
   
    @IBOutlet var paymentAmount: UITextField!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        braintreeClient=BTAPIClient(authorization:"sandbox_4xmmzqmc_vyb2sq6z6krjsvhq")

    }

    
    private let notifciationCenter=NotificationCenter.default
    
    @IBAction func PayButtonPressed(_ sender: Any) {
        if paymentAmount==nil{
            let alert=UIAlertController(title:"Please enter the amount you wish to donate", message:nil, preferredStyle: UIAlertController.Style.alert)
        }else{
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient)
        let x:String=paymentAmount.text!
        let checkoutRequest = BTPayPalCheckoutRequest(amount: x)
           payPalDriver.tokenizePayPalAccount(with: checkoutRequest) { (tokenizedPayPalAccount, error) in
        if let tokenizedPayPalAccount = tokenizedPayPalAccount {
            self.navigationController?.popViewController(animated: true)
            self.notifciationCenter.post(name: NSNotification.Name("paymentProcessed"), object:x)
            print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
            let email = tokenizedPayPalAccount.email
            let firstName = tokenizedPayPalAccount.firstName
            let lastName = tokenizedPayPalAccount.lastName
            let phone = tokenizedPayPalAccount.phone
            let billingAddress = tokenizedPayPalAccount.billingAddress
            let shippingAddress = tokenizedPayPalAccount.shippingAddress
           
            
        } else if let error = error {

        } else {
        }
    }
        }
    }
    
    func checkout(){
        
    }
    
    
   /* func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCanceled == true) {
                print("CANCELED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                let selectedPaymentMethodType = result.paymentMethodType
                let selectedPaymentMethod = result.paymentMethod
                let selectedPaymentMethodIcon = result.paymentIcon
                let selectedPaymentMethodDescription = result.paymentDescription
            }
            
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)

    }*/
    
   
    }
