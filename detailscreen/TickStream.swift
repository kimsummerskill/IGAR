//
//  TickStream.swift
//  EyeGee
//
//  Created by vic on 08/10/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

typealias TickCallback = ((Price) -> Void)
protocol TickStream {
    func subsribe(symbol: String, currency: Currency, cb:@escaping TickCallback)
}

enum TickStreamState {
    case ready
    case live
}
typealias TickSubscription = String
//VXTODO use instead of typeaslias
/*
struct TickSubscription: Equatable {
    let symbol: String,
    let currency: Currency
    init(symbol: String, currency: String) {
        self.symbol = symbol
        self.currency = currency
    }
    
}
 */
class FakeTickStream: TickStream {
    let currency: Currency
    private var subs: [TickSubscription: TickCallback] = [:]
    private var state: TickStreamState = .ready
    
    private var fakePrices: [String: Float] = [:]
    private var timer: Timer?
    init(currency: Currency) {
        self.currency = currency
        self.populateFakePrices()
    }
    
    func subsribe(symbol: String, currency: Currency, cb:@escaping TickCallback) {
        print("VX fake tick stream subscribing to symbol: \(symbol)")
        let tickSub: TickSubscription = symbol
        subs[tickSub] = cb
        start()
    }
    
    private func start() {
        if self.state == .ready {
            self.state = .live
            print("VX stream started")
            self.stream()
        }
    }
    
    public func stop() {
        self.timer = nil
    }
    
    private func stream() {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1,
                                    target: self,
                                    selector: #selector(onTick),
                                  userInfo: nil ,
                                  repeats: true)
    }
    @objc private func onTick() {
        if shouldRandomlyDoNothing() {
            return
        }
        for sub in self.subs {
            let symbol = sub.key
            if let value = self.walk(symbol: symbol) {
                sub.value(Price(value: value, currency: self.currency))
            }
        }
    }
    private func shouldRandomlyDoNothing() -> Bool {
       let rand =  Float(Float(arc4random()) / Float(UINT32_MAX))
        return rand > 0.2
        
    }
    private func walk(symbol:String) -> Float? {
        guard let current = fakePrices[symbol] else {
            print("VX: missing fake price for '\(symbol)'")
            return nil
        }
        let multiplier = self.randomMultipler()
        let next =  current + current * multiplier
        fakePrices[symbol] = next
        return next
    }
    private func populateFakePrices() {
        fakePrices["FB"] = 203.00
        fakePrices["GOOGL"] = 1154.0
        fakePrices["IGG"] = 613.99
        fakePrices["AAPL"] = 1154.0
        fakePrices["UN"] = 903.0
        fakePrices["CMC"] = 34.0
    }
    
    
    /**
      returns a step between 0.01 and - 0.01
     */
    private func randomMultipler() -> Float {
        let x = Float(Float(arc4random()) / Float(UINT32_MAX))
        
        return (x - 0.5) * 0.01
    }
}
