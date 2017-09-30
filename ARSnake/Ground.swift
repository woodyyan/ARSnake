//
//  SnakeGround.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/3.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//
import UIKit
import SceneKit
import ARKit

/** Snake ground model */
class Ground : SCNNode {
    
    var config:SnakeConfig!
    
    //每个方格的中心点
    var positions:[SCNVector3] = [SCNVector3]()
    
    init(with anchor: ARPlaneAnchor, _ config: SnakeConfig) {
        super.init()
        
        self.config = config
        
        let groundNode = createGround(width: config.width, length: config.length, x: anchor.center.x, y: anchor.center.y, z: anchor.center.z)
        self.addChildNode(groundNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getRandomPosition() -> SCNVector3{
        let index = Int(arc4random_uniform(UInt32(positions.count)))
        return positions[index]
    }
    
    private func createGround(width: Int, length: Int, x: Float, y: Float, z: Float) -> SCNNode{
        let fixedX = x - config.cellWidth*5
        let fixedZ = z - config.cellWidth*5
        //创建10*10的地面方格
        let node = SCNNode()
        for i in 0...width {
            for j in 0...width{
                let currentX = fixedX + Float(i)*config.cellWidth
                let currentZ = fixedZ + Float(j)*config.cellWidth
                addLine(to: node, width: config.cellWidth, length: config.lingWidth, x: currentX, y: y, z: currentZ)
                positions.append(SCNVector3.init(currentX, y + config.cellWidth/2, currentZ + config.cellWidth/2))
            }
        }
        
        for j in 0...length + 1{
            for i in 0...length - 1{
                addLine(to: node, width: config.lingWidth, length: config.cellWidth, x: fixedX - config.cellWidth/2 + Float(j)*config.cellWidth, y: y, z: fixedZ + config.cellWidth/2 + Float(i)*config.cellWidth)
            }
        }
        
        return node
    }
    
    private func addLine(to node: SCNNode, width: Float, length: Float, x: Float, y: Float, z: Float){
        // 创建线，就是每个方格的一条边
        let material = SCNMaterial()
        material.diffuse.contents = config.groundColor
        
        let boxGeometry = SCNBox(width: CGFloat(width), height: CGFloat(config.lingWidth), length: CGFloat(length), chamferRadius: 0.0)
        boxGeometry.firstMaterial = material
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(x, y, z)
        node.addChildNode(boxNode)
    }
}

