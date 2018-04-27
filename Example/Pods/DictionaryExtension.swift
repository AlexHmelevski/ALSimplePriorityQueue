//
//  DictionaryExtension.swift
//  ALSimplePriorityQueue
//
//  Created by Alex Hmelevski on 2018-04-27.
//

import Foundation


extension Dictionary {
    func values(where condition: (Key) -> Bool) -> [Value]  {
       return reduce([]) { (part, dictItem) -> [Value] in
            if condition(dictItem.key) {
                return part + [dictItem.value]
            } else {
                return part
            }
        }
    }
    
    
    func replacedWithNewItem(_ item: Value, whereOldItem condition: (Value) -> Bool) -> Dictionary {
        return reduce([:], { (partial, dictElement) -> Dictionary in
            var partial = partial
            if condition(dictElement.value) {
                partial[dictElement.key] = item
            } else {
                partial[dictElement.key] = dictElement.value
            }
            return partial
        })
    }
    
    func removedItem(item: Value, where condition: (Value) -> Bool) -> Dictionary {
        return reduce([:], { (partial, dictElement) -> Dictionary in
            var partial = partial
            if !condition(dictElement.value) {
                partial[dictElement.key] = dictElement.value
            }
            return partial
        })
    }
}

extension Dictionary where Value: Hashable {
    func removedItem(item: Value) -> Dictionary {
        return removedItem(item: item, where: {$0.hashValue == item.hashValue})
    }
    
}
