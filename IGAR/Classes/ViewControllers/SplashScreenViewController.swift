//
//  SplashScreenViewController.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController, AppNavigationProtocol {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Going to present the main flow after the splash screen has loaded for now. Normally you would have it
        // play something or load something or get the app ready and then present the main experience afterwards.
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            self.flowCoordinator.presentMain()
        })
    }
}
