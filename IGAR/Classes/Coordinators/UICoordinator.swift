//
//  UICoordinator.swift
//  InHouse-AR
//
//  Created by Kim Summerskill on 1/18/18.
//  Copyright © 2018 AKQA. All rights reserved.
//
// This class is used to coordinate overarching UI presentations
// it is light in this case as it's a test app but if it were a real application
// it would be coordinating the UI presentation of decision flows.

import UIKit

class UICoordinator: AppNavigationProtocol {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // Present the main experience
    func presentMain() {
        let homeRouter = HomeRouter()
        homeRouter.presenAsRootViewController(on: window)
    }
}

