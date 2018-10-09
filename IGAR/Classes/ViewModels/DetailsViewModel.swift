//
//  DetailsViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

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
        
        // Present full screen
        router.enqueueRoute(with: DetailsRouter.RouteType.teaser)
    }
    
    // From button or maybe swipe
    func backPressed() {
        // Animate off screen
        router.enqueueRoute(with: DetailsRouter.RouteType.offScreen)
    }
    
    func userSwipedDown() {
        self.stream.stop()
        router.enqueueRoute(with: DetailsRouter.RouteType.offScreen)
    }
    
    func userSwipedUp() {
        router.enqueueRoute(with: DetailsRouter.RouteType.fullScreen)
    }
    
    
    public func fetchYahooURL(ticker: String) -> URL? {
        //VXTODO
        let query = "\(stockMarket(id: ticker)):\(ticker)"
        let string  = "https://www.google.com/finance?q=\(query)"
        guard let url =  URL(string: string) else {
            print("VX invalid url: \(string)")
            return nil
        }
        return url
    }
    
    public func stockMarket(id: String) -> String {
        switch id {
        case "IGG", "CMCX":
            return "LSE"
        default:
            return "NYSE"
        }
    }
    public func interactionIdToActualName(id: String) -> String {
        switch id {
        case "FB":
            return "Facebook"
        case "GOOGL":
            return "Google"
        case "IGG":
            return "IG Index"
        case "UN":
            return "Unilever"
        case "CMCX":
            return "CMC Markets"
        default:
             return ""
        }
    }
    public func openIG() {
        if let url = URL(string:"https://itunes.apple.com/gb/app/apple-store/id406492428?mt=8"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
