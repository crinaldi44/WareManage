//
//  ViewController.swift
//  TestProd
//
//  What we are going to do is create a simple chat app using a no-SQL database
//  preferably Firebase. The app will first require a user to sign in with their
//  email and password (if one exists) and then once we've logged in, will require them
//  to select a 'nickname' (non-unique).
//
//  Barebones of the project: sign in using auth. Create a request upon login to
//  display the contents of a Firestore database (REST-style) and display them
//  to the screen. Once a message is 'sent', we will create another request to add
//  data into the system.
//
//  Created by Chris Rinaldi on 3/8/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var promptLabel: UILabel!
    
    
    //Handles a login action.
    @IBAction func handleLogin(_ sender: Any) {
        
        let authData = cleanInput();
        
        promptLabel.text = "Attempting to login..."
        
        Auth.auth().signIn(withEmail: authData[0], password: authData[1]) {
            authresult, error in
            
            if (error != nil) {
                let errMsg: String = error!.localizedDescription
                self.promptLabel!.text = errMsg;
                print("error: " + errMsg);
                return
            } else {
                self.promptLabel!.text = "Success! Logging you in."
                self.performSegue(withIdentifier: "showChat", sender: self)
            }
        }
        
    }
    
    //Cleans user input and returns an arra
    func cleanInput() -> [String] {
        
        let email: String = (usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        let password: String = (passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        return [email, password];
    }
    
    //Handles registration.
    @IBAction func handleRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "showRegistration", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /**
     Represents a message.
     */
    struct Message {
        let sender: User;
        let message: String;
        let id: Int64;
        let timeStamp: String;
    }
    
    /**
     Represents a unique user sending a message.
     */
    struct User {
        let username: String;
        let rank: Int;
    }


}

