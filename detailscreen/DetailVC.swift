//
//  ViewController.swift
//  EyeGee
//
//  Created by vic on 08/10/2018.
//  Copyright © 2018 vixac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lowLabel: UILabel!
    var highLabel: UILabel!
    var vm: DetailVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        let currency = Currency(symbol: "£")
        self.vm = DetailVM(ticker: "AAPL")
        self.view.backgroundColor = .green
        //self.stream?.subsribe(symbol: "AAPL", currency: currency) { val in
        //    print("VX vx got val \(val)")
       // }
        self.vm?.subcribe { spread in
            self.lowLabel.text = "\(spread.low.currency.symbol)\(spread.low.value)"
            self.highLabel.text = "\(spread.low.currency.symbol)\(spread.high.value)"
        }
        print("VX: called subscribe")
        // Do any additional setup after loading the view, typically from a nib.
        labels()
    }
    //VX:TODO rm
    private func labels() {
        self.lowLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        self.highLabel = UILabel(frame: CGRect(x:10, y: 100, width: 100, height: 50))
        self.view.addSubview(self.lowLabel)
        self.view.addSubview(self.highLabel)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

