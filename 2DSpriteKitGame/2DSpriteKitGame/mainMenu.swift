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
        
        var lastScore:[String] = []
        let defaults = UserDefaults.standard
        if let scores = defaults.stringArray(forKey: "score"){
            lastScore = scores
        }
        print("lastscores \(lastScore)")
        var welcomeText = SKLabelNode()
        welcomeText = SKLabelNode(fontNamed: "Chalkduster")
        welcomeText.text = "TAP to START"
        //welcomeText.numberOfLines = 2
        //welcomeText.preferredMaxLayoutWidth = 500
        welcomeText.fontSize = 70
        welcomeText.position = CGPoint(x: 0, y: 0)
        welcomeText.zPosition = 2
        self.addChild(welcomeText)
        
        var scores1 = SKLabelNode()
        scores1 = SKLabelNode(fontNamed: "Chalkduster")
        if lastScore.count == 0{
            scores1.text = "Top Scores: null"
            
        }
        if lastScore.count == 1{
            scores1.text = "Top Scores: \(lastScore[0])"
        }
        if lastScore.count == 2{
            scores1.text = "Top Scores: \(lastScore[0]) \(lastScore[1])"
        }
        if lastScore.count == 3{
            scores1.text = "Top Scores: \(lastScore[0]) \(lastScore[1]) \(lastScore[2])"
        }
        if lastScore.count == 4{
            scores1.text = "Top Scores: \(lastScore[0]) \(lastScore[1]) \(lastScore[2]) \(lastScore[3])"
        }
        if lastScore.count >= 5{
            scores1.text = "Top Scores: \(lastScore[0]) \(lastScore[1]) \(lastScore[2]) \(lastScore[3]) \(lastScore[4])"
        }
        scores1.position = CGPoint(x: 0, y:-100)
        scores1.fontSize = 40
        scores1.zPosition = 3
        self.addChild(scores1)
    }
}
