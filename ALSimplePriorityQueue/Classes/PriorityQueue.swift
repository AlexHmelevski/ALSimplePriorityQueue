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


public struct PriorityQueue<T: PriorityQueueItem> {
    private var items: [PriorityValue: [T]] = [:]
    
    public init() {}
    
    public var isEmpty: Bool {
        return items.keys.isEmpty
    }
    
    public mutating func push(item: T) {
        items[item.priority] = items[item.priority].map({ $0 + [item]}) ?? [item]
    }
    
    @discardableResult
    public mutating func popNextItem() -> T? {
        return  highestPriority.map({($0, self.items(withPriority: $0))})
            .flatMap({self.removeFirstItem(from: $0.1, withPriority: $0.0)})
        
    }
    
    
    private var highestPriority: PriorityValue? {
        return items.keys.sorted().last
    }
    
    private func items(withPriority priority: PriorityValue) -> [T] {
        return items[priority] ?? []
    }
    
    public func items(withPriority check: (PriorityValue) -> Bool) -> [T] {
        return items.reduce([]) { (part, dictItem) -> [T] in
            if check(dictItem.key) {
                return part + dictItem.value
            } else {
                return part
            }
        }
    }
    
    private mutating func removeFirstItem(from items: [T], withPriority priority: PriorityValue) -> T? {
        var itemToReturn: T?
        let updatedItems = items.enumerated().reduce([]) { (part, result) -> [T] in
            if result.offset == 0 {
                itemToReturn = result.element
                return part
            } else {
                return part + [result.element]
            }
        }
        
        updateQueue(withItems: updatedItems, withPriority: priority)
        return itemToReturn
    }
    
    private mutating func updateQueue(withItems newItems:  [T], withPriority priority: PriorityValue) {
        if newItems.isEmpty {
            items.removeValue(forKey: priority)
        } else {
            items[priority] = newItems
        }
    }
}
