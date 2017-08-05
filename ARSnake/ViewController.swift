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
    
    var snakeEngine:SnakeEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        
        sceneView.delegate = self
        
        // 存放所有 3D 几何体的容器
        let scene = SCNScene()
        
        // 想要绘制的 3D 立方体
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        
        // 把 box 放在摄像头正前方
        boxNode.position = SCNVector3Make(0, 0, -0.5)
        
        // rootNode 是一个特殊的 node，它是所有 node 的起始点
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
//        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
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
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("BBBBBBBBBBBBBBBB")
        if let anchor = anchor as? ARPlaneAnchor {
            print("CCCCCCCCCCCCCCC")
            let plane = Plane(withAnchor: anchor)
            node.addChildNode(plane)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 查看此平面当前是否正在渲染
//        guard let plane = planes[anchor.identifier] else {
//            return
//        }
//
//        plane.update(anchor: anchor as! ARPlaneAnchor)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            print("AAAAAAAAAA: 不可用")
        case .limited:
            print("AAAAAAAAAAAA: 受限")
        case .normal:
            print("AAAAAAAAAA: 正常")
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
