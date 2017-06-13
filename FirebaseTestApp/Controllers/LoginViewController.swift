//
//  LoginViewController.swift
//  FirebaseTestApp
//
//  Created by Ishan Weerasooriya on 6/9/17.
//  Copyright © 2017 Elegant Media. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

   //MARK: Outlets
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    
   //MARK: variables
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     ref = Database.database().reference()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func pressedLogin(_ sender: Any) {
        
        Login()
    }
    
    
    @IBAction func pressedSignup(_ sender: Any) {
        Signup()
    }

    
    func Signup() {
    
        if txtUserName.text != nil && txtPassword.text != nil {
            
            if let email = txtUserName.text , let password = txtPassword.text {
        
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                    if let firebaseError = error {
                    
                        print(firebaseError.localizedDescription)
                        return
                    }
                    
                    print("Signup Succeed")
                    
                    //add data to the firebase DB
                    let userID: String = (user?.uid)!
                    let userEmail: String = self.txtUserName.text!
                    let userPassword: String = self.txtPassword.text!
                    
                    self.ref.child("Users").child(userID).setValue(["Email" : userEmail, "Password": userPassword])
                    print("User details added to the firebase database")
                }
            }
            
        }else {
        
            print("Failed to signup")
        }
    }
    
    
    func Login() {
    
    
        if let email = txtUserName.text, let password = txtPassword.text {
        
            Auth.auth().signIn(withEmail: email, password: password) { (message, error) in
                
                if let firebaseError = error {
                
                    print(firebaseError.localizedDescription)
                    return
                }
                print("Login Succeed")
                self.LoggedinVC()
                
            }
        }
    }
    
    
    func LoggedinVC() {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedinVC : ChatMessageViewController = storyBoard.instantiateViewController(withIdentifier: "chatVC") as! ChatMessageViewController
        self.present(loggedinVC, animated: true, completion: nil)
    
    }
    
    
    
    
    
    
    
    
    
   
}
