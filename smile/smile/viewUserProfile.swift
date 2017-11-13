//
//  viewUserProfile.swift
//  smile
//
//  Created by Nabeel Ahmad Khan on 24/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class viewUserData: UIViewController{
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var hobbies: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    let ref = Database.database().reference().root
    
    
    @IBAction func logOutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("The user successfully signed out of the app")
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginScreen")
            
            self.present(loginViewController, animated: true, completion: nil)
            
            
            //performSegue(withIdentifier: "backToLogin", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        let useremail = Auth.auth().currentUser?.email
        print("The User SIgned in is \(String(describing: useremail))")
        username.text = useremail
        let uid = Auth.auth().currentUser?.uid
        print("The user signed in as UID \(uid)")
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.username.text = value?["email"] as? String ?? ""
            self.dateOfBirth.text = value?["dob"] as? String ?? ""
            self.mobile.text = value?["mobile"] as? String ?? ""
            self.sex.text = value?["sex"] as? String ?? ""
            let imageurl = value?["profilePicture"] as? String ?? ""
            let hobby:[String] = value?["hobby"] as? [String] ?? [""]
            //print("HOBBY IS \(hobby)")
            let length = hobby.count
            var hobbyOutput:String = ""
            var i = 0
            while(i < length){
                hobbyOutput.append(hobby[i])
                hobbyOutput.append(", ")
                i += 1
            }
            //print("HPBBY OUTPUT IS \(hobbyOutput)")
            self.hobbies.text = hobbyOutput
            
            
            // Printing the URL of the stored images in the console
            if value?["images"] != nil{
                let images:[String] = (value?["images"] as? [String])!
                let numberofimages = images.count
                i = 0
                while(i<numberofimages){
                    print("URR for images are \(images[i])")
                    i += 1
                }
            }
            
            // Setting the Profile Picture
            let url = URL(string: imageurl)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                let image = UIImage(data: data!)
                self.profilePicture.image = image
            }
            
            print("value is \(value)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        //
    }
    
}
