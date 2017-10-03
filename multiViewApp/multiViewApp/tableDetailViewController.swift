//
//  tableDetailViewController.swift
//  multiViewApp
//
//  Created by Nabeel Ahmad Khan on 26/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit

var selectedEmail:String = ""
var displayProperties:[String] = []
var flaggedEmail = ""
var flag2:Bool = false


class tableDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //@IBOutlet weak var customTableCell: UITableViewCell!
    @IBOutlet weak var userDetailTable: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var calcLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @objc func switchChanged(_ sender : UISwitch!) {
        let defaults = UserDefaults.standard
        defaults.set(selectedEmail, forKey: "email")
        
        updateDate()
    }
    
    func updateDate(){
        let defaults = UserDefaults.standard
        let activeEmail = defaults.string(forKey: "email")
        print(" active mail is ",activeEmail)
        let userinfo = defaults.data(forKey: activeEmail!)
        let items = NSKeyedUnarchiver.unarchiveObject(with: userinfo as! Data)
        let userdata = items as! userData
        print("the data fetched is \(userdata.name)")
       
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
       
        userdata.date = dateString
        defaults.removeObject(forKey: userdata.email)
        let data = NSKeyedArchiver.archivedData(withRootObject: userdata)
        defaults.set(data, forKey: userdata.email)
        
        //defaults.set(selectedEmail, forKey: "email")
    }
    @IBAction func deleteUser(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: myIndex)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(displayProperties.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //print(" display properties \(displayProperties)")
        let details = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "details")
        details.textLabel?.text = displayProperties[indexPath.row]
        
        print(" FLAG2 \(flag2)")
        if(displayProperties[indexPath.row] ==  "Activate User"){
            print(" entered second IF ")
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(flag2, animated: true)
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            details.accessoryView = switchView
        }
        
    
        
        return(details)
    }
    
    override func viewDidLoad() {
        
        flag2 = false
        super.viewDidLoad()
        //label.text = String("\(myIndex) email id ")
        //print("\(myIndex) button pressed")
        displayProperties = []
        
        let defaults = UserDefaults.standard
        if let objectName = defaults.data(forKey: myIndex){
            let items = NSKeyedUnarchiver.unarchiveObject(with: objectName as! Data)
            let userinfo = items as! userData
            //print("the values stored are \(userinfo.name) \(userinfo.email)")
            
            /*
            nameLabel.text = userinfo.name
            emailLabel.text = userinfo.email
            sexLabel.text = userinfo.sex
            calcLabel.text = String(userinfo.calculator)
            gameScoreLabel.text = String(userinfo.game)
             */
            selectedEmail = userinfo.email
 
            
            displayProperties.append("Name: "+userinfo.name)
            displayProperties.append("Email: "+userinfo.email)
            displayProperties.append("Sex: "+userinfo.sex)
            displayProperties.append("Last RPNs Output: "+String(userinfo.calculator))
            displayProperties.append("Highest Game Score: "+String(userinfo.game))
            displayProperties.append("Last Activated: "+userinfo.date)
            displayProperties.append("Activate User")
            
            let email = defaults.string(forKey: "email")
            if(email == userinfo.email)
            {
                print(" entered if case ")
                flag2 = true
                flaggedEmail = userinfo.email
            }
        }
        userDetailTable.reloadData()
        //customTableCell.reloadInputViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }}
