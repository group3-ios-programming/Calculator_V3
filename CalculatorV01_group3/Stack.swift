//
//  Stack.swift
//  CalculatorV01_group3
//
//  Created by Tran Nhat Tuan on 5/4/18.
//  Copyright © 2018 Tran Nhat Tuan. All rights reserved.
//

import Foundation

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public init() {
        
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    

    
    public var top: T? {
        return array.last
    }
}

extension Stack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { curr.pop() }
    }
}
