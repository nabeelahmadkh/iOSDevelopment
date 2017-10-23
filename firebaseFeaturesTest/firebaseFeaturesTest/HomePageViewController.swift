//
//  HomePageViewController.swift
//  firebaseFeaturesTest
//
//  Created by Nabeel Ahmad Khan on 23/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase



class HomePageViewController: UIViewController {
    
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var Label: UILabel!
    var userkey:String = "null"
    
    @IBAction func login(_ sender: UIButton) {
        
        let ref = Database.database().reference().root
        let sex2 = sex.text
        let city2 = city.text
        
    ref.child("users").child(userkey).child("sex").setValue(sex2)
    ref.child("users").child(userkey).child("city").setValue(city2)
        
        let alert = UIAlertController(title: "Congratz", message: "you have added sex and city", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        userkey = (Auth.auth().currentUser?.uid)!
        let useremail = Auth.auth().currentUser?.email
        Label.text = "Signed In User \(useremail ?? "null")"
    }
    
    override func didReceiveMemoryWarning() {
        //
    }
    
}
