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
    var detailsViewController: DetailsViewController?
    var nodesInPlay = [String]()
    
    @IBOutlet var sceneView: ARSCNView!
    
    var detectedDataAnchor: ARAnchor?
    var processing = false
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupScene()
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
    
    @IBAction func resetPressed(_ sender: Any) {
        resetConfiguration()
    }
    
    func setupScene() {

        // Set the view's delegate
        sceneView.delegate = self
        
        // Set the session's delegate
        sceneView.session.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Create a directional light node with shadow
        let directionalNode = SCNNode()
        directionalNode.light = SCNLight()
        directionalNode.light?.type = SCNLight.LightType.directional
        directionalNode.light?.color = UIColor.white
        directionalNode.light?.castsShadow = true
        directionalNode.light?.automaticallyAdjustsShadowProjection = true
        directionalNode.light?.shadowSampleCount = 64
        directionalNode.light?.shadowRadius = 16
        directionalNode.light?.shadowMode = .deferred
        directionalNode.light?.shadowMapSize = CGSize(width: 2048, height: 2048)
        directionalNode.light?.shadowColor = UIColor.black.withAlphaComponent(0.75)
        
        sceneView.pointOfView?.addChildNode(directionalNode)

    }
    // MARK: - ARSessionDelegate
    
    public func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        let refImage = imageAnchor.referenceImage
        let referenceImageName = refImage.name ?? "unknown"
    
        // Lets get our prefix and store it so we dont end up with multiples of the same item overlapping eachother as it will detect small, med, large and try to put 3 objects in same place.
        let strArr = referenceImageName.components(separatedBy: "_")
        
        print("found: \(strArr[0])")
        
        if strArr.count > 0 {
            
            let name = strArr[0]
            
            if nodesInPlay.contains(name) {
                return nil
            }
            
            // Using a cube for now
            let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
            let material = SCNMaterial()
            
            // Image name will be the prefix of the image group
            material.diffuse.contents = UIImage(named: name)
            box.materials = [material]
            let node = SCNNode(geometry: box)
            
            node.name = name
            
            nodesInPlay.append(name)
            return node
        
        }

        return nil
    }
    
    // Called whenever we want to reset, for example, maybe when the user dismisses the details or
    // when the focus is lost and the 3d objects dissappear.
    func resetConfiguration() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        
        // Clear out our node id's
        nodesInPlay.removeAll()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.isLightEstimationEnabled = true
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        
        detailsViewController?.viewModel.userSwipedDown()
    }
    
    //  #MARK: Touches / Gestures
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            if(touch.view == sceneView) {
                
                let viewTouchLocation:CGPoint = touch.location(in: sceneView)
                guard let result = sceneView.hitTest(viewTouchLocation, options: nil).first else {
                    return
                }
                
                if let name = result.node.name {
                    loadDetailsOverlayWith(interactionId: name)
                }
            }
        }
    }
    
    
    // MARK: Video overlay methods
    func setupExperienceFeatures() {
        
        // Used to present a 2d experience fullscreen when a corresponding trigger is detected
        viewModel.present2dOverlay = { [weak self] (interactrionId: String) in
            
            guard let `self` = self else { return }
            
            // Load up the video
            DispatchQueue.main.async {
                self.loadDetailsOverlayWith(interactionId: interactrionId)
            }
        }
        
        // Setup our 2d overlay where the details will be displayed
        viewModel.setupOverlayViewController = { [weak self] (controller: DetailsViewController) in
            
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                self.detailsViewController = controller
                self.detailsViewController?.viewModel.backPressed()
                self.view.addSubview(controller.view)
                
            }
        }
        
        viewModel.setupDetailsView()
        
    }
        
    func loadDetailsOverlayWith(interactionId: String) {
        
        // TODO: Refactor to real MVVM later
        if let detailsViewController = detailsViewController {
            detailsViewController.viewModel.setupWithInteractionId(interactionId: interactionId)
        }
    }
}
