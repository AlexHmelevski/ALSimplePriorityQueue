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


class PiorityQueueTester {
    
    typealias AdditionalQueueCheck = (PriorityQueue<MockPriorityItem>) -> Bool
    private(set) var queueToTest: PriorityQueue<MockPriorityItem>
    init() {
        self.queueToTest = PriorityQueue<MockPriorityItem>()
    }
    
    @discardableResult
    func push(itemsWithPriorities priorities: [PriorityValue]) -> [MockPriorityItem]  {
        let items = priorities.map({ MockPriorityItem(priority: $0, name: "\($0)") })
        items.forEach({ queueToTest.push(item: $0) })
        return items
    }
    
    
    func compareLast(with item: MockPriorityItem,
                     additionalCheck: AdditionalQueueCheck? = nil,
                     file: StaticString = #file,
                     line: UInt = #line) {
        
        XCTAssertEqual(queueToTest.popNextItem(), item,file: file, line: line)
        if let check = additionalCheck {
            XCTAssertTrue(check(queueToTest),file: file, line: line)
        }
    }
    
    func compareStateOfTheQueueAfterPoping(numberOfItems: Int,
                                           additionalCheck: AdditionalQueueCheck,
                                           file: StaticString = #file,
                                           line: UInt = #line) {
        for _ in 0..<numberOfItems {
            queueToTest.popNextItem()
        }
        XCTAssertTrue(additionalCheck(queueToTest),file: file, line: line)
    }
}

class PiorityQueueTests: XCTestCase {
    

    var tester: PiorityQueueTester!
    override func setUp() {
        super.setUp()
        tester = PiorityQueueTester()

    }
    

    func test_queue_adds_item_to_priority() {
        let items = tester.push(itemsWithPriorities: [.low])
        tester.compareLast(with: items.first!)
    }
    
    func test_queue_should_pop_item_with_higher_priority() {
        let items = tester.push(itemsWithPriorities: [.low,.high,.low])
        let highPriorityItem = items.first(where: {$0.priority == .high})!
        let lowPriority = items.filter({$0.priority == .low })
        
        tester.compareLast(with: highPriorityItem,
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
}
