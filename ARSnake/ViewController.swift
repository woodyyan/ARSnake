//
//  ViewController.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/2.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
//    @IBOutlet weak var messagePanel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 存放所有 3D 几何体的容器
        let scene = SCNScene()
        
        sceneView.delegate = self
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
    var isAdded = false
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            if !isAdded{
//                let plane = Plane(withAnchor: planeAnchor)
//                node.addChildNode(plane)
                
                let ground = Ground(with: planeAnchor, SnakeConfig.standard)
                node.addChildNode(ground)
                
                let food = Food(with: ground.getRandomPosition(), SnakeConfig.standard)
                node.addChildNode(food)
                
//                let cellWidth = CGFloat(SnakeConfig.standard.cellWidth)
//                let box = SCNBox(width: cellWidth, height: cellWidth, length: cellWidth, chamferRadius: cellWidth / 10)
//                box.firstMaterial?.diffuse.contents = SnakeConfig.standard.colors[1]
//                let boxNode = SCNNode(geometry: box)
//                boxNode.position = ground.getRandomPosition()
//                node.addChildNode(boxNode)
                let snake = Snake(with: ground.getRandomPosition(), SnakeConfig.standard)
                node.addChildNode(snake)
                
                isAdded = true
            }
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            print("不可用")
        case .limited:
            print("受限")
        case .normal:
            print("正常")
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
