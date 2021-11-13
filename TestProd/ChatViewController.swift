//
//  ChatViewController.swift
//  TestProd
//
//  Created by Chris Rinaldi on 10/18/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var db: Firestore!
    
    var itemsContainer: [Item] = [Item]()
    
    //MARK: Properties
 
    @IBOutlet weak var messageInputField: UITextField!
    
    @IBOutlet weak var chatHistoryTable: UITableView!
    
    //MARK: Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        self.chatHistoryTable.delegate = self
        self.chatHistoryTable.dataSource = self
        
        loadChatHistory()
    }
    
    @IBAction func handleSend(_ sender: Any) {
        self.performSegue(withIdentifier: "showAddView", sender: self);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create a cell to use - 'connects' the cell's view with what's on the storyboard.
        let cell = chatHistoryTable.dequeueReusableCell(withIdentifier: "MessageCell")! as! ItemViewCell
        
        //Customize the cell.
        cell.nameLabel?.text = self.itemsContainer[indexPath.row].name
        cell.descriptionLabel?.text = "This is a test description of the item."
        
        //Return the cell.
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsContainer.count
    }
    
    //Loads chat history into the UITableView.
    func loadChatHistory() {
        
        db.collection("inventory-log").addSnapshotListener { snapshot, error in
                if (error != nil) {
                    print("Error: " + error!.localizedDescription)
                }
                guard let data = snapshot else {return}
                data.documentChanges.forEach { difference in
                    if (difference.type == .added) {
                        
                        let name: String = difference.document.data()["name"] as! String, value: Float = difference.document.data()["value"] as! Float,
                            date: String = difference.document.data()["date"] as! String,
                            id: Int = difference.document.data()["id"] as! Int;
                        
                        let item: Item = Item(withName: name, value: value, date: date)
                        self.itemsContainer.append(item)
                        print("New chat: \(difference.document.data())")
                    }
                    if (difference.type == .modified) {
                        print("Modified chat: \(difference.document.data())")
                    }
                    if (difference.type == .removed) {
                        print("Removed chat: \(difference.document.data())")
                    }
                }
            
            DispatchQueue.main.async {
                self.chatHistoryTable.reloadData()
            }
            
            }
        }
    }
