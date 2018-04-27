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
    func push(itemsWithPriorities priorities: [PriorityValue]) -> [MockPriorityItem]  {
        let items = priorities.map({ MockPriorityItem(priority: $0, name: "\($0)") })
        items.forEach({ queueToTest.push(item: $0) })
        return items
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
