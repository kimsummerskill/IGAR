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
    @IBOutlet var webView: UIWebView?
    var viewModel: DetailsViewModel!
    
    var tickerName: String = ""
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        lowLabel.text = ""
        highLabel.text = ""
        let swipeDownGestureRecogniser = UISwipeGestureRecognizer.init(target: self, action: #selector(swipDownHandler(gestureRecognizer:)))
        swipeDownGestureRecogniser.direction = .down
        self.loadTicker(name: tickerName)
        view.addGestureRecognizer(swipeDownGestureRecogniser)

        let swipeUpGestureRecogniser = UISwipeGestureRecognizer.init(target: self, action: #selector(swipUpHandler(gestureRecognizer:)))
        swipeUpGestureRecogniser.direction = .up
        view.addGestureRecognizer(swipeUpGestureRecogniser)
        
        self.view.backgroundColor = UIColor(white: 0.4, alpha: 0.6)
    }
    
    // Refresh stuff
    func reloadData() {
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
    @IBAction func tradePressed() {
        viewModel.openIG()
    }
    
    @objc func swipDownHandler(gestureRecognizer:UISwipeGestureRecognizer) {
        viewModel.userSwipedDown()
    }
    
    @objc func swipUpHandler(gestureRecognizer:UISwipeGestureRecognizer) {
        viewModel.userSwipedUp()
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
        titleLabel?.text = viewModel.interactionIdToActualName(id: name)
        let i = UIImage(named: name)
        image?.image = i
        guard let vm = viewModel else {
            return
        }
        guard let url = vm.fetchYahooURL(ticker: name) else {
            return
        }
        let request = URLRequest(url: url)
        print("VX ffs?: \(tickerName)")
        webView?.loadRequest(request)
    }
}
