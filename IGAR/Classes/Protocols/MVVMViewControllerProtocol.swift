//
//  MVVMViewControllerProtocol.swift
//  IGAR
//
//  Created by Kim Summerskill on 08/10/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

protocol MVVMViewControllerProtocol: class {
    
    associatedtype viewModelType
    
    var viewModel: viewModelType! { get set }
    
}
