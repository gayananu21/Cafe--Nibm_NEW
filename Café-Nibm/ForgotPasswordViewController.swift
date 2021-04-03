//
//  ForgotPasswordViewController.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.navigationController?.navigationBar.alpha = 1

        // Do any additional setup after loading the view.
         self.emailTextField.addBottomBorder()
        
        
        //Looks for single or multiple taps.
                    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                          //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                          //tap.cancelsTouchesInView = false

                    view.addGestureRecognizer(tap)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
            }

    @IBAction func reset_passwordClicked(_ sender: Any) {
        
        self.errorLabel.alpha = 1
        let email = self.emailTextField.text ?? ""
               
               Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                 if let error = error as? NSError {
                   switch AuthErrorCode(rawValue: error.code) {
                   case .userNotFound:
                     // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                           self.errorLabel.text = "The email address is badly formatted"
                   case .invalidEmail:
                     // Error: The email address is badly formatted.
                            self.errorLabel.text = "The email address is badly formatted"
                   case .invalidRecipientEmail:
                     // Error: Indicates an invalid recipient email was sent in the request.
                       self.errorLabel.text = "Indicates an invalid recipient email was sent in the request"
                   case .invalidSender:
                     // Error: Indicates an invalid sender email is set in the console for this action.
                       self.errorLabel.text = "The email address is badly formatted"
                   case .invalidMessagePayload:
                     // Error: Indicates an invalid email template for sending update email.
                       self.errorLabel.text = "Indicates an invalid email template for sending update email"
                   default:
                       
                     print("Error message: \(error.localizedDescription)")
                       self.errorLabel.text = "Error unable to send verification email"
                   }
                 } else {
                   print("Reset password email has been successfully sent")
                   self.errorLabel.text = "Reset password email has been successfully sent"
                 }
               }
    }
}

extension UITextField {
    func addBottomBorder2(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: 1200, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
