//
//  SmockedObject.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

/// Use for mocking instance methods, all methods in this protocol are implemented in extension and should not be implemented by conforming type
public protocol MockedObject: class {

    /// Hash value to identify each object instance. Make your mock subclass NSObject to get this for free
    var hashValue: Int { get }

    /// Registers simple selector call
    ///
    /// - Parameter selector: selector to register `#selector(functionSelector)`
    func registerSelector(_ selector: Selector)
    
    /// Registers selector call with parameters
    ///
    /// - Parameters:
    ///   - selector: selector to register `#selector(functionSelector(params:))`
    ///   - params: array of parameters received in function
    func registerSelector(_ selector: Selector, params: [Any?]?)
    
    /// Registers simple selector call and returns stubbed value
    ///
    /// - Parameter selector: selector to register `#selector(functionSelector)`
    /// - Returns: value stubbed with `stubValueForSelector`
    func registerSelector<T>(_ selector: Selector) -> T?
    
    /// Registers selector call with parameters and returns stubbed value
    ///
    /// - Parameters:
    ///   - selector: selector to register `#selector(functionSelector(params:))`
    ///   - params: array of parameters received in function
    /// - Returns: value stubbed with `stubValueForSelector`
    func registerSelector<T>(_ selector: Selector, params: [Any?]?) -> T?

    /// Queries for number of calls for given selector
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: number of calls made for given selector on this mock
    func numberOfCallsForSelector(_ selector: Selector) -> Int
    
    /// Queries for parameters passed to given selector on its last invocation
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: array of parameters passed to function
    func parametersForSelector(_ selector: Selector) -> [Any?]?

    /// Queries for stubbed values for given selector
    ///
    /// - Parameter selector: selector to query against `#selector(functionSelector)`
    /// - Returns: stubbed value
    func stubbedValueForSelector<T>(_ selector: Selector) -> T?
    
    /// Stub value for given selector
    ///
    /// - Parameters:
    ///   - selector: selector to stub value for `#selector(functionSelector)`
    ///   - value: return value to stub
    func stubValueForSelector(_ selector: Selector, _ value: Any?)

    /// Stop mocking given object. Will clear stubbed return values, selector calls and parameters
    func stopMocking()
}


public extension MockedObject {

    var key: String { return "\(self.hashValue)" }

    func registerSelector(_ selector: Selector) {
        registerSelector(selector, params: nil)
    }

    func registerSelector(_ selector: Selector, params: [Any?]?) {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
    }

    func registerSelector<T>(_ selector: Selector) -> T? {
        return registerSelector(selector, params: nil)
    }

    func registerSelector<T>(_ selector: Selector, params: [Any?]?) -> T? {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
        return stubbedValueForSelector(selector)
    }

    func numberOfCallsForSelector(_ selector: Selector) -> Int {
        return Smock.mocks[key]?.selectors[selector.key()] ?? 0
    }

    func parametersForSelector(_ selector: Selector) -> [Any?]? {
        return Smock.mocks[key]?.params[selector.key()]
    }

    func stubbedValueForSelector<T>(_ selector: Selector) -> T? {
        return Smock.mocks[key]?.returnValues[selector.key()] as? T
    }

    func stubValueForSelector(_ selector: Selector, _ value: Any?) {
        Smock.stubValueForKey(key: key, selector: selector, value: value)
    }

    func stopMocking() {
        Smock.mocks[key] = nil
    }
}


