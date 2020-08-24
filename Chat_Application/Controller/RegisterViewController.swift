//
//  RegisterViewController.swift
//  Chat_Application
//
//  Created by Mac on 19/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    // CREATING OUTLET
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTF.delegate = self
        passwordTF.delegate = self

        // Do any additional setup after loading the view.
    }
    
     //using textFieldShouldEndEditing function from delegates
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //operations for email
        if(textField == EmailTF)
            {
             if (EmailTF.text?.isValidEmail)!
             {
                
            }
            else
             {
                //Display Alert Message
                displayMessage(title: "Warning", message: "Invalid Email Please Enter Valid Email-Id")

             }
           }
      
        return true
    }

     // ACTION PERFORMED BY PRESSING REGISER BUTTON
    @IBAction func onRegisterBtn(_ sender: UIButton)
    {
        //Password validation Checking
        if (passwordTF.text?.isValidPassword)!{
           
            // CONVERTING OPTIONALS INTO NON OPTIONALS STRING
            if let email = EmailTF.text , let password = passwordTF.text {
                
            // CREATING USER USING FIREBASE (PASSWORD  AUTHENTICATION)
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                }else
                {
                    //NAVIGATING
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
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
        // MOVING FROM THIS CONTROLLER TO CHAT VIEW CONTROLLER
       self.present(alert,animated: true,completion: nil)
    }
    
}
//string extension
extension String
 {
  var isValidEmail:Bool
   {
    let emailContains = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    let emailText = NSPredicate(format: "SELF MATCHES %@", emailContains)
    return emailText.evaluate(with: self)
   }
//for password validation
    var isValidPassword:Bool
    {
      let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
      let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
      return passwordtesting.evaluate(with: self)
    }
    
    

}
