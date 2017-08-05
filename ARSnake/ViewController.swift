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
    var snakeEngine:SnakeEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        let line = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
        let matrix = SCNMatrix4Translate(SCNMatrix4MakeTranslation(1 - 0.5, 0, 0 - 0.5), 0.001 / 2, 0.001 / 2, -0.001 / 2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        // use the same material for all geometry elements
        line.firstMaterial = material
        let node = SCNNode(geometry: line)
        node.transform = matrix
        sceneView.scene.rootNode.addChildNode(node)
//        sceneView.scene = scene
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
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
        // We need async execution to get anchor node's position relative to the root
        DispatchQueue.main.async {
//            if let planeAnchor = anchor as? ARPlaneAnchor {
                // For a first detected plane
//                if (self.snakeEngine == nil) {
//                    // get center of the plane
//                    let x = planeAnchor.center.x + node.position.x
//                    let y = planeAnchor.center.y + node.position.y
//                    let z = planeAnchor.center.z + node.position.z
//                    // initialize Tetris with a well placed on this plane
//                    let config = SnakeConfig.standard
//                    let ground = SnakeGround(config)
//                    let scene = SnakeScene(config, self.sceneView.scene, x, y, z)
//                    self.snakeEngine = SnakeEngine(config, ground, scene)
//                }
//            }
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
