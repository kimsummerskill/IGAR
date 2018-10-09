//
//  NodeObject.swift
//  InHouse-AR
//
//  Created by Kim Summerskill on 2/8/18.
//  Copyright © 2018 AKQA. All rights reserved.
//

import Foundation
import SceneKit

class NodeObject: SCNNode {
    
    var animations = [String: CAAnimation]()
    var idle:Bool = true
    
    override init() {
        super.init()
    }
    
    init(withName: String, size: Float) {
        
        super.init()
        
            addCollada2SCNNode(filepath: withName, name: withName)
            
            isHidden = false
        
//        }
    }
    
    func addCollada2SCNNode(filepath:String, name: String) {
        self.name = name
        let scene = SCNScene(named: filepath)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray {
            childNode.name = name
            self.addChildNode(childNode as SCNNode)
        }
        
       // loadAnimation(withKey: "dancing", sceneName: "Models.scnassets/WhiteRobot/TutHipHopDanceFinal", animationIdentifier: "Drossel_29775-anim")
        
    }
    
//    // TODO: Finish loading specific animations so we can execute them on demand
//    func loadAnimation(withKey: String, sceneName: String, animationIdentifier: String) {
//
//        let sceneNameWithoutExt = sceneName.replacingOccurrences(of: ".dae", with: "")
//
//        if let sceneURL = Bundle.main.url(forResource: sceneNameWithoutExt, withExtension: "dae") {
//            let sceneSource = SCNSceneSource(url: sceneURL, options: nil)
//
//            if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
//                // TODO: Repeat animation. The animation will currently only play once.
//
//                animationObject.repeatCount = 1
//                // To create smooth transitions between animations
//                animationObject.fadeInDuration = CGFloat(1)
//                animationObject.fadeOutDuration = CGFloat(0.5)
//
//                // Store the animation for later use
//                animations[withKey] = animationObject
//            }
//        }
//
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//
//    @objc func removeSelf() {
//        self.removeFromParentNode()
//    }
}


