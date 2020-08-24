//  ViewController.swift
//  Chat_Application
//  Created by Mac on 19/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    // CREATING OUTLET
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = Constants.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
        // Do any additional setup after loading the view.
    }


}

