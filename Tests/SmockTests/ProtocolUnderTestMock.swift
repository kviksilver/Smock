//
//  ProtocolUnderTestMock.swift
//  Smock
//
//  Created by Boris Erceg on 08/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Smock

class ProtocolUnderTestMock: NSObject, ProtocolUnderTest, Mock {}

extension ProtocolUnderTestMock {
    func functionToImplement() {
        registerSelector(#selector(functionToImplement))
    }
    
    func functionToImplement_params(params: String) {
        registerSelector(#selector(functionToImplement_params(params:)), params: [params])
    }
    
    func functionToImplement_return() -> String {
        return registerSelector(#selector(functionToImplement_return))!
    }
    
    func functionToImplement_params_return(params: String) -> String {
        return registerSelector(#selector(functionToImplement_params_return), params: [params])!
    }
    
}

extension ProtocolUnderTestMock {
    static func functionToImplement_static() {
        registerSelector(#selector(functionToImplement_static))
    }
    
    static func functionToImplement_params_static(params: String) {
        registerSelector(#selector(functionToImplement_params_static(params:)), params: [params])
    }
    
    static func functionToImplement_return_static() -> String {
        return registerSelector(#selector(functionToImplement_return_static))!
    }
    
    static func functionToImplement_params_return_static(params: String) -> String {
        return registerSelector(#selector(functionToImplement_params_return_static), params: [params])!
    }
}
