//
//  PriorityValue.swift
//  ALSimplePriorityQueue
//
//  Created by Alex Hmelevski on 2018-04-24.
//

import Foundation

public typealias PriorityValue = Int

public extension PriorityValue {
    static var low: PriorityValue { return 250 }
    static var medium: PriorityValue { return 500 }
    static var high: PriorityValue { return 1000 }
}



