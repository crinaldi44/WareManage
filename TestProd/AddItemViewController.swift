//
//  AddItemViewController.swift
//  TestProd
//
//  Created by Chris Rinaldi on 11/9/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddItemViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var itemInputField: UITextField!
    
    @IBOutlet weak var itemDescriptionField: UITextField!
    
    @IBOutlet weak var itemValueField: UITextField!
    
    
    var db: Firestore!
    
    
    //MARK: Handlers
    
    override func viewDidLoad() {
        db = Firestore.firestore();
        super.viewDidLoad();
    }
    
    //This function is called when the user presses the add item button. Performs logic
    //to submit data to Firestore.
    @IBAction func didPressAddItem(_semder: Any) {
        let name = itemInputField!.text
        let description = itemDescriptionField!.text
        let value = itemValueField!.text
        var date = Date.init();
        let item: Item = Item(withName: name!, description: description!, value: value!, date: date.description)
        self.pushToDatabase(item: item);
        self.dismiss(animated: true, completion: nil);
    }
    
    //MARK: Private
    
    //Pushes the specified Item to the database.
    private func pushToDatabase(item: Item) {
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("inventory-log").addDocument(data: [
            "name": item.name,
            "description": item.description,
            "id": item.id,
            "value": item.value,
            "date": "today",
            "sender": Auth.auth().currentUser?.email,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
//                        self.messageInputField.text = ""
            }
        }
    }
    
}
