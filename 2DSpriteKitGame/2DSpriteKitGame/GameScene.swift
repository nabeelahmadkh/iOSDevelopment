//
//  GameScene.swift
//  2DSpriteKitGame
//
//  Created by Nabeel Ahmad Khan on 10/10/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var bird:SKSpriteNode?
    var base:SKSpriteNode?
    var gameOverLabel:SKLabelNode?
    
    let birdcategory:UInt32 = 0b1 << 1
    let objectcategory:UInt32 = 0b1 << 2

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        //self.physicsWorld.gravity = CGVector(dx:0, dy:9.8)
        // Loading image from assests and placing it in the gamescene.
        
        //let background:SKSpriteNode = SKSpriteNode(imageNamed: "bg")
        //self.addChild(background)
        //background.zPosition = 1  // Zposition is for the order of the objects, object with greater z number comes on top of the one with less z number
        
        //background.position = CGPoint(x: 10,y: 10) //to place image in a particular position
        // In order to referance the body from sks view you can write this command
        // object = self.childNode(withName: "objectName") as? SKSpriteNode
        
        //bird = self.childNode(withName: "birdsks") as? SKSpriteNode
        
        
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
        createWalls()
        
    }
    func createWalls() -> SKNode  {
        var wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "piller")
        let btmWall = SKSpriteNode(imageNamed: "piller")
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
        btmWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 420)
       
        //topWall.position = CGPoint(x: 0, y: 0)
        //btmWall.position = CGPoint(x: 0, y: 0)
        
        topWall.zPosition = 4
        btmWall.zPosition = 4
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
    
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = CGFloat(M_PI)
        
        self.addChild(topWall)
        self.addChild(btmWall)
        
        wallPair.zPosition = 1
        // 3
        let randomPosition = random(min: -200, max: 200)
        wallPair.position.y = wallPair.position.y +  randomPosition
        
        //wallPair.run(moveAndRemove)
        
        return wallPair
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    
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
    
    func moveBackground(){
        enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            let bg = node as! SKSpriteNode
            bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
            if bg.position.x <= -bg.size.width {
                bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
            }
        }))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel?.text = "Game Over"
        gameOverLabel?.fontSize = 30
        gameOverLabel?.horizontalAlignmentMode = .right
        gameOverLabel?.position = CGPoint(x: 100, y: 0)
        addChild(gameOverLabel!)
        gameOverLabel?.zPosition = 4
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        jump()
    }
    
    func jump(){
        bird?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        
        // move up 20
        //let jumpUpAction = SKAction.moveBy(x: 0, y:500, duration:0.2)
        // move down 20
        //let jumpDownAction = SKAction.moveBy(x: 0, y:-500,duration:0.2)
        // sequence of move yup then down
        //let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
        // make player run sequence
        //bird?.run(jumpSequence)
        //print("Entered Jump")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
        //bird?.physicsBody?.applyForce(CGVector(dx: -30,dy: 0))
        //print("1. entered")
        moveBackground()
    }
}
