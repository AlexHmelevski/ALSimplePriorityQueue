//
//  PriorityQueue.swift
//  ALSimplePriorityQueue
//
//  Created by Alex Hmelevski on 2018-04-24.
//

import Foundation

public protocol PriorityQueueItem: Hashable {
    var priority: Int { get }
}



