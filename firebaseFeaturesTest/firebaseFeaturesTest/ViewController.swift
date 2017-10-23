//
//  ViewController.swift
//  firebaseFeaturesTest
//
//  Created by Nabeel Ahmad Khan on 22/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBAction func userSignUp(_ sender: UIButton) {
        let email = username.text
        let password = userpassword.text
        let ref = Database.database().reference().root
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user: User?, error) in
            if error == nil {
                self.labelMessage.text = "You are successfully registered"
                ref.child("users").child((user?.uid)!).child("email").setValue(email)
            }else{
                self.labelMessage.text = "Registration Failed.. Please Try Again"
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FirebaseApp.configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

