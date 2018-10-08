//
//  ARExperienceViewModel.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

class ARExperienceViewModel: MVVMViewModel {
    
    var router: MVVMRouter
    
    required init(router: MVVMRouter) {
        
        self.router = router
        
    }
    
}
