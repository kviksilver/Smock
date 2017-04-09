//
//  Smockswift
//  Smock
//
//  Created by kviksilver on 04/03/2017.
//  Copyright (c) 2017 kviksilver. All rights reserved.
//

import Foundation

struct SmockStorage {
    var selectors = [String: Int]()
    var params = [String: [Any?]]()
    var returnValues = [String: Any?]()
}
