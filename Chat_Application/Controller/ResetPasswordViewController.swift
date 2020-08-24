//
//  ResetPasswordViewController.swift
//  Chat_Application
//
//  Created by Mac on 24/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // ACTIONS PERFORMED BY USER PRESSING SUBMIT BUTTON
    @IBAction func onSubmitBtn(_ sender: UIButton)
    {
        if self.EmailTF.text == "" {
                       let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
                       
                       let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                       alertController.addAction(defaultAction)
                       
                       present(alertController, animated: true, completion: nil)
                   
                   } else {
                       // CREATING USER RESETPASSWORD FIREBASE AUTHENTICATION
                       Auth.auth().sendPasswordReset(withEmail: self.EmailTF.text!, completion: { (error) in
                           
                           var title = ""
                           var message = ""
                           
                           if error != nil {
                               title = "Error!"
                               message = (error?.localizedDescription)!
                           } else {
                               title = "Success!"
                               message = "Password reset link sent your email so please Check your email."
                               self.EmailTF.text = ""
                           }
                           
                           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                           
                           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alertController.addAction(defaultAction)
                           
                           self.present(alertController, animated: true, completion: nil)
                       })
                   }
               }
               

    }
    
    


