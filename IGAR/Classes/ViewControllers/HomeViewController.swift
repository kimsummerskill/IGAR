//
//  HomeViewController.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, MVVMViewControllerProtocol {

    var viewModel: HomeViewModel!

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func presentARExperiencePressed(_ sender: Any) {
        viewModel.presentARExperience()
    }
}
