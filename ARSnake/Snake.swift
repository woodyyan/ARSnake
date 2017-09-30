//
//  Snake.swift
//  ARSnake
//
//  Created by Songbai Yan on 06/08/2017.
//  Copyright © 2017 略懂工作室. All rights reserved.
//

import Foundation
import ARKit

class Snake : SCNNode {
    var bodies:[SCNNode] = [SCNNode]()
    var config:SnakeConfig!
    
    init(with position: SCNVector3, _ config: SnakeConfig) {
        super.init()
        
        self.config = config
        createSnake(with: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move(to direction:Direction){
        switch direction {
        case .Forward:
            moveForward()
        case .Left:
            moveLeft()
        case .Right:
            moveRight()
        }
    }
    
    private func moveForward(){
        let firstPostion = bodies[0].position
        var position = SCNVector3.init(firstPostion.x + config.cellWidth, firstPostion.y, firstPostion.z)
        for body in bodies{
            let currentPosition = body.position
            body.position = position
            position = currentPosition
        }
    }
    
    private func moveLeft(){
        
    }
    
    private func moveRight(){
        
    }
    
    private func createSnake(with position: SCNVector3){
        let cellWidth = CGFloat(config.cellWidth)
        let box = SCNBox(width: cellWidth, height: cellWidth, length: cellWidth, chamferRadius: cellWidth / 10)
        box.firstMaterial?.diffuse.contents = config.colors[1]
        
        let boxNode1 = SCNNode(geometry: box)
        boxNode1.position = position
        addChildNode(boxNode1)
        bodies.append(boxNode1)
        
        let boxNode2 = SCNNode(geometry: box)
        boxNode2.position = SCNVector3.init(position.x - config.cellWidth, position.y, position.z)
        addChildNode(boxNode2)
        bodies.append(boxNode2)
        
        let boxNode3 = SCNNode(geometry: box)
        boxNode3.position = SCNVector3.init(position.x - config.cellWidth * 2, position.y, position.z)
        addChildNode(boxNode3)
        bodies.append(boxNode3)
    }
}

enum Direction {
    case Forward
    case Left
    case Right
}
