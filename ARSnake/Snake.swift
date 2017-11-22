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
    var direction = Direction.Forward
    var config:SnakeConfig!
    
    private var movementStatus = MovementStatus.None
    
    init(with position: SCNVector3, _ config: SnakeConfig) {
        super.init()
        
        self.config = config
        createSnake(with: position)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    enum MovementStatus {
        case None
        case AddingX
        case AddingZ
        case SubtractingX
        case SubtractingZ
    }
    
    func move(){
        // 蛇的方向可由前两个节点决定，两个节点能形成一条线，左转永远是往线的左边走，右转永远往线的右边走
        switch direction{
        case .Forward:
            moveForward()
        case .Left:
            moveLeft()
        case .Right:
            moveRight()
        }
        direction = .Forward
    }
    
    private func moveRight(){
        let firstBody = bodies[0]
        let secondBody = bodies[1]
        let firstX = firstBody.position.x
        let firstY = firstBody.position.y
        let firstZ = firstBody.position.z
        let secondX = secondBody.position.x
        let secondZ = secondBody.position.z
        
        if firstX == secondX{
            let cell:Float = secondZ - firstZ
            position = SCNVector3.init(firstX + cell, firstY, firstZ)
            movePosition(newPosition: position)
        } else{
            let cell:Float = secondX - firstX
            position = SCNVector3.init(firstX, firstY, firstZ - cell)
            movePosition(newPosition: position)
        }
    }
    
    private func moveLeft(){
        let firstBody = bodies[0]
        let secondBody = bodies[1]
        let firstX = firstBody.position.x
        let firstY = firstBody.position.y
        let firstZ = firstBody.position.z
        let secondX = secondBody.position.x
        let secondZ = secondBody.position.z
        
        if firstX == secondX{
            let cell:Float = secondZ - firstZ
            position = SCNVector3.init(firstX - cell, firstY, firstZ)
            movePosition(newPosition: position)
        } else{
            let cell:Float = secondX - firstX
            position = SCNVector3.init(firstX, firstY, firstZ + cell)
            movePosition(newPosition: position)
        }
    }
    
    private func moveForward(){
        let firstBody = bodies[0]
        let secondBody = bodies[1]
        let firstX = firstBody.position.x
        let firstY = firstBody.position.y
        let firstZ = firstBody.position.z
        let secondX = secondBody.position.x
        let secondZ = secondBody.position.z
        
        if firstX == secondX{
            let cell:Float = secondZ - firstZ
            position = SCNVector3.init(firstX, firstY, firstZ - cell)
            movePosition(newPosition: position)
        } else{
            let cell:Float = secondX - firstX
            position = SCNVector3.init(firstX - cell, firstY, firstZ)
            movePosition(newPosition: position)
        }
    }
    
    private func movePosition(newPosition:SCNVector3){
        var position = newPosition
        for body in bodies{
            let currentPosition = body.position
            body.position = position
            position = currentPosition
        }
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
