//
//  GameViewController.swift
//  Swiftris
//
//  Created by EvanDeLord on 6/12/17.
//  Copyright © 2017 Bloc. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var swiftris:Swiftris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        
        skView.isMultipleTouchEnabled = false

        //Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        
        scene.scaleMode = .aspectFill
        
        // #13
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.beginGame()
        
        
        // Present the scene.
        skView.presentScene(scene)
        
        // #14
        scene.addPreviewShapeToScene(shape: swiftris.nextShape!){
            self.swiftris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(shape: self.swiftris.nextShape!) {
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape!) {}
            }
        }
        
    }



    override var prefersStatusBarHidden: Bool {
        return true
    }


    // #15
    func didTick() {
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(shape: swiftris.fallingShape!, completion: {})
    }
}
