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
    
    var config:SnakeConfig!
    
    init(with position: SCNVector3, _ config: SnakeConfig) {
        super.init()
        
        createSnake(with: position, config)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createSnake(with position: SCNVector3, _ config: SnakeConfig){
        let cellWidth = CGFloat(config.cellWidth)
        let box = SCNBox(width: cellWidth, height: cellWidth, length: cellWidth, chamferRadius: cellWidth / 10)
        box.firstMaterial?.diffuse.contents = config.colors[1]
        
        let boxNode1 = SCNNode(geometry: box)
        boxNode1.position = position
        addChildNode(boxNode1)
        
        let boxNode2 = SCNNode(geometry: box)
        boxNode2.position = SCNVector3.init(position.x + config.cellWidth, position.y, position.z)
        addChildNode(boxNode2)
        
        let boxNode3 = SCNNode(geometry: box)
        boxNode3.position = SCNVector3.init(position.x + config.cellWidth * 2, position.y, position.z)
        addChildNode(boxNode3)
    }
}
