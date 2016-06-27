//
//  YQCalendarSwiftTests.swift
//  YQCalendarSwiftTests
//
//  Created by 王叶庆 on 15/9/24.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import XCTest
@testable import YQCalendarSwift

class YQCalendarSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //var yqcalendar = YQCalendar(frame: CGRectZero)
        let date = NSDate.dateWithYear(2016, month: 6, day: 22, hour: 0, minute: 0, second: 0)
        for index in 0...13 {
            let d = date.dateByAddingDays(index)
            print("weekDay is \(d.weekday)")
        }
    
    }
    
    func testWeeksFrom() {
        let date = NSDate.dateWithYear(2016, month: 6, day: 22, hour: 0, minute: 0, second: 0)
        for index in 0...13 {
            let d = date.dateByAddingDays(index)
            let duration = NSCalendar.currentCalendar().weeksFrom(d, toDate: date)
            print(duration)
        }
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
