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
class SnakeGround : SCNNode {
    
    let cellWidth:Float = 0.05
    let lingWidth:Float = 0.001
    let groundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    
    init(with anchor: ARPlaneAnchor, _ config: SnakeConfig) {
        super.init()
        
        let groundNode = createGround(width: config.width, length: config.length, x: anchor.center.x, y: anchor.center.y, z: anchor.center.z)
        self.addChildNode(groundNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createGround(width: Int, length: Int, x: Float, y: Float, z: Float) -> SCNNode{
        let fixedX = x - cellWidth*5
        let fixedZ = z - cellWidth*5
        //创建10*10的地面方格
        let node = SCNNode()
        for i in 0...width {
            for j in 0...width{
                addLine(to: node, width: cellWidth, length: lingWidth, x: fixedX + Float(i)*cellWidth, y: y, z: fixedZ + Float(j)*cellWidth)
            }
        }
        
        for j in 0...length + 1{
            for i in 0...length - 1{
                addLine(to: node, width: lingWidth, length: cellWidth, x: fixedX - cellWidth/2 + Float(j)*cellWidth, y: y, z: fixedZ + cellWidth/2 + Float(i)*cellWidth)
            }
        }
        
        return node
    }
    
    private func addLine(to node: SCNNode, width: Float, length: Float, x: Float, y: Float, z: Float){
        // 创建线，就是每个方格的一条边
        let material = SCNMaterial()
        material.diffuse.contents = groundColor
        
        let boxGeometry = SCNBox(width: CGFloat(width), height: CGFloat(lingWidth), length: CGFloat(length), chamferRadius: 0.0)
        boxGeometry.firstMaterial = material
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(x, y, z)
        node.addChildNode(boxNode)
    }
}

