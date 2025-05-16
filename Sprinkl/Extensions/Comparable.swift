//
//  Comparable.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//
extension Comparable {
    
    func clamped(range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(self, range.upperBound))
    }
    
    func clamped(lowerBound: Self) -> Self {
        return max(lowerBound, self)
    }
    
    func clamped(upperBound: Self) -> Self {
        return min(self, upperBound)
    }
    
}
