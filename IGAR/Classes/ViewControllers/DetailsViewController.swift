//
//  DetailsViewController.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, MVVMViewControllerProtocol {
    
    @IBOutlet var lowLabel: UILabel!
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var image: UIImageView?
    var viewModel: DetailsViewModel!
    
    var tickerName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.reloadData()
            }
        }
        self.loadTicker(name: tickerName)
    }
    
    // Refresh stuff
    func reloadData() {
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
    @IBAction func tradePressed() {
        print("VX trade pressed")
    }
}


extension DetailsViewController: DetailsDelegate {
    func show( spread: Spread) {
        print("VX: spread: \(spread)")
        self.lowLabel.text = spread.displayLow()
        self.highLabel.text = spread.displayHigh()
    }
    
    func loadTicker(name: String) {
        self.tickerName = name
        print("VX loading: \(tickerName)")
        titleLabel?.text = name
        let i = UIImage(named: name)
        image?.image = i
    }
}
