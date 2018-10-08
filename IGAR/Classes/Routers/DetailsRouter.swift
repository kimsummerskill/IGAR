//
//  DetailsRouter.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class DetailsRouter: MVVMRouter, AppNavigationProtocol {
    
    enum RouteType {
        case offScreen
        case fullScreen
    }
    
    let transitionDuration =  0.5
    
    weak var baseViewController: UIViewController?
    
    // Not using this for the initial screen as it is the root view controller
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        

    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
        guard let baseViewController = baseViewController else {
            return
        }
        
        if let context = context as? RouteType {
            
            let duration = animated ? transitionDuration : 0.0
            
            switch context {
                case .offScreen:
                    UIView.animate(withDuration: duration , animations: {
                        baseViewController.view.frame = CGRect(x: 0, y:baseViewController.view.frame.size.height, width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height)
                        
                    })
                
                
                case .fullScreen:
                    UIView.animate(withDuration: duration, animations: {
                        baseViewController.view.frame = CGRect(x: 0, y:0, width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height)
                        
                    })
            }
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
