//
//  TimePeriodChain.swift
//  DateTools
//
// Copyright 2015 Codewise sp. z o.o. Sp. K.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

public class TimePeriodChain: NSObject, TimePeriodGroup {
    
    internal(set) var periods: [TimePeriod] = [] {
        didSet {
            self.updateVariables()
        }
    }
    
    internal(set) var calendar: NSCalendar
    
    /**
        The start date of `TimePeriodChain` representing the starting boundary of the `TimePeriodChain`
    */
    public var startDate: NSDate?
    
    /**
        The end date of `TimePeriodChain` representing the ending boundary of the `TimePeriodChain`
    */
    public var endDate: NSDate?
    
    /**
        The earliest `TimePeriod` object in chain
    */
    public var first: TimePeriod? {
        get {
            return self.periods.first
        }
    }
    
    /**
        The latest `TimePeriod` object in chain
    */
    public var last: TimePeriod? {
        get {
            return self.periods.last
        }
    }
    
    /**
        Initializes an instance of `TimePeriodChain` using given calendar
    
        - parameter calendar: Calendar used for date calculations, defaults to `NSCalendar.currentCalendar()`
    */
    public init(calendar: NSCalendar = NSCalendar.currentCalendar()) {
        self.calendar = calendar
        super.init()
    }
    
    /**
        Appends given `TimePeriod` object at the end of the chain. This modifies `startDate` and `endDate` of `TimePeriod` to fit the chain.
    
        - parameter timePeriod: `TimePeriod` object to be added to the chain
    */
    public func addTimePeriod(timePeriod: TimePeriod) {
        if self.periods.count > 0 {
            let modifiedPeriod = TimePeriod(size: TimePeriodSize.Second, amount: Int(timePeriod.durationInSeconds), startingAt: self.periods[self.periods.count - 1].endDate, calendar: self.calendar)
            self.periods.append(modifiedPeriod)
        } else {
            self.periods.append(timePeriod)
        }
    }
    
    /**
        Inserts given `TimePeriod` object at given index. Side effect of this method depends on index at which item is inserted.
        * When inserted at index 0 it prepends `TimePeriod` object to the chain, so that endDate of inserted `TimePeriod` object is equal to startDate of first element in the chain. Duration of `TimePeriod` parameter stays the same.
        * When inserted in the middle, this method shifts later all `TimePeriod` objects that have higher index than index given by the parameter, by the duration of given `TimePeriod` object. It also modifies `startDate` and `endDate` of given `TimePeriod` object to fit the chain.
        * When inserted at last index, this method appends given `TimePeriod` object modyfying `startDate` and `endDate` to fit the chain.
    
        - parameter timePeriod: `TimePeriod` object to be inserted
        - parameter index: index at which `TimePeriod` object has to be inserted
    */
    public func insertTimePeriod(timePeriod: TimePeriod, atIndex index: Int) {
        switch index {
        case 0 where self.periods.count == 0:
            self.addTimePeriod(timePeriod)
            
        case 0 where self.periods.count > 0:
            let modifiedPeriod = TimePeriod(size: TimePeriodSize.Second, amount: Int(timePeriod.durationInSeconds), endingAt: self.periods[0].startDate, calendar: self.calendar)
            self.periods.insert(modifiedPeriod, atIndex: 0)
            
        case let index where index <= self.periods.count:
            for (idx, period) in self.periods.enumerate() {
                if idx >= index {
                    period.shiftLaterWithSize(TimePeriodSize.Second, amount: Int(timePeriod.durationInSeconds))
                }
            }
            
            let modifiedPeriod = TimePeriod(size: TimePeriodSize.Second, amount: Int(timePeriod.durationInSeconds), startingAt: self.periods[index - 1].endDate, calendar: self.calendar)
            
            self.periods.insert(modifiedPeriod, atIndex: index)
        default:
            break
        }
    }
    
    /**
        Removes `TimePeriod` object at given index from the chain. This method shifts earlier all `TimePeriod` objects that have higher index than index given by the parameter, by duration of removed `TimePeriod` object.
    
        - parameter index: index of a `TimePeriod` object to be removed
    
        - returns: `Optional(TimePeriod)` removed from the chain, `nil` if object is not found
    */
    public func removeTimePeriod(atIndex index: Int) -> TimePeriod? {
        guard index >= 0 && index < self.periods.count else {
            return nil
        }
        
        let period = self.periods[index]
        
        for (idx, obj) in self.periods.enumerate() {
            if idx > index {
                obj.shiftEarlierWithSize(TimePeriodSize.Second, amount: Int(period.durationInSeconds))
            }
        }
        
        self.periods.removeAtIndex(index)
        
        return period
    }
    
    /**
        Removes latest `TimePeriod` object from the chain.
    
        - returns: `Optional(TimePeriod)` removed from the chain, `nil` if chain is empty
    */
    public func removeLatestTimePeriod() -> TimePeriod? {
        guard self.periods.count > 0 else {
            return nil
        }
        
        let period = self.periods.last
        self.periods.removeLast()
        
        return period
    }
    
    /**
        Removes earliest `TimePeriod` object from the chain. This method shifts earlier all `TimePeriod` objects in the chain, so that `startDate` stays the same.
    
        - returns: `Optional(TimePeriod)` removed from the chain, `nil` if chain is empty
    */
    public func removeEarliestTimePeriod() -> TimePeriod? {
        guard self.periods.count > 0 else {
            return nil
        }
        
        let period = self.periods.first        
        
        self.periods.forEach { elem in
            elem.shiftEarlierWithSize(TimePeriodSize.Second, amount: Int(period!.durationInSeconds))
        }
        
        self.periods.removeFirst()
        
        return period
    }
    
    /**
        Compares given `TimePeriodChain` to the receiver and returns whether they are equal.
    
        - returns: true when chains are equal, false otherwise
    */
    public func isEqualToChain(chain: TimePeriodChain) -> Bool {
        if !self.hasSameCharacteristicsAs(chain) {
            return false
        }
        
        for (idx, period) in self.periods.enumerate() {
            if chain[idx] != period {
                return false
            }
        }
        
        return true
    }
    
    public override func copy() -> AnyObject {
        let chain = TimePeriodChain(calendar: self.calendar)
        for period in self.periods {
            chain.addTimePeriod(period)
        }
        return chain
    }
    
    private func updateVariables() {
        self.startDate = self.periods.first?.startDate
        self.endDate = self.periods.last?.endDate
    }
    
}

public func == (lhs: TimePeriodChain, rhs: TimePeriodChain) -> Bool {
    return lhs.isEqualToChain(rhs)
}

public func != (lhs: TimePeriodChain, rhs: TimePeriodChain) -> Bool {
    return !lhs.isEqualToChain(rhs)
}

