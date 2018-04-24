//
//  PiorityQueueTests.swift
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
    
    var queueToTest: PriorityQueue<MockPriorityItem>!
    override func setUp() {
        super.setUp()
        queueToTest =  PriorityQueue<MockPriorityItem>()
    }
    

    func test_queue_adds_item_to_priority() {
        let lowPriority = MockPriorityItem(priority: .low, name: "Low")
        queueToTest.push(item: lowPriority)
        let item = queueToTest.popNextItem()!
        XCTAssertEqual(lowPriority, item)
    }
    
    func test_queue_should_pop_item_with_higher_priority() {
         let lowPriority = MockPriorityItem(priority: .low, name: "Low")
         let highPriority = MockPriorityItem(priority: .high, name: "Low")
         queueToTest.push(item: lowPriority)
         queueToTest.push(item: highPriority)
         queueToTest.push(item: lowPriority)
         let item = queueToTest.popNextItem()!
         XCTAssertEqual(highPriority, item)
         XCTAssertEqual(queueToTest.items(withPriority: {$0 == .low}), [lowPriority,lowPriority])
    }
    
    
    
}
