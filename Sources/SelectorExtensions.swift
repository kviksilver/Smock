//
//  SelectorExtensions.swift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

extension Selector {
    func key() -> String {
        return self.description.replacingOccurrences(of: "_", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").trimmingCharacters(in: CharacterSet(charactersIn: ":"))
    }
}
