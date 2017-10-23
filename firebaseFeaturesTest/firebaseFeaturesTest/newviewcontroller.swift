//
//  newviewcontroller.swift
//  firebaseFeaturesTest
//
//  Created by Nabeel Ahmad Khan on 22/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVKit
import AVFoundation

class newviewcontroller: UIViewController{
    
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBAction func playVideo(_ sender: AnyObject) {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/nabeellogintestapp.appspot.com/o/swimming%20pool%20again.mp4?alt=media&token=88ad634b-9b73-4a5b-8287-89b59f5295ed") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        let email = login.text
        let password2 = password.text
       
        
        Auth.auth().signIn(withEmail: email!, password: password2!) { (user, error) in
            // ...
            if error == nil {
                self.textLabel.text = "You are successfully Logged In"
            }else{
                self.textLabel.text = "Log-In Failed.. Please Try Again"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //FirebaseApp.configure()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
