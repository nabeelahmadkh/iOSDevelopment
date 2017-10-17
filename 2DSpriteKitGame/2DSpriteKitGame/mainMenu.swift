//
//  mainMenu.swift
//  2DSpriteKitGame
//
//  Created by Nabeel Ahmad Khan on 10/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import SpriteKit

class mainMenu: SKScene {
    
    //print("Entered FUNCTION:- CLASS:mainMenu")
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "bg")
        background.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        background.position = CGPoint(x: 0, y:0)
        //background.name = "background"
        //background.size = (self.view?.bounds.size)!
        background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        
        self.addChild(background)
        background.zPosition = 0
        
        var welcomeText = SKLabelNode()
        welcomeText = SKLabelNode(fontNamed: "Chalkduster")
        welcomeText.text = "Tap to start Flappy bird"
        welcomeText.numberOfLines = 2
        welcomeText.preferredMaxLayoutWidth = 500
        welcomeText.fontSize = 70
        welcomeText.position = CGPoint(x: 0, y: 0)
        welcomeText.zPosition = 2
        self.addChild(welcomeText)
    }
}
