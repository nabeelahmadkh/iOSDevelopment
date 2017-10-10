//
//  ViewController.swift
//  BasicGameUIKitDynamics
//
//  Created by Nabeel Ahmad Khan on 09/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var blueBoxView: UIView?
    var redBoxView: UIView?
    var animator: UIDynamicAnimator?
    var currentLocation: CGPoint?
    var attachment: UIAttachmentBehavior?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            currentLocation = theTouch.location(in: self.view)
            let offset = UIOffsetMake(20, 20)
            attachment = UIAttachmentBehavior(item: blueBoxView!,
                                              offsetFromCenter: offset,
                                              attachedToAnchor: currentLocation!)
            animator?.addBehavior(attachment!)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            currentLocation = theTouch.location(in: self.view)
            attachment?.anchorPoint = currentLocation!
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animator?.removeBehavior(attachment!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var frameRect = CGRect(x: 10, y: 10, width: 80, height: 80)
        blueBoxView = UIView(frame: frameRect)
        blueBoxView?.backgroundColor = UIColor.blue
        frameRect = CGRect(x: 150, y: 20, width: 60, height: 60)
        redBoxView = UIView(frame: frameRect)
        redBoxView?.backgroundColor = UIColor.red
        self.view.addSubview(blueBoxView!)
        self.view.addSubview(redBoxView!)
        animator = UIDynamicAnimator(referenceView: self.view)
        let gravity = UIGravityBehavior(items: [blueBoxView!,
                                                redBoxView!])
        let vector = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = vector
        let collision = UICollisionBehavior(items: [blueBoxView!,
                                                    redBoxView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        let behavior = UIDynamicItemBehavior(items: [blueBoxView!])
        behavior.elasticity = 1.2
        let boxAttachment = UIAttachmentBehavior(item: blueBoxView!,
                                                 attachedTo: redBoxView!)
        boxAttachment.frequency = 4.0
        boxAttachment.damping = 0.0
        
        animator?.addBehavior(boxAttachment)
        animator?.addBehavior(behavior)
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

