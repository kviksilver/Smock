//
//  Smock.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

public enum LogLevel {
    case quiet
    case verbose
    
    fileprivate func log(_ string: String) {
        switch self {
        case .verbose:
            print(string)
        default:
            break
        }
    }
}

public struct Smock {
    
    /// Marks log level for library
    public static var logLevel = LogLevel.quiet
    
    static var mocks = [String: SmockStorage]()
    
    static func registerSelectorForKey(key: String, params: [Any?]?, selector: Selector) {
        
        logLevel.log("##############################################################")
        logLevel.log("registering selector: \(selector.key())")
        logLevel.log("for key: \(key)")
        logLevel.log("with params: \(String(describing: params?.debugDescription))")
        logLevel.log("##############################################################")
        
        
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
        logLevel.log("##############################################################")
        logLevel.log("stubbinn value: \(value.debugDescription)")
        logLevel.log("for key: \(key)")
        logLevel.log("with selector: \(selector.key())")
        logLevel.log("##############################################################")
        

        guard var storage = mocks[key] else {
            mocks[key] = SmockStorage()
            return stubValueForKey(key: key, selector: selector, value:value)
        }
        storage.returnValues[selector.key()] = value
        mocks[key] = storage
    }

}

public protocol Mock: MockedType, MockedObject {}
