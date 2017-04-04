//
//  Smock.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation


struct Smock {
    static var mockedObjectShouldLog = false
    static var mocks = [String: SmockStorage]()

    static func registerSelectorForKey(key: String, params: [Any?]?, selector: Selector) {
        if mockedObjectShouldLog {
            print("##############################################################")
            print("registering selector: \(selector.key())")
            print("for key: \(key)")
            print("with params: \(String(describing: params?.debugDescription))")
            print("##############################################################")
        }

        guard var storage = mocks[key] else {
            mocks[key] = SmockStorage()
            return registerSelectorForKey(key: key, params: params, selector: selector)
        }

        storage.selectors[selector.key()] = (storage.selectors[selector.key()] ?? 0) + 1
        if let parameters = params {
            storage.params[selector.key()] = parameters
        }
        mocks[key] = storage
    }

    static func stubValueForKey(key: String, selector: Selector, value: Any?) {
        if mockedObjectShouldLog {
            print("##############################################################")
            print("stubbinn value: \(value.debugDescription)")
            print("for key: \(key)")
            print("with selector: \(selector.key())")
            print("##############################################################")
        }

        guard var storage = mocks[key] else {
            mocks[key] = SmockStorage()
            return stubValueForKey(key: key, selector: selector, value:value)
        }
        storage.returnValues[selector.key()] = value
        mocks[key] = storage
    }

}
