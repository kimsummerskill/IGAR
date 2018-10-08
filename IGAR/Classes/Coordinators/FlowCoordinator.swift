//
//  FlowCoordinator.swift
//  InHouse-AR
//
//  Created by Kim Summerskill on 1/18/18.
//  Copyright © 2018 AKQA. All rights reserved.
//
// This class is used to coordinate various flows in the application. These flows could be anything from popping
// the user out to the app tour when there is an update with new app tour information or back to the login screen if
// their authentication had become invalidated for whatever reason (token expiry etc) or if you had a
// decision screen flow where you might decide what flow to present depending on various conditions
// (say you had a paired bluetooth device that this app was communicating with and it got disconnected
// and you wanted to show a re-connect flow for example).

import UIKit

class FlowCoordinator {
    let coordinator: UICoordinator
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    init(window: UIWindow) {
        coordinator = UICoordinator(window: window)
    }
    
    func presentMain() {
        coordinator.presentMain()
    }
}
