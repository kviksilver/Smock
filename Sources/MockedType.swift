//
//  SmockedType.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

/// Use for mocking static methods, all methods in this protocol are implemented in extension and should not be implemented by conforming type
public protocol MockedType: class {

    /// Registers simple selector call
    ///
    /// - Parameter selector: selector to register `#selector(functionSelector)`
    static func registerSelector(_ selector: Selector)

    /// Registers selector call with parameters
    ///
    /// - Parameters:
    ///   - selector: selector to register `#selector(functionSelector(params:))`
    ///   - params: array of parameters received in function
    static func registerSelector(_ selector: Selector, params: [Any?]?)

    /// Registers simple selector call and returns stubbed value
    ///
    /// - Parameter selector: selector to register `#selector(functionSelector)`
    /// - Returns: value stubbed with `stubValueForSelector`
    static func registerSelector<T>(_ selector: Selector) -> T?

    /// Registers selector call with parameters and returns stubbed value
    ///
    /// - Parameters:
    ///   - selector: selector to register `#selector(functionSelector(params:))`
    ///   - params: array of parameters received in function
    /// - Returns: value stubbed with `stubValueForSelector`
    static func registerSelector<T>(_ selector: Selector, params: [Any?]?) -> T?

    /// Queries for number of calls for given selector
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: number of calls made for given selector on this mock
    static func numberOfCallsForSelector(_ selector: Selector) -> Int

    /// Queries for parameters passed to given selector on its last invocation
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: array of parameters passed to function
    static func parametersForSelector(_ selector: Selector) -> [Any?]?

    /// Queries for stubbed values for given selector
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: stubbed value
    static func stubbedValueForSelector<T>(_ selector: Selector) -> T?

    /// Stub value for given selector
    ///
    /// - Parameters:
    ///   - selector: selector to stub value for `#selector(functionSelector)`
    ///   - value: return value to stub
    static func stubValueForSelector(_ selector: Selector, _ value: Any?)

    /// Stop mocking given object. Will clear stubbed return values, selector calls and parameters
    static func stopMocking()
}

public extension MockedType {

    static var key: String {
        let string = String(describing: self)
        return string.components(separatedBy: ".").last ?? string
    }

    static func registerSelector(_ selector: Selector) {
        registerSelector(selector, params: nil)
    }

    static func registerSelector(_ selector: Selector, params: [Any?]?) {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
    }

    static func registerSelector<T>(_ selector: Selector) -> T? {
        return registerSelector(selector, params: nil)
    }

    static func registerSelector<T>(_ selector: Selector, params: [Any?]?) -> T? {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
        return stubbedValueForSelector(selector)
    }

    static func numberOfCallsForSelector(_ selector: Selector) -> Int {
        return Smock.mocks[key]?.selectors[selector.key()] ?? 0
    }

    static func parametersForSelector(_ selector: Selector) -> [Any?]? {
        return Smock.mocks[key]?.params[selector.key()]
    }

    static func stubbedValueForSelector<T>(_ selector: Selector) -> T? {
        return Smock.mocks[key]?.returnValues[selector.key()] as? T
    }

    static func stubValueForSelector(_ selector: Selector, _ value: Any?) {
        Smock.stubValueForKey(key: key, selector: selector, value: value)
    }

    static func stopMocking() {
        Smock.mocks[key] = nil
    }

}
