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
    //var check = false
    var countScore:Int = 0
    var bird:SKSpriteNode?
    var base:SKSpriteNode?
    var gameOverLabel:SKLabelNode?
    var gameOverLabel2:SKLabelNode?
    var startNote:SKLabelNode?
    var scoreLabel:SKLabelNode?
    var bottomPipe1 = SKSpriteNode()
    var topPipe1 = SKSpriteNode()
    var pipeHeight = CGFloat(200)
    var start = true
    var timer = Timer()
    var actualScore:Int = 0
    //var countArray:[String] = []
    var lastScore:[String] = []
    var finalScore:[String] = []
    //var flag:Int = 0
    //var flag2:Int = 0
    //let birdAtlas = SKTextureAtlas(named:"player.atlas")
    //var birdSprites = Array<SKTexture>()
    //var bird = SKSpriteNode()
    var monsterNode:SKSpriteNode?
    let noCollision:UInt32 = 0b1 << 0
    let birdcategory:UInt32 = 0b1 << 1
    let objectcategory:UInt32 = 0b1 << 2
    //var bird1 = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        loadGame()
    }
    
    func loadGame(){
        let f0 = SKTexture.init(imageNamed: "bird1")
        let f1 = SKTexture.init(imageNamed: "bird2")
        let f2 = SKTexture.init(imageNamed: "bird3")
        let f3 = SKTexture.init(imageNamed: "bird4")
        let frames: [SKTexture] = [f0, f1, f2, f3]
        
        // Load the first frame as initialization
        monsterNode = SKSpriteNode(imageNamed: "bird1")
        monsterNode?.position = CGPoint(x: 0, y: 0)
        monsterNode?.xScale = 0.5
        monsterNode?.yScale = 0.5
        monsterNode?.zPosition = 3
        monsterNode?.physicsBody = SKPhysicsBody(rectangleOf: (monsterNode?.size)!)
        monsterNode?.physicsBody?.affectedByGravity = true
        monsterNode?.physicsBody?.categoryBitMask = birdcategory
        monsterNode?.physicsBody?.contactTestBitMask = objectcategory
        self.addChild(monsterNode!)
        let animation = SKAction.animate(with: frames, timePerFrame: 0.4)
        monsterNode?.run(SKAction.repeatForever(animation))
        
        
        self.physicsWorld.contactDelegate = self
        base = self.childNode(withName: "base") as? SKSpriteNode
        base?.physicsBody = SKPhysicsBody(rectangleOf: (base?.size)!)
        base?.physicsBody?.affectedByGravity = false
        base?.physicsBody?.isDynamic = false
        base?.physicsBody?.categoryBitMask = objectcategory
        base?.physicsBody?.contactTestBitMask = birdcategory

        createBackground()
        createPipe()
        
        print("TIMER CALLED")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calcTimer), userInfo: nil, repeats: true)
        
        let defaults = UserDefaults.standard
        if let scores = defaults.stringArray(forKey: "score"){
            lastScore = scores
        }
    }
    
    
    func updateScore(){
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = "Score: \(actualScore)"
        scoreLabel?.position = CGPoint(x: 300, y: 600)
        addChild(scoreLabel!)
        scoreLabel?.zPosition = 4
    }
    
    
    
    @objc func calcTimer(){
        countScore = countScore + 1
        //print("countScore = \(countScore)")
        actualScore = countScore
    }
    
    
    func createPipe(){
        //print(" create pipe called")
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
        //bottomPipe1.physicsBody?.collisionBitMask = noCollision
        
        
        topPipe1.position = CGPoint(x: 300,y: -450);
        topPipe1.size.height = topPipe1.size.height / 2
        topPipe1.size.width = topPipe1.size.width
        topPipe1.name = "topPipe1"
        topPipe1.physicsBody = SKPhysicsBody(rectangleOf: (topPipe1.size))
        topPipe1.physicsBody?.affectedByGravity = false
        topPipe1.physicsBody?.isDynamic = false
        topPipe1.physicsBody?.categoryBitMask = objectcategory
        topPipe1.physicsBody?.contactTestBitMask = birdcategory
        //topPipe1.physicsBody?.collisionBitMask = noCollision
        
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
        //print("create background called")
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
        if start == true{
            // moving top pillar
            //print("move pillars called")
                //print("entered")
                enumerateChildNodes(withName: "bottomPipe1", using: ({
                    (node, error) in
                    let bp = node as! SKSpriteNode
                    //print(" bp postion ",bp.position.x)
                    bp.position = CGPoint(x: bp.position.x - 6, y: bp.position.y)
                    if bp.position.x <= -400 {
                        bp.position = CGPoint(x:bp.position.x + 750, y:bp.position.y)
                    }
                    //bp.removeFromParent()
                }))
            
                // moving bottom pillar
                enumerateChildNodes(withName: "topPipe1", using: ({
                    (node, error) in
                    let bp2 = node as! SKSpriteNode
                    //print(" bp postion ",bp2.position.x)
                    bp2.position = CGPoint(x: bp2.position.x - 6, y: bp2.position.y)
                    if bp2.position.x <= -400 {
                        bp2.position = CGPoint(x:bp2.position.x + 750, y:bp2.position.y)
                    }
                    //bp2.removeFromParent()
                }))
        }
    }
    
    
    
    func moveBackground(){
        if start == true{
            //print("move background called")
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    //print("entered move background")
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                    //bg.removeFromParent()
                }))
            
        }
    }
    
    /*
    func didBegin(_ contact: SKPhysicsContact) {
        print("  DID BEGIN CALLED  ")
    }
    */
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("did begin function called ")
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel2 = SKLabelNode(fontNamed: "Chalkduster")
        
        gameOverLabel?.text = "Score: \(countScore)"
        gameOverLabel2?.text = "Click to Start New Game"
        //gameOverLabel?.numberOfLines = 2
        //gameOverLabel?.preferredMaxLayoutWidth = 500
        gameOverLabel?.fontSize = 50
        gameOverLabel2?.fontSize = 50
        //gameOverLabel?.horizontalAlignmentMode = .right
        gameOverLabel?.position = CGPoint(x: 0, y: 0)
        gameOverLabel2?.position = CGPoint(x: 0, y: -50)
        addChild(gameOverLabel!)
        addChild(gameOverLabel2!)
        monsterNode?.removeFromParent()
        gameOverLabel?.zPosition = 4
        gameOverLabel2?.zPosition = 4
        start = false
        timer.invalidate()
        actualScore = countScore
        print("lastscore \(lastScore)")
        var localflag = 0
        loop: for i in 0..<lastScore.count{
            if i == 5{
                break loop
            }
            print("i \(i)")
            if ((countScore >= Int(lastScore[i])!) && (localflag == 0)){
                finalScore.append(String(countScore))
                finalScore.append(lastScore[i])
                localflag = 1
            }
            else{
                finalScore.append(lastScore[i])
            }
        }
        if localflag == 0{
            finalScore.append(String(countScore))
        }
        
        print("final score is \(finalScore)")
        
        //lastScore.append(String(countScore))
        let defaults = UserDefaults.standard
        defaults.set(finalScore, forKey: "score")
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        jump()
    }

    
    func jump(){
        monsterNode?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
        //let jumpUpAction = SKAction.moveBy(x: 0, y:60, duration:0.5)
        //bird.run(jumpUpAction)
        
        //print("bird jumping ")
    }
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //var flag = 0
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        if start == false{
            start = true
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view?.presentScene(scene)
            }
        }
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
        //print("update called")
        updateScore()
    }
    
   

    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}
