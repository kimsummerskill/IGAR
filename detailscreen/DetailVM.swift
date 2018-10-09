//
//  DetailVM.swift
//  EyeGee
//
//  Created by vic on 08/10/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

typealias SpreadCallback = ((Spread) -> Void)
protocol DetailViewModel {
    //   func subsribe(symbol: String, currency: Currency, cb:@escaping SpreadCallback)
    func subcribe(cb:@escaping SpreadCallback)
}

class DetailVM: DetailViewModel {
    var stream: TickStream
    let ticker: String
    init(ticker: String) {
        self.ticker = ticker
        let currency = Currency(symbol: "£")
        stream = FakeTickStream(currency: currency)
    }
    
    func subcribe(cb: @escaping SpreadCallback) {
        stream.subsribe(symbol: self.ticker, currency: Currency(symbol: "£")) { [weak self] price in
            let spread = Spread(base: price)
            cb(spread)
        }
    }
}
