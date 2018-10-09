//
//  BaseTypes.swift
//  EyeGee
//
//  Created by vic on 08/10/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import Foundation

struct Currency {
    let symbol: String
    let conversionToUSD: Float
    init(symbol: String, conversionToUSD: Float = 1.0) {
        self.symbol = symbol
        self.conversionToUSD = conversionToUSD
    }
}
struct Price {
    let value: Float
    let currency: Currency
    init(value: Float, currency: Currency) {
        self.value = value
        self.currency = currency
    }
}

var SPREAD:Float = 0.01
struct Spread {
    let low: Price
    let high: Price
    init(base: Price) {
        let diff = base.value * SPREAD
        self.low = Price(value: base.value - diff, currency: base.currency)
        self.high = Price(value: base.value + diff, currency: base.currency)
    }
}
