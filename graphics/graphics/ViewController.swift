//
//  ViewController.swift
//  graphics
//
//  Created by Nabeel Ahmad Khan on 12/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

   

    @IBOutlet weak var theFaceView: faceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func faceScale(_ sender: UIPinchGestureRecognizer) {
        theFaceView.setScaleValue(sender.scale)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func smileSlider(_ sender: UISlider) {
        theFaceView.assignMouthCurvature(Double(sender.value))
    }
}
