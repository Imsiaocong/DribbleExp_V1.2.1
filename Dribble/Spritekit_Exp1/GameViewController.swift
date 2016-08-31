//
//  GameViewController.swift
//  Spritekit_Exp1
//
//  Created by 王笛 on 16/8/25.
//  Copyright (c) 2016年 王笛iOS.Inc. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var quit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quit.addTarget(self, action: #selector(GameViewController.quitGame), forControlEvents: .TouchUpInside)
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func quitGame() {
        performSegueWithIdentifier("back", sender: nil)
    }
}
