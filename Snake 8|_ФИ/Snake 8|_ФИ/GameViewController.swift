//
//  GameViewController.swift
//  Snake 8|_ФИ
//
//  Created by Macbook Air on 27/09/2019.
//  Copyright © 2019 Macbook Air. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: self.view.bounds.size)
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        
    }






}
