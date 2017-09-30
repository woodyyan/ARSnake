//
//  ARSnake
//
//  Created by Songbai Yan on 06/08/2017.
//  Copyright © 2017 略懂工作室. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Food : SCNNode{
    init(with position: SCNVector3, _ config: SnakeConfig) {
        super.init()
        
        let cellWidth = CGFloat(config.cellWidth)
        let box = SCNBox(width: cellWidth, height: cellWidth, length: cellWidth, chamferRadius: cellWidth / 10)
        box.firstMaterial?.diffuse.contents = config.colors[1]
        let boxNode = SCNNode(geometry: box)
        boxNode.position = position
        addChildNode(boxNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
