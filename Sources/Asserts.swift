//
//  Asserts.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation
import XCTest

/// Assert number of calls for given selector on a type
///
/// - Parameters:
///   - mockType: Mock type we are checking `MockType.self`
///   - selector: selector to check for `#selector(functionSelector)`
///   - calls: expected number of calls
public func XCTAssertSelectorCalls<T: MockedType>(_ mockType: T.Type, _ selector: Selector, _ calls: Int, _ message: String = "Selector was not called desired number of times", file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(mockType.numberOfCallsForSelector(selector), calls, message, file: file, line: line)
}


/// Assert number of calls for given selector on an instance
///
/// - Parameters:
///   - mock: instance we are checking
///   - selector: selector to check for `#selector(functionSelector)`
///   - calls: expected number of calls
public func XCTAssertSelectorCalls<T: MockedObject>(_ mock: T, _ selector: Selector, _ calls: Int, _ message: String = "Selector was not called desired number of times", file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(mock.numberOfCallsForSelector(selector), calls, message, file: file, line: line)
}


