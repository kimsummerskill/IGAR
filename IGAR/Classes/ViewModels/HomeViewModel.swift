//
//  HomeViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class HomeViewModel: MVVMViewModel {
    
    var router: MVVMRouter
    
    required init(router: MVVMRouter) {
        
        self.router = router
        
    }
    
    func presentARExperience() {
        router.enqueueRoute(with: HomeRouter.RouteType.arExperience)
    }
}
