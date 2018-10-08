//
//  SCNMaterial+Texture.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import SceneKit
import SpriteKit

extension SCNMaterial {
    
    func setMaterial(textureName: String?, colour: UIColor?) {
        if let texture = textureName {
            let skTexture = SKTexture(imageNamed: texture)
            diffuse.contents =  skTexture
        }
        else {
            if let colour = colour {
                diffuse.contents =  colour
            }
        }
        
        locksAmbientWithDiffuse = true
        lightingModel = .phong
    }
}
