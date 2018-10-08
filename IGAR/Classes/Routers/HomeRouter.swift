//
//  HomeRouter.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class HomeRouter: MVVMRouter, AppNavigationProtocol {
    
    enum RouteType {
        case arExperience
    }
    
    weak var baseViewController: UIViewController?
    
    func presenAsRootViewController(on window: UIWindow) {
        
        guard let homeViewController: HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController") as? HomeViewController else {
            
            fatalError("Something has seriously gone wrong if this failed")
        }
        
        let homeViewModel = HomeViewModel(router: self)
        
        homeViewController.viewModel = homeViewModel
        baseViewController = homeViewController
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        
        window.set(rootViewController: homeViewController, withTransition: transition)
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
        guard let baseViewController = baseViewController else {
            return
        }
        
        if let context = context as? RouteType {
            switch context {
            case .arExperience:
                let arExperienceRouter = ARExperienceRouter()
                arExperienceRouter.present(on: baseViewController, animated: true, context: nil, completion: nil)
            }
        }
    }
    
    // Not using this for the initial screen as it is the root view controller
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
