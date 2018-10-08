//
//  ARExperienceViewController.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Vision

class ARExperienceViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, MVVMViewControllerProtocol {
    
    var viewModel: ARExperienceViewModel!
    
    @IBOutlet var sceneView: ARSCNView!
    
    var detectedDataAnchor: ARAnchor?
    var processing = false
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Set the session's delegate
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSessionDelegate
    
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        print("works")
        
        // If this is our anchor, create a node
        //if self.detectedDataAnchor?.identifier == anchor.identifier {
        
        // Create a 3D Cup to display
        guard let virtualObjectScene = SCNScene(named: "cup.scn", inDirectory: "Models.scnassets/cup") else {
            return nil
        }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            child.movabilityHint = .movable
            wrapperNode.addChildNode(child)
        }
        
        // Set its position based off the anchor
        wrapperNode.transform = SCNMatrix4(anchor.transform)
        
        return wrapperNode
        //}
        
        //return nil
    }
    
    // Called whenever we want to reset, for example, maybe when the user dismisses the details or
    // when the focus is lost and the 3d objects dissappear.
    func resetConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
    }
}
