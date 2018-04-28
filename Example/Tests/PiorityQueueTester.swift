//
//  PiorityQueueTester.swift
//  ALSimplePriorityQueue_Tests
//
//  Created by Alex Hmelevski on 2018-04-26.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
@testable import ALSimplePriorityQueue

class PiorityQueueTester {
    
    typealias AdditionalQueueCheck = (PriorityQueue<MockPriorityItem>) -> Bool
    private(set) var queueToTest: PriorityQueue<MockPriorityItem>
    init() {
        self.queueToTest = PriorityQueue<MockPriorityItem>()
    }
    
    @discardableResult
    func push(itemsWithPriorities priorities: [PriorityValue],
              file: StaticString = #file,
              line: UInt = #line) -> [MockPriorityItem]  {
        
        let items = priorities.map({ MockPriorityItem(priority: $0, name: "\($0)") })
        items.forEach({ queueToTest.push(item: $0) })
        return items
    }
    
    
    func testPush(item: MockPriorityItem,
                  file: StaticString = #file,
                  line: UInt = #line) {
        queueToTest.push(item: item)
        XCTAssertEqual(item, queueToTest.items(withPriority: { $0 == item.priority } ).last, file: file, line: line)
    }
    
    func testReplaceItem(with item: MockPriorityItem,
                         file: StaticString = #file,
                         line: UInt = #line) {
        
        queueToTest.replace(item: item)
        let firstItem = queueToTest.items(withPriority: {$0  == item.priority }).last!
        XCTAssertEqual(firstItem, item,file: file, line: line)
    }
    
    
    func testRemoveItem(_ item: MockPriorityItem,
                        file: StaticString = #file,
                        line: UInt = #line) {
        queueToTest.remove(item: item)
        
        XCTAssertNotEqual([item], queueToTest.items(withPriority: {$0 == item.priority}),file: file, line: line)
    }
    
    
    func highestPriorityIsEqual(toExpected expected: Int,
                                file: StaticString = #file,
                                line: UInt = #line) {
       XCTAssertEqual(queueToTest.highestPriority, expected,file: file, line: line)
    }
    func comparePopNext(with item: MockPriorityItem,
                        additionalCheck: AdditionalQueueCheck? = nil,
                        file: StaticString = #file,
                        line: UInt = #line) {
        
        XCTAssertEqual(queueToTest.popNextItem(), item,file: file, line: line)
        if let check = additionalCheck {
            XCTAssertTrue(check(queueToTest),file: file, line: line)
        }
    }
    
    func compareTopItem(with item: MockPriorityItem,
                        additionalCheck: AdditionalQueueCheck? = nil,
                        file: StaticString = #file,
                        line: UInt = #line) {
        
        XCTAssertEqual(queueToTest.topItem, item,file: file, line: line)
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
