//
//  addNewItemViewController.swift
//  multiViewApp
//
//  Created by Nabeel Ahmad Khan on 26/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit

class addNewItemViewController: UIViewController{
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var sex: UITextField!
    
    @IBOutlet weak var labelBelowSubmit: UILabel!
    
    @IBAction func formSubmit(_ sender: UIButton) {
        
        // create some check for the objects here.
        // i.e. for checking the object is blank or the email is correct or not
        
        let user = userData(name: name.text!, email: email.text!, sex: sex.text!, calculator: 0.0, game: 0, date: "Not Activated Yet")
        
        
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        
        let defaults = UserDefaults.standard
        
        let useremail = email.text!
        print("the value of email is \(useremail)")
        
        defaults.set(data, forKey: useremail)
        
        labelBelowSubmit.text = "Data Added Succesfully"
        
        name.text = ""
        email.text = ""
        sex.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


