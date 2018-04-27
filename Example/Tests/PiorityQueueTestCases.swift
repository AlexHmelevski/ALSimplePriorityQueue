//
//  PiorityQueueTestCases.swift
//  ALSimplePriorityQueue_Tests
//
//  Created by Alex Hmelevski on 2018-04-24.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

@testable import ALSimplePriorityQueue

struct MockPriorityItem: PriorityQueueItem, Equatable {
    let priority: PriorityValue
    let name: String
}


class PiorityQueueTests: XCTestCase {
    

    var tester: PiorityQueueTester!
    override func setUp() {
        super.setUp()
        tester = PiorityQueueTester()

    }
    

    func test_queue_adds_item_to_priority() {
        let items = tester.push(itemsWithPriorities: [.low])
        tester.comparePopNext(with: items.first!)
    }
    
    func test_queue_should_pop_item_with_higher_priority() {
        let items = tester.push(itemsWithPriorities: [.low,.high,.low])
        let highPriorityItem = items.first(where: {$0.priority == .high})!
        let lowPriority = items.filter({$0.priority == .low })
        
        tester.comparePopNext(with: highPriorityItem,
                           additionalCheck: { (queue) in
                queue.items(withPriority: {$0 == .low}) == lowPriority
        })
    }


    func test_queue_should_return_empty_if_no_items_in_the_queue_with_priority() {
        tester.push(itemsWithPriorities: [.low,.high,.high])
        tester.compareStateOfTheQueueAfterPoping(numberOfItems: 2,
                                                 additionalCheck: {(queue) in
                queue.items(withPriority: {$0 == .high}).isEmpty
        })
    }
    
    
    func test_queue_returns_empty_if_no_items_left() {
        tester.push(itemsWithPriorities: [.low,.high,.high])
        tester.compareStateOfTheQueueAfterPoping(numberOfItems: 3,
                                                 additionalCheck: { $0.isEmpty })
    }
    
    func test_top_item_returns_the_item_with_highest_priority() {
         let items = tester.push(itemsWithPriorities: [.low,.high,.medium])
         tester.compareTopItem(with: items[1], additionalCheck: nil)
    }
}
