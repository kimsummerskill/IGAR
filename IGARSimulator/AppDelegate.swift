//
//  AppDelegate.swift
//  IGARSimulator
//
//  Created by vic on 09/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit


class FlowCoordinator {
    
}
class SimulatorRouter: MVVMRouter {
    var baseViewController: UIViewController?
    
    // This is the entry point for presenting a view controller for a particular router
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    // This method would be used to present a route as the result of some action. For example a new view controller.
    // Context will be used to pass in any information that is required to present the next route. This could
    // be an object or a tuple or anything you really want to pass over or use for instantiation.
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
    }
    
    // This method would be used to dismiss from the base view controller
    func dismiss(animated: Bool, context: Any?, completion:((Bool) -> Void)?) {
        
    }
}
@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var flowCoordinator: FlowCoordinator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? DetailsViewController else {
            print("VX: ffs")
            return false 
        }
        var rooter = SimulatorRouter()
        let vm = DetailsViewModel(router: rooter)
        
        vm.setupWithInteractionId(interactionId: "GOOGL")
        vm.delegate = vc
        vc.viewModel = vm
        let localWindow = UIWindow(frame: UIScreen.main.bounds)
        
        localWindow.backgroundColor = .black
        localWindow.makeKeyAndVisible()
        localWindow.rootViewController = vc
        window = localWindow
       // self.present(controller, animated: true, completion: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

