//
//  FriendMessageViewController.swift
//  FirebaseTestApp
//
//  Created by Ishan Weerasooriya on 6/12/17.
//  Copyright © 2017 Elegant Media. All rights reserved.
//

import UIKit

class FriendMessageViewController: UIViewController {

    //MARK: outlets 
    
    @IBOutlet var lblYourMessage: UILabel!
    @IBOutlet var lblFriendMessage: UILabel!
    @IBOutlet var txtMessage: UITextField!
    
    
    //MARK: variables
    var messagePerson = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblYourMessage.text = messagePerson

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func pressedSendMessage(_ sender: Any) {
        sendFriendMessage()
    }
    
    func sendFriendMessage() {
    
        if txtMessage.text != nil {
            lblFriendMessage.text = txtMessage.text
            performSegue(withIdentifier: "TransferFriendChat", sender: self)
        } else {
        
            print("Message print failed")
        }
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var transferFriendMessage = segue.destination as! PersonMessageViewController
        transferFriendMessage.messageFriend = txtMessage.text!
    }

   
}
