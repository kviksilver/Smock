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
}

extension ProtocolUnderTest {
    func functionToTest() {
        functionToImplement()
    }
}
