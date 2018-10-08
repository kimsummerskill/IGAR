//
//  SphereObject.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation
import SceneKit

class SphereObject: SCNSphere {
    
    var interactionId: String?
    
    override init() {
        super.init()
    }
    
    init(with interactionId: String, radius: CGFloat, texture: String) {
        
        super.init()
        
        self.interactionId = interactionId
        self.radius = radius
        
        var newMaterials = [SCNMaterial]()
        
        let material = SCNMaterial()
        
        material.setMaterial(textureName: texture, colour: nil)
        
        newMaterials.append(material)
        
        self.materials = newMaterials
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

