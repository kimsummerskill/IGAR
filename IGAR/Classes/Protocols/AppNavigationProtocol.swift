//
//  AppNavigationProtocol.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

protocol  AppNavigationProtocol {
    
    var appDelegate: AppDelegate { get }
    var flowCoordinator: FlowCoordinator { get }
    
}

extension AppNavigationProtocol {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var flowCoordinator: FlowCoordinator {
        return appDelegate.flowCoordinator
    }
    
}
