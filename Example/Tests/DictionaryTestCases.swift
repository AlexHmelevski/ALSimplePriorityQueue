//
//  DictionaryTestCases.swift
//  ALSimplePriorityQueue_Tests
//
//  Created by Alex Hmelevski on 2018-04-27.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import ALSimplePriorityQueue

class DictionaryTestCases: XCTestCase {

    
    func test_replaces_element() {
        let dict = ["a": 1, "b": 2, "c": 3]
        let expected = ["a": 1,"b": 5, "c": 3]
        XCTAssertEqual(expected, dict.replacedWithNewItem(5, whereOldItem: {$0 == 2}))
    }
    
    func test_replace_item_doesnt_modify_if_not_found() {
        let dict = ["a": 1, "b": 2, "c": 3]
        XCTAssertEqual(dict, dict.replacedWithNewItem(2, whereOldItem: {$0 == 5}))
    }
    
    func test_remove_item() {
        let dict = ["a": 1, "b": 2, "c": 3]
        let expected = ["a": 1, "c": 3]
        XCTAssertEqual(expected, dict.removedItem(item: 2))
    }
    
}
