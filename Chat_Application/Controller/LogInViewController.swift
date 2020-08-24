//
//  LogInViewController.swift
//  Chat_Application
//
//  Created by Mac on 19/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController,UITextFieldDelegate {
    
    // CREATING OUTLETS FOR EACH
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textFields delegates
        EmailTF.delegate = self
        passwordTF.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //using textFieldShouldEndEditing function from delegates
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           //operations for email
           if(textField == EmailTF)
               {
                //checking email validation
                if (EmailTF.text?.isValidEmail)!
                {
               }else
                {
                   //Display Alert Message
                    displayMessage(title: "Warning", message: "Invalid Email Please Enter Valid Email-Id")
                }
              }
           return true
       }

    // ACTION PERFORMED BY PRESSING REGISER BUTTON
    @IBAction func onLogInBtn(_ sender: UIButton)
    {
        //checking password validation
        if passwordTF.text!.isValidPassword
        {
            // CONVERTING OPTIONALS INTO NON OPTIONALS STRING
            if let email = EmailTF.text, let password = passwordTF.text {
                
                // CREATING USER Login FIREBASE AUTHENTICATION
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if let err = error {
                        print(err.localizedDescription)
                    }else{
                        //NAVIGATING
                        self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                    }
                }
            }
        }else{
            //Display Alert Message
            displayMessage(title: "Warning", message: "Please Enter Valid Password")
        }
    }
    
    //Alert Controller
    func displayMessage(title:String,message:String) -> Void
     {

        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
           alert.dismiss(animated: true, completion: nil)

       }))
       self.present(alert,animated: true,completion: nil)
    }

}
