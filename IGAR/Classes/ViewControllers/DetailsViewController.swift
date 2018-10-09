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
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.reloadData()
            }
        }
    }
    
    // Refresh stuff
    func reloadData() {
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        viewModel.backPressed()
    }
}
