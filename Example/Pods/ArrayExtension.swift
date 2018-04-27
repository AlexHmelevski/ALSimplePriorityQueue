//
//  ArrayExtension.swift
//  ALSimplePriorityQueue
//
//  Created by Alex Hmelevski on 2018-04-27.
//

import Foundation


extension Array where Element: Hashable {
    func replacedItem(_ item: Element) -> Array {
        return reduce([], { (partial, element) -> Array in
            if element.hashValue == item.hashValue {
                return partial + [item]
            } else {
                return partial + [element]
            }
        })
    }
}
