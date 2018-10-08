//
//  ARExperienceRouter.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ARExperienceRouter: MVVMRouter, AppNavigationProtocol {
    
    weak var baseViewController: UIViewController?
    
    // Not using this for the initial screen as it is the root view controller
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
        self.baseViewController = baseViewController
        
        guard let arExperienceViewController: ARExperienceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "arExperienceViewController") as? ARExperienceViewController else {
            
            fatalError("Something has seriously gone wrong if this failed")
        }
        
        let arExperienceViewModel = ARExperienceViewModel(router: self)
        
        arExperienceViewController.viewModel = arExperienceViewModel
        baseViewController.present(arExperienceViewController, animated: true)
        
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
