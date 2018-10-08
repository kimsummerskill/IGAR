//
//  DetailsViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

class DetailsViewModel: MVVMViewModel {
    
    var router: MVVMRouter
    
    enum DetailState{
        case showFull
        case hide
    }
    
    var currentState:DetailState = .hide
    
    var onDataUpdate:(() -> Void)?
    
    required init(router: MVVMRouter) {
        self.router = router

    }
    
    // Get your data here then call onDataUpdate
    func setupWithInteractionId(interactionId: String) {
        
        // Load stuff
        
        // then on completion refresh view controller
        onDataUpdate?()
        
        // Present full screen
        router.enqueueRoute(with: DetailsRouter.RouteType.fullScreen)
    }
    
    // From button or maybe swipe
    func backPressed() {
        // Animate off screen
        router.enqueueRoute(with: DetailsRouter.RouteType.offScreen)
    }
}
