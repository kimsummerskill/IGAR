//
//  DetailsViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//


protocol DetailsDelegate: class {
    func show(spread: Spread)
    func loadTicker(name: String)
}
class DetailsViewModel: MVVMViewModel {
    
    var router: MVVMRouter
    enum DetailState{
        case showFull
        case hide
    }
    
    var currentState:DetailState = .hide
    var onDataUpdate:(() -> Void)?
    var stream: TickStream
    weak var delegate: DetailsDelegate?
    required init(router: MVVMRouter) {
        self.router = router
        let currency = Currency(symbol: "£")
        stream = FakeTickStream(currency: currency)
    }
    
    // Get your data here then call onDataUpdate
    func setupWithInteractionId(interactionId: String) {
        delegate?.loadTicker(name: interactionId)
        // Load stuff
        print("VX: interaction id to show: \(interactionId)")
        stream.subsribe(symbol: interactionId, currency: Currency(symbol: "£")) { [weak self]
            price in
            print("VX: interaction id to show: \(interactionId)")
            let spread = Spread(base: price)
            self?.delegate?.show(spread: spread)
        }
        
        // then on completion refresh view controller
        onDataUpdate?()
        
        // Present full screen
        router.enqueueRoute(with: DetailsRouter.RouteType.teaser)
    }
    
    // From button or maybe swipe
    func backPressed() {
        // Animate off screen
        router.enqueueRoute(with: DetailsRouter.RouteType.offScreen)
    }
}
