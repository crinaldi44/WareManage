//
//  RegisterViewController.swift
//  TestProd
//
//  Created by Chris Rinaldi on 10/18/21.
//

import Foundation
import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    @IBAction func handleRegistration(_ sender: Any) {
        
        let sanitizedEmail: String = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let sanitizedPassword: String = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        promptLabel.text = ("Loading...")
        
        Auth.auth().createUser(withEmail: sanitizedEmail, password: sanitizedPassword) {
            authresult, error in
            
            if (error != nil) { //Check for errors, display the error in the box & console.
                let errorMsg = error!.localizedDescription
                print(errorMsg)
                self.promptLabel.text = errorMsg
            } else {
                self.displayAlertPopover()
            }
        }
    }
    
    //Displays an alert popover.
    func displayAlertPopover() {
        let alert: UIAlertController = UIAlertController(title: "Registration", message: "Success! Please login using your newly-created username and password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default) {
            _ in
            self.dismiss(animated: true, completion: nil);
        })
        self.present(alert, animated: true, completion: nil);
    }
    
    //Handles when a user taps the back button, which will unwind the segue.
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //What happens when the view loads.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
