//
//  ViewController.swift
//  multiViewApp
//
//  Created by Nabeel Ahmad Khan on 24/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

var myIndex = ""
var tableItems:[String] = []
var tableName:[String] = []
var tableEmail:[String] = []
var imageEmail:[String] = []

class ViewControllerApp: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableOutput: UITableView!
    
    var list = ["item1", "item2", "item2", "item3"]
    var name:[String] = ["nabeel", "hamza"]
    var email:[String] = []
    var sex:[String] = []
    var calc:[String] = []
    var game:[String] = []
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(tableName.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = tableName[indexPath.row]
        cell.detailTextLabel?.text = tableEmail[indexPath.row]
        
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "email")
        imageEmail = []
        
        print("The value of email reloaded is \(email)")
        
        for(key, value) in defaults.dictionaryRepresentation(){
            if((value as? Data) != nil){
                
                let items = NSKeyedUnarchiver.unarchiveObject(with: value as! Data)
                
                let userinfo2 = items as! userData
                
                if(userinfo2 != nil){
                    tableItems.append(key)
                    tableName.append(userinfo2.name)
                    tableEmail.append(userinfo2.email)
                }
                //print(" Inside IF ")
                if (userinfo2.email == email){
                    imageEmail.append("checkImage")
                    //print(" Inside IF 2")
                }
                else{
                    imageEmail.append("dot32")
                }
            }
        }
        
        let image = imageEmail[indexPath.row]
        cell.imageView?.image = UIImage(named: image)
        print(" function called ")
        print(" index \(indexPath.row)")
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        
        myIndex = tableItems[indexPath.row]
        performSegue(withIdentifier: "tableSegue", sender: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let defaults = UserDefaults.standard
        tableItems = []
        tableName = []
        tableEmail = []
        for(key, value) in defaults.dictionaryRepresentation(){
            if((value as? Data) != nil){
                
                //print("before unarchiving key is \(key) value is \(value)")
                let items = NSKeyedUnarchiver.unarchiveObject(with: value as! Data)
                
                let userinfo2 = items as! userData
                
                if(userinfo2 != nil){
                    tableItems.append(key)
                    tableName.append(userinfo2.name)
                    tableEmail.append(userinfo2.email)
                    //print("value of name after Unarchiving is \(userinfo2.name) and the vlaue is \(userinfo2.email)")
                }
            }
        
        }
        
        let activeEmail = defaults.string(forKey: "email")
        //activeUser.text = "Active Player is \(activeEmail)"
        tableOutput.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        tableItems = []
        tableName = []
        tableEmail = []
        for(key, value) in defaults.dictionaryRepresentation(){
            if((value as? Data) != nil){
                
                //print("before unarchiving key is \(key) value is \(value)")
                let items = NSKeyedUnarchiver.unarchiveObject(with: value as! Data)
                
                let userinfo2 = items as! userData
                
                if(userinfo2 != nil){
                    tableItems.append(key)
                    tableName.append(userinfo2.name)
                    tableEmail.append(userinfo2.email)
                    //print("value of name after Unarchiving is \(userinfo2.name) and the vlaue is \(userinfo2.email)")
                }
            }
        tableOutput.reloadData()
        }
        
        let activeEmail = defaults.string(forKey: "email")
        //activeUser.text = "Active Player is \(activeEmail)"
        
        print("Array is \(tableItems)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
