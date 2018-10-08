//
//  MVVMRouter.swift
//  IGAR
//
//  Created by Kim Summerskill on 1/18/18.
//  Copyright © 2018 AKQA. All rights reserved.
//

import UIKit

protocol MVVMRouter {
    
    // The view controller which is used to present the current one
    var baseViewController: UIViewController? { get set }
    
    // This is the entry point for presenting a view controller for a particular router
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
    
    // This method would be used to present a route as the result of some action. For example a new view controller.
    // Context will be used to pass in any information that is required to present the next route. This could
    // be an object or a tuple or anything you really want to pass over or use for instantiation.
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?)
    
    // This method would be used to dismiss from the base view controller
    func dismiss(animated: Bool, context: Any?, completion:((Bool) -> Void)?)
    
}

extension MVVMRouter {
    
    // Some convenience methods to use default values from parameters, should rarely be used
    
    func present(on baseViewController: UIViewController) {
        self.present(on: baseViewController, animated: true, context: nil, completion: nil)
    }
    
    func enqueueRoute(with context: Any?) {
        self.enqueueRoute(with: context, animated: true, completion: nil)
    }
    
    func enqueueRoute(with context: Any?, completion: ((Bool) -> Void)?) {
        self.enqueueRoute(with: context, animated: true, completion: completion)
    }
}

