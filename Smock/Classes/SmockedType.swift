//
//  SmockedType.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

public protocol SmockedType: class {

    static func registerSelectorCall(_ selector: Selector, params: [Any?]?)
    static func registerSelectorCall(_ selector: Selector)
    static func registerSelectorCall<T>(_ selector: Selector) -> T?
    static func registerSelectorCall<T>(_ selector: Selector, params: [Any?]?) -> T?

    static func numberOfCallsForSelector(_ selector: Selector) -> Int
    static func parametersForSelector(_ selector: Selector) -> [Any?]?

    static func stubbedValueForSelector<T>(_ selector: Selector) -> T?
    static func stubValueForSelector(_ selector: Selector, _ value: Any?)

    static func stopMocking()
}

public extension SmockedType {

    static var key: String {
        let string = String(describing: self)
        return string.components(separatedBy: ".").last ?? string
    }

    static func registerSelectorCall(_ selector: Selector) {
        registerSelectorCall(selector, params: nil)
    }

    static func registerSelectorCall(_ selector: Selector, params: [Any?]?) {
        Smock.registerSelectorForKey(key: key, params: params, selector: selector)
    }

    static func registerSelectorCall<T>(_ selector: Selector) -> T? {
        return registerSelectorCall(selector, params: nil)
    }

    static func registerSelectorCall<T>(_ selector: Selector, params: [Any?]?) -> T? {
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
