//
//  Asserts.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation
import XCTest

public func XCTAssertSelectorCalls<T: SmockedType>(_ mockType: T.Type, _ selector: Selector, _ calls: Int, _ message: String = "Selector was not called desired number of times", file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(mockType.numberOfCallsForSelector(selector), calls, message, file: file, line: line)
}

public func XCTAssertSelectorCalls<T: SmockedObject>(_ mock: T, _ selector: Selector, _ calls: Int, _ message: String = "Selector was not called desired number of times", file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(mock.numberOfCallsForSelector(selector), calls, message, file: file, line: line)
}
