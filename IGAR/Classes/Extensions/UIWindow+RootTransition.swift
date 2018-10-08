//
//  UIWindow+RootTransition.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//
// This is a nice mechanism for dealing with switching the root view controller out without a jarring experience.
// Cases for this would be for when you have elements of the application
// that have decision logic that replaces the root view controller based on a decision somewhere.
// For example, app loads, decides to present the 'App tour', 'Login flow' or main user flow. Also for logout /
// pop to decision screens and such. If you simply replace toe root view controller it is quite jarring.

import UIKit

extension UIWindow {
    
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
        
        let previousViewController = rootViewController
        
        // If we have a transition, add it to our layer
        if let transition = transition {
            layer.add(transition, forKey: kCATransition)
        }
        
        rootViewController = newRootViewController
        
        // Update status bar appearance using the new view controllers appearance. Animate if required.
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        }
        else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }
        
        // The presenting view controllers view doesn.t get removed from the window yet as it's currently transitioning
        // and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        
        if let previousViewController = previousViewController {
            previousViewController.dismiss(animated: false) {
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}

