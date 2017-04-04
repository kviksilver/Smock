//
//  SmockedObject.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

public protocol SmockedObject: class {

    var hashValue: Int { get }

    func registerSelectorCall(_ selector: Selector, params: [Any?]?)
    func registerSelectorCall(_ selector: Selector)
    func registerSelectorCall<T>(_ selector: Selector) -> T?
    func registerSelectorCall<T>(_ selector: Selector, params: [Any?]?) -> T?

    func numberOfCallsForSelector(_ selector: Selector) -> Int
    func parametersForSelector(_ selector: Selector) -> [Any?]?

    func stubbedValueForSelector<T>(_ selector: Selector) -> T?
    func stubValueForSelector(_ selector: Selector, _ value: Any?)


    func stopMocking()
    
}


public extension SmockedObject {

    var key: String { return "\(self.hashValue)" }

    func registerSelectorCall(_ selector: Selector) {
        registerSelectorCall(selector, params: nil)
    }

    func registerSelectorCall(_ selector: Selector, params: [Any?]?) {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
    }

    func registerSelectorCallAndReturnStubbedValue<T>(_ selector: Selector) -> T? {
        return registerSelectorCallAndReturnStubbedValue(selector, params: nil)
    }

    func registerSelectorCallAndReturnStubbedValue<T>(_ selector: Selector, params: [Any?]?) -> T? {
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


