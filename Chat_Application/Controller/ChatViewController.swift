//
//  ChatViewController.swift
//  Chat_Application
//
//  Created by Mac on 19/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
     // CREATING OUTLETS FOR EACH
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // CRTEATING DATABASE IN FIREBASE FIRESORE
     let db = Firestore.firestore()
        
        var messages: [Message] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            title = Constants.appName
            navigationItem.hidesBackButton = true
            
            tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
            
            loadMessages()
            
        }
        
        func loadMessages() {
            
            db.collection(Constants.FStore.CollectionName)
                .order(by: Constants.FStore.dateField)
                .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                       self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
            }
        }
    
         // ACTIONS PERFORMED BY USER PRESSING SEND BUTTON
        @IBAction func sendPressed(_ sender: UIButton) {
            
            if let messageBody = messageTF.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(Constants.FStore.CollectionName).addDocument(data: [
                    Constants.FStore.senderField: messageSender,
                    Constants.FStore.bodyField: messageBody,
                    Constants.FStore.dateField: Date().timeIntervalSince1970
                ]) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Successfully saved data.")
                        
                        DispatchQueue.main.async {
                             self.messageTF.text = ""
                        }
                    }
                }
            }
        }
        // ACTIONS PERFORMED BY USER PRESSING LOGOUT BUTTON
        @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
            
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        }
    }

    extension ChatViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let message = messages[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
            cell.label.text = message.body
            
            //This is a message from the current user.
            if message.sender == Auth.auth().currentUser?.email {
                cell.leftImageView.isHidden = true
                cell.rightImageView.isHidden = false
                cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
                cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            }
            //This is a message from another sender.
            else {
                cell.leftImageView.isHidden = false
                cell.rightImageView.isHidden = true
                cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
                cell.label.textColor = UIColor(named: Constants.BrandColors.lightPurple)
            }
            
          
          
            return cell
        }
    }

