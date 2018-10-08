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
    
//    enum DetailsPresentation {
//        case offScreen
//        case fullScreen
//    }
    
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
        
        
        // TODO: Remove, this is here to test the details view
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: { _ in
            self.loadDetailsOverlayWith(interactionId: "")
        })
    }
        
    func loadDetailsOverlayWith(interactionId: String) {
        
        // TODO: Refactor to real MVVM later
        if let detailsViewController = detailsViewController {
            detailsViewController.viewModel.setupWithInteractionId(interactionId: interactionId)
        }
    }
    
//    func animateDetails(with: DetailsPresentation, animated: Bool) {
//
//        guard let detailsViewController = detailsViewController else {
//            return
//        }
//
//        let duration = animated ? 0.6 : 0.0
//
//        // Basic animations, should ease in etc in next pass
//        switch with {
//            case .offScreen:
//                UIView.animate(withDuration: duration , animations: {
//                    detailsViewController.view.frame = CGRect(x: 0, y: -detailsViewController.view.frame.size.height, width: detailsViewController.view.frame.size.width, height: detailsViewController.view.frame.size.height)
//
//                })
//
//
//            case .fullScreen:
//                UIView.animate(withDuration: duration, animations: {
//                    detailsViewController.view.frame = CGRect(x: 0, y:0, width: detailsViewController.view.frame.size.width, height: detailsViewController.view.frame.size.height)
//
//                })
//        }
//    }
}
