//
//  SCNNode+Helpers.swift
//  InHouse-AR
//
//  Created by Kim Summerskill on 3/5/18.
//  Copyright © 2018 AKQA. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {
    /// Returns parent node of specified type.
    /// - Returns: An optional `SCNNode` of specified `T` class type.
    func parentOfType<T: SCNNode>() -> T? {
        var node: SCNNode! = self
        repeat {
            if let node = node as? T { return node }
            node = node?.parent
        } while node != nil
        return nil
    }
    
    //collada2SCNNode
    func collada2SCNNode(filepath:String, name: String) -> SCNNode {
        let node = SCNNode()
        node.name = name
        let scene = SCNScene(named: filepath)
        let nodeArray = scene!.rootNode.childNodes
        
        for childNode in nodeArray {
            childNode.name = name
            
            node.addChildNode(childNode as SCNNode)
        }
        return node
    }
    
    //    func addCollada2SCNNode(filepath:String, name: String) {
    //        self.name = name
    //        let scene = SCNScene(named: filepath)
    //        let nodeArray = scene!.rootNode.childNodes
    //
    //        for childNode in nodeArray {
    //            childNode.name = name
    //            self.addChildNode(childNode as SCNNode)
    //        }

    
//    func setPhysics(with physicsData: PhysicsBody?, scale: SCNVector3) {
//
//        if let physicsData = physicsData {
//
//            var shape: SCNPhysicsShape? = nil
//
//            // TODO: Need to work out geometry of shape rather than let xcode decide
//            let geometry = childNodes.flatMap{ $0.geometry }.first
//
//            if let geo = geometry {
//
//                shape = SCNPhysicsShape(geometry: geo, options: [SCNPhysicsShape.Option.type:SCNPhysicsShape.ShapeType.convexHull, SCNPhysicsShape.Option.scale: scale])
//            }
//
//            let body = SCNPhysicsBody(type: physicsData.bodyType, shape: shape)
//
//            body.isAffectedByGravity = physicsData.affectedByGravity
//            body.mass = physicsData.mass
//            body.friction = physicsData.friction
//            body.rollingFriction = physicsData.rollingFriction
//            body.restitution = physicsData.restitution
//            body.allowsResting = true
//            body.categoryBitMask = 1 << 1
//            body.contactTestBitMask = 1 << 1
//            physicsBody = body
//        }
//        else {
//            let pBody = SCNPhysicsBody(type: .static , shape: nil)
//            pBody.isAffectedByGravity = false
//            pBody.allowsResting = true
//            physicsBody = pBody
//        }
    
//    }
    
}
