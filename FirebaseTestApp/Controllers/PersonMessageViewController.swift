//
//  PersonMessageViewController.swift
//  FirebaseTestApp
//
//  Created by Ishan Weerasooriya on 6/12/17.
//  Copyright © 2017 Elegant Media. All rights reserved.
//

import UIKit

class PersonMessageViewController: UIViewController {

    //MARK: outlets
    
    @IBOutlet var lblYourMessage: UILabel!
    @IBOutlet var lblFriendMessage: UILabel!
    @IBOutlet var txtYourMessage: UITextField!
    
    //MARK: variables
    var messageFriend = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblFriendMessage.text = messageFriend

            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    
    @IBAction func pressedSendMessage(_ sender: Any) {
        sendMyMessage()
    }
    
    func sendMyMessage() {
    
        if txtYourMessage.text != nil {
            
            lblYourMessage.text = txtYourMessage.text
            performSegue(withIdentifier: "TransferChat", sender: self)
        } else {
            
            print("Message printing to label failed")
            lblYourMessage.text = nil
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        var messageController = segue.destination as! FriendMessageViewController
        messageController.messagePerson = txtYourMessage.text!
    }

   
}
