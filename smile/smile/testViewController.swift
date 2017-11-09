//
//  testViewController.swift
//  smile
//
//  Created by Nabeel Ahmad Khan on 03/11/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit
import BSImagePicker
import Photos
import FirebaseAuth
import Firebase
import FirebaseStorage


class testViewController: UIViewController{
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    var imagesToUpload = [UIImage]()
    var selectedAssets:Int = 0
    let user = Auth.auth().currentUser?.uid
    let ref = Database.database().reference().root
    var storageRef = Storage.storage().reference()
    @IBOutlet weak var imgView: UIImageView!
    
    
    // Selecting Multiple Images from Gallery
    @IBAction func addImagesClicked(_ sender: Any) {
        
        // create an instance of Custom class for picking image.
        let vc = BSImagePickerViewController()
        
        //display picture gallery
        self.bs_presentImagePickerController(vc, animated: true,
                                             select: { (asset: PHAsset) -> Void in
                                                
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
            }
            
            self.convertAssetToImages()
            
        }, completion: nil)
        
    }
    
    // Converts PHAssets to Images
    func convertAssetToImages() -> Void {
        
        if SelectedAssets.count != 0{
            
            
            for i in 0..<SelectedAssets.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
                
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    
                })
                
                let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                let newImage = UIImage(data: data!)
                //imagesToUpload[i] = newImage!
                self.imagesToUpload.append(newImage! as UIImage)
                selectedAssets = SelectedAssets.count
                // call Firebase API here for uploading image to the server.
                
                self.PhotoArray.append(newImage! as UIImage)
                
            }
            
            self.imgView.animationImages = self.PhotoArray
            self.imgView.animationDuration = 3.0
            self.imgView.startAnimating()
            
        }
        
        
        print("complete photo array \(self.PhotoArray)")
    }
    
    
    @IBAction func uploadImages(_ sender: Any) {
        for i in 0..<selectedAssets{
            print("in the selected array. \(i)")
            if let imageData:Data = UIImagePNGRepresentation(imagesToUpload[i])!
            {
                let profilePictureStorageRef = self.storageRef.child("userImages/\(user!)/images/img\(i)")
                
                let uploadTask = profilePictureStorageRef.putData(imageData, metadata: nil)
                {metadata, error in
                    if error == nil{
                        let downloadUrl = metadata!.downloadURL()
                        print("the download link is \(downloadUrl)")
                        self.ref.child("users").child((self.user)!).child("images").child("\(i)").setValue(downloadUrl!.absoluteString)
                        print("The file was uploaded successsfully.")
                    }
                    else{
                        print(error?.localizedDescription)
                        
                    }
                }
            }
        }
    }
    
    
    @IBAction func logoutUser(_ sender: UIButton) {
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
    
    override func didReceiveMemoryWarning() {
        //
    }
    
    override func viewDidLoad() {
        let user = Auth.auth().currentUser?.uid
        print("The User SIgned in is \(user))")
    }
    
    
}
