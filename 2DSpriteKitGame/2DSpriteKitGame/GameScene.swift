//
//  GameScene.swift
//  2DSpriteKitGame
//
//  Created by Nabeel Ahmad Khan on 10/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var bird:SKSpriteNode?
    var base:SKSpriteNode?
    var gameOverLabel:SKLabelNode?
    var scoreLabel:SKLabelNode?
    var bottomPipe1 = SKSpriteNode()
    var topPipe1 = SKSpriteNode()
    var pipeHeight = CGFloat(200)
    var start = false
    

    
    let birdcategory:UInt32 = 0b1 << 1
    let objectcategory:UInt32 = 0b1 << 2

    override func didMove(to view: SKView) {
     
        self.physicsWorld.contactDelegate = self
        
        base = self.childNode(withName: "base") as? SKSpriteNode
        base?.physicsBody = SKPhysicsBody(rectangleOf: (base?.size)!)
        base?.physicsBody?.affectedByGravity = false
        base?.physicsBody?.isDynamic = false
        base?.physicsBody?.categoryBitMask = objectcategory
        
        bird = SKSpriteNode(imageNamed: "bird1")
        bird?.xScale = 0.5
        bird?.yScale = 0.5
        self.addChild(bird!)
        bird?.zPosition = 2
        bird?.physicsBody = SKPhysicsBody(rectangleOf: (bird?.size)!)
        bird?.physicsBody?.affectedByGravity = true
        bird?.physicsBody?.categoryBitMask = birdcategory
        bird?.physicsBody?.contactTestBitMask = objectcategory
    
        //print("Entered FUNCTION:didMove CLASS:GameScene")
        createBackground()
        createPipe()
        
    }
    func createPipe(){
        bottomPipe1 = SKSpriteNode(imageNamed: "piller")
        topPipe1 = SKSpriteNode(imageNamed: "piller")
        
        bottomPipe1.position = CGPoint(x: 100,y: 450);
        bottomPipe1.size.height = bottomPipe1.size.height / 2
        bottomPipe1.size.width = bottomPipe1.size.width
        bottomPipe1.zRotation = CGFloat(Double.pi)
        bottomPipe1.name = "bottomPipe1"
        bottomPipe1.physicsBody = SKPhysicsBody(rectangleOf: (bottomPipe1.size))
        bottomPipe1.physicsBody?.affectedByGravity = false
        bottomPipe1.physicsBody?.isDynamic = false
        bottomPipe1.physicsBody?.categoryBitMask = objectcategory
        bottomPipe1.physicsBody?.contactTestBitMask = birdcategory
        //bottomPipe1.physicsBody?.categoryBitMask = birdcategory
        
        
        topPipe1.position = CGPoint(x: 300,y: -450);
        topPipe1.size.height = topPipe1.size.height / 2
        topPipe1.size.width = topPipe1.size.width
        topPipe1.name = "topPipe1"
        topPipe1.physicsBody = SKPhysicsBody(rectangleOf: (bottomPipe1.size))
        topPipe1.physicsBody?.affectedByGravity = false
        topPipe1.physicsBody?.isDynamic = false
        topPipe1.physicsBody?.categoryBitMask = objectcategory
        topPipe1.physicsBody?.contactTestBitMask = birdcategory
        //topPipe1.physicsBody?.categoryBitMask = birdcategory
        
        topPipe1.zPosition = 2
        bottomPipe1.zPosition = 2
        
        self.addChild(bottomPipe1)
        self.addChild(topPipe1)
    }
    
    /*
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    */
    
    func createBackground(){
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "bg")
            background.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            //background.size = (self.view?.bounds.size)!
            background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            
            self.addChild(background)
            background.zPosition = 1
        }
    }
    
    func movePillars(){
        // moving top pillar
        if start == true{
            //print("entered")
            enumerateChildNodes(withName: "bottomPipe1", using: ({
                (node, error) in
                let bp = node as! SKSpriteNode
                //print(" bp postion ",bp.position.x)
                bp.position = CGPoint(x: bp.position.x - 2, y: bp.position.y)
                if bp.position.x <= -400 {
                    bp.position = CGPoint(x:bp.position.x + 750, y:bp.position.y)
                }
            }))
            
            // moving bottom pillar
            enumerateChildNodes(withName: "topPipe1", using: ({
                (node, error) in
                let bp2 = node as! SKSpriteNode
                //print(" bp postion ",bp2.position.x)
                bp2.position = CGPoint(x: bp2.position.x - 2, y: bp2.position.y)
                if bp2.position.x <= -400 {
                    bp2.position = CGPoint(x:bp2.position.x + 750, y:bp2.position.y)
                }
            }))
        }
    }
    
    
    func moveBackground(){
        if start == true{
            enumerateChildNodes(withName: "background", using: ({
                (node, error) in
                let bg = node as! SKSpriteNode
                //print("entered move background")
                bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                }
            }))
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("contact")
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel?.text = "Game Over"
        gameOverLabel?.fontSize = 30
        gameOverLabel?.horizontalAlignmentMode = .right
        gameOverLabel?.position = CGPoint(x: 100, y: 0)
        addChild(gameOverLabel!)
        gameOverLabel?.zPosition = 4
        start = false
    }
    
    func touchDown(atPoint pos : CGPoint) {
        jump()
    }

    func jump(){
        bird?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        start = true
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        moveBackground()
        movePillars()
        
    }
    
   

    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}
