//
//  YQCalendarConfigure.swift
//  YQCalendarSwift
//
//  Created by Wang on 15/10/21.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit
import Timepiece

let kCalendarRow = 6
let kCalendarColumn = 7

enum YQCalendarFirstDay{
    case Monday
    case Sunday
}

let WholeDay:NSTimeInterval = 24*60*60

class YQCalendarConfigure: NSObject {
    static let sharedInstance = YQCalendarConfigure()
    static let dateFormater = NSDateFormatter();
    static let calendar = NSCalendar.currentCalendar()
    
    var firstDay:YQCalendarFirstDay = YQCalendarFirstDay.Monday
    var minDate:NSDate = NSDate(timeIntervalSince1970: 0)
    var maxDate:NSDate = "2099-12-31".dateFromFormat("yyyy-MM-dd")!
    
    private override init() {}
}
