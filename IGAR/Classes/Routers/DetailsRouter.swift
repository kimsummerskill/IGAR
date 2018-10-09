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
        case teaser
        case fullScreen
    }
    
    let transitionDuration =  0.5
    
    var currentState: RouteType = RouteType.fullScreen
    
    weak var baseViewController: UIViewController?
    
    // Not using this for the initial screen as it is the root view controller
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
        guard let baseViewController = baseViewController else {
            return
        }
        
        if let context = context as? RouteType {
            
            var duration = animated ? transitionDuration : 0.0
            
    
            switch context {
                case .offScreen:
                    
                    if currentState == .teaser {
                        duration = duration * 0.5
                    }
                    
                    UIView.animate(withDuration: duration , animations: {
                        baseViewController.view.frame = CGRect(x: 0, y:baseViewController.view.frame.size.height, width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height)
                        
                    }, completion: { _ in
                        self.currentState = RouteType.offScreen
                        completion?(true)
                    })
                
            case .teaser:
                
                switch currentState {
                case .fullScreen:
                    duration = duration * 0.7
                    
                case .offScreen:
                    duration = duration * 0.5
                    
                default:
                    break
                }
                
                if currentState == .teaser {
                    
                    self.enqueueRoute(with: RouteType.offScreen, animated: true, completion: { _ in
                        self.enqueueRoute(with: RouteType.teaser, animated: true, completion: nil)
                    })
                }
                else {
                    UIView.animate(withDuration: duration , animations: {
                        baseViewController.view.frame = CGRect(x: 0, y:baseViewController.view.frame.size.height*0.7, width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height)
                        
                    }, completion: { _ in
                        self.currentState = RouteType.teaser
                        completion?(true)
                    })
                }
                
                case .fullScreen:
                    
                    if currentState == .teaser {
                        duration = duration * 0.7
                    }
                    
                    UIView.animate(withDuration: duration, animations: {
                        baseViewController.view.frame = CGRect(x: 0, y:0, width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height)
                        
                    }, completion: { _ in
                        self.currentState = RouteType.fullScreen
                        completion?(true)
                    })
            }
        }
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
