//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        messageTextfield.delegate = self
        
        navigationItem.hidesBackButton = true
        navigationItem.title = K.title
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        messages = []
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).getDocuments { querySnapshot, error in
            if let e = error{
                print("error when get decument",e)
            }else{
                if let snapshotDocument = querySnapshot?.documents{
                    for doc in snapshotDocument{
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                }
            }
        }
    }
    func sendMessage(){
        if let messageBody = messageTextfield.text, let sender = Auth.auth().currentUser?.email{
            if !messageBody.isEmpty{
                var ref:DocumentReference?
                ref = db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.bodyField : messageBody,
                    K.FStore.senderField : sender,
                    K.FStore.dateField : Date().timeIntervalSince1970
                ], completion: { err in
                    if let e = err{
                        print("error when adding the document: \(e.localizedDescription)")
                    }else{
                        self.messageTextfield.text = ""
                        //print("succesfly save data, docId:",ref!.documentID)
                    }
                })
                loadMessages()
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextfield.endEditing(true)
        sendMessage()
    }
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
    
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    
}
