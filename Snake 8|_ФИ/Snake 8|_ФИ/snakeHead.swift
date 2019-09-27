//
//  snakeHead.swift
//  Snake 8|_ФИ
//
//  Created by Macbook Air on 27/09/2019.
//  Copyright © 2019 Macbook Air. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {

    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
