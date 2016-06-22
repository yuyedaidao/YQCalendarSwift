//
//  TimePeriodCollection.swift
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

public class TimePeriodCollection: NSObject, TimePeriodGroup {
    
    /**
       The start date of `TimePeriodCollection` representing the earliest date of TimePeriod objects.
     */
    public var startDate: NSDate?
    
    /**
       The end date of `TimePeriodCollection` representing the latest date of TimePeriod objects.
     */
    public var endDate: NSDate?
    
    internal(set) var periods: [TimePeriod] = [] {
        didSet {
            self.updateVariables()
        }
    }
    
    internal(set) var calendar: NSCalendar
    
    /**
       Initializes an instance of `TimePeriodCollection` using given calendar
    
       - parameter calendar: Calendar used for date calculations, defaults to `NSCalendar.currentCalendar()`
    
     */
    public init(calendar: NSCalendar = NSCalendar.currentCalendar()) {
        self.calendar = calendar
        super.init()
    }
    
    /**
        Appends given `TimePeriod` object to `TimePeriodCollection`
    
        - parameter timePeriod: `TimePeriod` object that will be added to collection
     */
    public func addTimePeriod(timePeriod: TimePeriod) {
            self.periods.append(timePeriod)
    }
    
    /**
        Inserts given `TimePeriod` object at given index
    
        - parameter timePeriod: `TimePeriod` object that will be inserted to collection
        - parameter index: index at which object will be inserted
    */
    public func insertTimePeriod(timePeriod: TimePeriod, atIndex index: Int) {
        guard index >= 0 && index <= self.periods.count else {
            return
        }
        
        self.periods.insert(timePeriod, atIndex: index)
    }
    
    /**
        Removes `TimePeriod` at given index from collection
    
        - parameter index: index of a `TimePeriod` object in collection
    
        - returns: `Optional(TimePeriod)` removed from the chain, `nil` object is not found
    */
    public func removeTimePeriod(atIndex index: Int) -> TimePeriod? {
        guard index >= 0 && index < self.periods.count else {
            return nil
        }
        
        let period = self.periods[index]
        self.periods.removeAtIndex(index)
        
        return period
    }
    
    /**
        Sorts collection by `startDate` in ascending order
    */
    public func sortByStartAscending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.startDate < rhs.startDate
        }
    }
    
    /**
        Sorts collection by `startDate` in descending order
    */
    public func sortByStartDescending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.startDate > rhs.startDate
        }
    }
    
    /**
        Sorts collection by `endDate` in ascending order
    */
    public func sortByEndAscending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.endDate < rhs.endDate
        }
    }
    
    /**
        Sorts collection by `endDate` in descending order
    */
    public func sortByEndDescending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.endDate > rhs.endDate
        }
    }
    
    /**
        Sorts collection by `TimePeriod` duration in ascending order
    */
    public func sortByDurationAscending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.durationInSeconds < rhs.durationInSeconds
        }
    }
    
    /**
        Sorts collection by `TimePeriod` duration in descending order
    */
    public func sortByDurationDescending() {
        self.periods.sortInPlace { (lhs, rhs) -> Bool in
            return lhs.durationInSeconds > rhs.durationInSeconds
        }
    }
    
    /**
        - parameter timePeriod: `TimePeriod` to check collection against
    
        - returns: `TimePeriodCollection` containing `TimePeriod` objects that are inside of given `TimePeriod`
    */
    public func periodsInside(period: TimePeriod) -> TimePeriodCollection {
        return self.periodsWithRelationToPeriod(period, relation: TimePeriod.isInside)
    }
    
    /**
        - parameter date: date to check collection against
    
        - returns: `TimePeriodCollection` containing `TimePeriod` objects that intersect given date
    */
    public func periodsIntersectedByDate(date: NSDate) -> TimePeriodCollection {
        let collection = TimePeriodCollection(calendar: self.calendar)
        
        self.periods.forEach { elem in
            if elem.containsDate(date, interval: TimePeriodInterval.Closed) {
                collection.addTimePeriod(elem)
            }
        }
        
        return collection
    }
    
    /**
        - parameter timePeriod: `TimePeriod` to match collection against
    
        - returns: `TimePeriodCollection` containing `TimePeriod` objects that intersect given `TimePeriod`
    */
    public func periodsIntersectedByPeriod(period: TimePeriod) -> TimePeriodCollection {
        return self.periodsWithRelationToPeriod(period, relation: TimePeriod.intersects)
    }

    /**
        - parameter timePeriod: `TimePeriod` to match collection against
    
        - returns: `TimePeriodCollection` containing `TimePeriod` objects that are overlapped by given `TimePeriod`. This covers all space they share, minus instantaneous space (i.e. one's start date equals another's end date)
    */
    public func periodsOverlappedByPeriod(period: TimePeriod) -> TimePeriodCollection {
        return self.periodsWithRelationToPeriod(period, relation: TimePeriod.overlapsWith)
    }
    
    /**
        Compares given `TimePeriodCollection` to the receiver and returns whether they are equal. Comparison can be done with order considering or without.
    
        - parameter collection: `TimePeriodCollection` object to compare to receiver
        - parameter considerOrder: Is order considered during comparison
    
        - returns: true when collections are equal, false otherwise
    */
    public func isEqualToCollection(collection: TimePeriodCollection, considerOrder: Bool = false) -> Bool {
        if !self.hasSameCharacteristicsAs(collection) {
            return false
        }
        
        if considerOrder {
            return self.isEqualToCollectionConsideringOrder(collection)
        } else {
            return self.isEqualToCollectionNotConsideringOrder(collection)
        } 
    }
    
    public override func copy() -> AnyObject {
        let collection = TimePeriodCollection(calendar: self.calendar)
        for period in self.periods {
            collection.addTimePeriod(period)
        }
        return collection
    }
    
    //MARK: - Private
    
    private func isEqualToCollectionConsideringOrder(collection: TimePeriodCollection) -> Bool {
        for (idx, period) in self.periods.enumerate() {
            if collection[idx] != period {
                return false
            }
        }
        return true
    }
    
    private func isEqualToCollectionNotConsideringOrder(collection: TimePeriodCollection) -> Bool {
        for period in self.periods {
            if collection.periods.filter({ elem -> Bool in
                return elem == period
            }).count == 0 {
                return false
            }
        }
        return true
    }
    
    private func periodsWithRelationToPeriod(period: TimePeriod, relation: TimePeriod -> TimePeriod -> Bool) -> TimePeriodCollection {
        let collection = TimePeriodCollection(calendar: self.calendar)
        
        self.periods.forEach { elem in
            if relation(elem)(period) {
                collection.addTimePeriod(elem)
            }
        }
        
        return collection
    }
    
    private func updateVariables() {
        self.startDate = NSDate.distantFuture()
        self.endDate = NSDate.distantPast()
        
        for period in self.periods {
            if self.startDate! > period.startDate {
                self.startDate = period.startDate
            }
            if self.endDate! < period.endDate {
                self.endDate = period.endDate
            }
        }
        if self.periods.isEmpty {
            self.startDate = nil
            self.endDate = nil
        }
    }
}

public func == (lhs: TimePeriodCollection, rhs: TimePeriodCollection) -> Bool {
    return lhs.isEqualToCollection(rhs)
}

public func != (lhs: TimePeriodCollection, rhs: TimePeriodCollection) -> Bool {
    return !lhs.isEqualToCollection(rhs)
}
