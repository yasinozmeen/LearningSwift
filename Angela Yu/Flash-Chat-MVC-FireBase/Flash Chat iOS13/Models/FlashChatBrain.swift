import UIKit
import Firebase
import FirebaseFirestore

class FlashChatBrain{
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    var tableView = ChatViewController().tableView!
    var messageTextfield = ChatViewController().messageTextfield!
    
    func loadMessages(){
            db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
                if let e = error{
                    print("error when get decument",e)
                }else{
                    self.messages = []
                    if let snapshotDocument = querySnapshot?.documents{
                        for doc in snapshotDocument{
                            let data = doc.data()
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                DispatchQueue.main.async {
                                    
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
                var _:DocumentReference?  = db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.bodyField : messageBody,
                    K.FStore.senderField : sender,
                    K.FStore.dateField : Date().timeIntervalSince1970
                ], completion: { err in
                    if let e = err{
                        print("error when adding the document: \(e.localizedDescription)")
                    }else{
                        DispatchQueue.main.async {
                            self.messageTextfield.text = ""
                        }
                        //print("succesfly save data, docId:",ref!.documentID)
                    }
                })
                loadMessages()
            }
        }
    }
}
