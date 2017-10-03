//
//  ViewController.swift
//  multipleViewAppDemo
//
//  Created by Nabeel Ahmad Khan on 14/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func onePresses(_ sender: Any) {
        let destVC: UIViewController = storyboard!.instantiateViewController(withIdentifier: "childVC")
        present(destVC, animated: true, completion: nil)
    }

    @IBAction func twoPressed(_ sender: Any) {
        performSegue(withIdentifier: "gotoChild", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

