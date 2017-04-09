//
//  SmockedObject.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

public protocol MockedObject: class {

    var hashValue: Int { get }

    func registerSelector(_ selector: Selector)
    func registerSelector(_ selector: Selector, params: [Any?]?)
    func registerSelector<T>(_ selector: Selector) -> T?
    func registerSelector<T>(_ selector: Selector, params: [Any?]?) -> T?

    func numberOfCallsForSelector(_ selector: Selector) -> Int
    func parametersForSelector(_ selector: Selector) -> [Any?]?

    func stubbedValueForSelector<T>(_ selector: Selector) -> T?
    func stubValueForSelector(_ selector: Selector, _ value: Any?)

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


