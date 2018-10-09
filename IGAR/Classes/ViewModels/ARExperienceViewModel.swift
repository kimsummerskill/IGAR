//
//  ARExperienceViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ARExperienceViewModel: MVVMViewModel {
    
    var router: MVVMRouter
    
    var present2dOverlay:(( _ withPresentation: String) -> Void)?
    var setupOverlayViewController: ((_ withViewController: DetailsViewController) -> Void)?
    
    required init(router: MVVMRouter) {
        
        self.router = router
        
    }
    
    func setupDetailsView() {
        
        guard let detailsViewController: DetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController else {
            
            fatalError("Something has seriously gone wrong if this failed")
        }
        
        let router = DetailsRouter()
        router.baseViewController = detailsViewController
        let detailsViewModel = DetailsViewModel(router: router)
        detailsViewModel.delegate = detailsViewController
        detailsViewController.viewModel = detailsViewModel
        detailsViewController.view.isHidden = false
        
        self.setupOverlayViewController?(detailsViewController)
        
    }
}
