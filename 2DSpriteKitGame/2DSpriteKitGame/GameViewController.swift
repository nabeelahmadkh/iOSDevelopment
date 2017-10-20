//
//  GameViewController.swift
//  2DSpriteKitGame
//
//  Created by Nabeel Ahmad Khan on 10/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var flag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = mainMenu(fileNamed: "mainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.showsNodeCount = false
                view.showsFPS = false
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    // Load this scene when touches the screen 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if flag == 0{
            flag = 1
            if let view = self.view as! SKView? {
                // Load the SKScene from 'GameScene.sks'
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene with a transition
                    view.showsNodeCount = false
                    view.showsFPS = false
                    view.presentScene(scene, transition:SKTransition.crossFade(withDuration: 1.0))
                }
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
