//
//  Clamping.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//


@propertyWrapper
struct Clamping<Value: Comparable> {
  var value: Value
  let range: ClosedRange<Value>

  init(wrappedValue: Value, _ range: ClosedRange<Value>) {
    precondition(range.contains(wrappedValue))
    self.value = wrappedValue
    self.range = range
  }

  var wrappedValue: Value {
    get { value }
    set { value = min(max(range.lowerBound, newValue), range.upperBound) }
  }
}
