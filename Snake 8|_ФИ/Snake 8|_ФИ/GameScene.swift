//
//  GameScene.swift
//  Snake 8|_ФИ
//
//  Created by Macbook Air on 27/09/2019.
//  Copyright © 2019 Macbook Air. All rights reserved.
//

import SpriteKit
import GameplayKit


struct CollisionCategories {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}
//00000001 << 00000010 << 00000100 << 00001000
class GameScene: SKScene {
    
    var snake: Snake?
    var xCenter: CGFloat = 0.0
    var yCenter: CGFloat = 0.0
    
    override func didMove(to view: SKView) {
        
        //screen
        backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = true
        
        //buttons
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockwiseButton.fillColor = UIColor.gray
        clockwiseButton.strokeColor = UIColor.gray
        clockwiseButton.name = "clockwiseButton"
        self.addChild(clockwiseButton)
        
        createApple()
        
        
        // MARK: Snake
        //Snake
        
        xCenter = view.scene!.frame.midX
        yCenter = view.scene!.frame.midY
        
        snake = Snake(atPoint: CGPoint(x: xCenter, y: yCenter))
        print("{x_1:\(xCenter); y_1:\(yCenter)}")
        
        self.addChild(snake!)
        
    }
    
    
    
    
    func createApple(){
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                return
            }
            
            touchedNode.fillColor = .green
            
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton"{
                snake!.moveClockwise()
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode, touchedNode.name == "counterClockwiseButton" || touchedNode.name == "clockwiseButton" else {
                return
            }
            
            touchedNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact){
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            self.removeAllChildren()
            didMove(to: view!)
            
          
            snake?.removeAllChildren()
                       snake?.removeAllBodyPart()
                       snake?.removeFromParent()
                       snake = nil
                       
             snake = Snake(atPoint: CGPoint(x: xCenter, y: yCenter))
                      addChild(snake!)
                       
            
        default:
            break
        }
    }
}
