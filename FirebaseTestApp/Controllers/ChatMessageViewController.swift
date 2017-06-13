//
//  ChatMessageViewController.swift
//  FirebaseTestApp
//
//  Created by Ishan Weerasooriya on 6/12/17.
//  Copyright © 2017 Elegant Media. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatMessageViewController: UIViewController {

   //MARK: outlets
    
    @IBOutlet var lblYourMessage: UILabel!
    @IBOutlet var lblFriendMessage: UILabel!
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var lblUserName: UILabel!
    
   //MARK: variables
    var ref = Database.database().reference()
    var partner: String?
    var appUserkey: String = ""
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  showMessage()
        checkExisitingData()
//        searchData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressedLogout(_ sender: Any) {
        
        do{
        
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            
        }catch {
        
            print("Failed to logout")
        }
    }
    
    
    func showMessage() {
//    Auth.auth().currentUser?.email
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
        
           // print(snapshot)
            
            
            let value1 = snapshot.value as? NSDictionary
            let userEmail = value1?["Email"] as? String ?? ""
            
          //  print(userEmail)
            self.lblUserName.text = userEmail
        

//            let value = snapshot.value as? NSDictionary
//            let lastMsg = value?["LastMessage"] as? String ?? ""
//            
//            print("LastMessage:\(lastMsg)")
//             self.lblYourMessage.text = lastMsg
            
          })
        
    }
    
    
    func checkExisitingData() {
    
        var userEmail = Auth.auth().currentUser?.email
        Database.database().reference().child("Users").observeSingleEvent(of: .value, with: {(snapshot) in
        
        
            if let snapData = snapshot.value as? [String: AnyObject] {
            
                for data in snapData {
                
                   // let value = snapshot.value as? NSDictionary
                    let key = data.key as! String
                    let email = data.value["Email"] as! String
                    print(email)
                    
                    if email == userEmail {
                        self.appUserkey = key
                    }else {
                        
                        print("Different User")
                        self.partner = email
                        self.searchData()
                    }
                    
                }
            
            }
            
            
        })
        
    }
    
    
    
    func searchData() {
    
        let databaseReference = Database.database().reference()
        databaseReference.child("Users").queryOrdered(byChild: "Email").queryEqual(toValue: partner).observe(DataEventType.value, with: {snapshot in
            
            if let snapData = snapshot.value as? [String: AnyObject] {
                
                for data in snapData {
                    
                    let key = data.key as! String
                    let lastMessage = data.value["LastMessage"] as! String
                    print(lastMessage)
                    self.lblFriendMessage.text = lastMessage
                }
                
            }

        })
        
        let currentUserEmail = Auth.auth().currentUser?.email
        databaseReference.child("Users").queryOrdered(byChild: "Email").queryEqual(toValue: currentUserEmail).observe(DataEventType.value, with: {snapshot in
            
            if let snapData = snapshot.value as? [String: AnyObject] {
                
                for data in snapData {
                    
                    let key = data.key as! String
                    let lastMessage = data.value["LastMessage"] as! String
                    print(lastMessage)
                    self.lblYourMessage.text = lastMessage
                }
            }
            
            })

        
        /*
        databaseReference.child("Users").queryOrdered(byChild: "Email").queryEqual(toValue: self.lblUserName.text).observeSingleEvent(of: .value, with: {(snapshot) in
            
            
            
            if let snapData = snapshot.value as? [String: AnyObject] {
            
                for data in snapData {
                
                    let key = data.key as! String
                    let lastMessage = data.value["LastMessage"] as! String
                    print(lastMessage)
                }
            
            }
            
//            let value1 = snapshotData.value as? NSDictionary
//            let checkUserName = value1?["Email"] as? String
//            
//            self.lblUserName.text = checkUserName
            
            
//            let value = snapshotData.value as? NSDictionary
//            let lastMsg = value?["LastMessage"] as? String ?? ""
//            
//            print("LastMessage:\(lastMsg)")
//            self.lblYourMessage.text = lastMsg
            
            
        })
        */
    }
    
    func updateChat() {
        
         let updateNode = ref.child("Users").child(appUserkey)
        
        updateNode.updateChildValues(["LastMessage": self.txtMessage.text!])
        
        print("Update Succeed")
        
    }
    
    
    @IBAction func pressedSendMessage(_ sender: Any) {
        
        
        if txtMessage.text != nil {
//            lblYourMessage.text = txtMessage.text
            updateChat()
        }
        
        
        
    }

   
}
