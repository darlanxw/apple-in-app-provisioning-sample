//
//  ViewController.swift
//  apple-in-app-provisioning-sample
//
//  Created by Darlan  Borges on 12/04/20.
//  Copyright © 2020 Darlan  Borges. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, PKAddPaymentPassViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check eligibility
        let eligibility = PKAddPaymentPassViewController.canAddPaymentPass()
        
        if eligibility {
            
            //Config Apple Button
            let addPassButton = PKAddPassButton()
            addPassButton.addPassButtonStyle = .black
            addPassButton.addTarget(self, action: #selector(startApplePayProvisioning), for: .touchUpInside)
            
            self.view.addSubview(addPassButton)
            
            //Constraints
            addPassButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: addPassButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: addPassButton, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
            
        } else {
            print("You are not able to provisioning cards!")
        }
    }
    
    @objc func startApplePayProvisioning() {
        let request = PKAddPaymentPassRequestConfiguration(encryptionScheme: .RSA_V2)
        request?.cardholderName  = "Darlan Borges";
        request?.primaryAccountSuffix = "5047";
        request?.localizedDescription = "This will add the card to Apple Pay";
        request?.primaryAccountIdentifier = "11242" //Filters the device and attached devices that already have this card provisioned.(Maybe cardId);
        request?.paymentNetwork = PKPaymentNetwork.masterCard
        
        let vc = PKAddPaymentPassViewController(requestConfiguration: request!, delegate: self)
        self.present(vc!, animated: true, completion: nil)
    }
}

extension ViewController {
    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController, generateRequestWithCertificateChain certificates: [Data], nonce: Data, nonceSignature: Data, completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
        //First you should get the certificates, nonce and nonceSignature to send to backend.
        //After, you get the response from backend and create an object using PKAddPaymentPassRequest and send by completionHandler.
        print("generateRequestWithCertificateChain")
    }
    
    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController, didFinishAdding pass: PKPaymentPass?, error: Error?) {
        //You must dismiss the PKAddPaymentPassViewController when this delegate method is called. There will be no further delegate callbacks after.
        print("didFinishAdding")
    }
}

