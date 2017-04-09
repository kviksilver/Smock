//
//  ObjectUnderTest.swift
//  Smock
//
//  Created by kviksilver on 04/05/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

protocol ProtocolUnderTest: class {
    func functionToTest()
    func functionToImplement()

    func functionToTest_params(params: String)
    func functionToImplement_params(params: String)

    func functionToTest_return() -> String
    func functionToImplement_return() -> String

    func functionToTest_params_return(params: String) -> String
    func functionToImplement_params_return(params: String) -> String

    static func functionToTest_static()
    static func functionToImplement_static()

    static func functionToTest_params_static(params: String)
    static func functionToImplement_params_static(params: String)

    static func functionToTest_return_static() -> String
    static func functionToImplement_return_static() -> String

    static func functionToTest_params_return_static(params: String) -> String
    static func functionToImplement_params_return_static(params: String) -> String
}

extension ProtocolUnderTest {

    func functionToTest() {
        functionToImplement()
    }

    func functionToTest_params(params: String) {
        functionToImplement_params(params: params)
    }

    func functionToTest_return() -> String {
        return functionToImplement_return()
    }

    func functionToTest_params_return(params: String) -> String {
        return functionToImplement_params_return(params: params)
    }

}

extension ProtocolUnderTest {

    static func functionToTest_static() {
        functionToImplement_static()
    }

    static func functionToTest_params_static(params: String) {
        functionToImplement_params_static(params: params)
    }

    static func functionToTest_return_static() -> String {
        return functionToImplement_return_static()
    }

    static func functionToTest_params_return_static(params: String) -> String {
        return functionToImplement_params_return_static(params: params)
    }

}
