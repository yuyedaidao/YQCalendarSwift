//
//  YQCalendarConfigure.swift
//  YQCalendarSwift
//
//  Created by Wang on 15/10/21.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit
import SwiftDateTools

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
    //注意最小日期需要是某个月份的第一天
    var minDate:NSDate = NSDate.dateWithYear(1970, month: 1, day: 1, hour: 0, minute: 0, second: 0)
    var maxDate:NSDate = NSDate.dateWithYear(2099, month: 12, day: 31, hour: 0, minute: 0, second: 0)
    
    lazy var beginningDate: NSDate = {
        let week  = self.minDate.weekday
        switch self.firstDay{
        case .Monday:
            if(week == 1){//星期天的情况
                return self.minDate.dateByAddingTimeInterval(-6*WholeDay)
            }else{//非星期天的情况
                return self.minDate.dateByAddingTimeInterval(NSTimeInterval(-week+2)*WholeDay)
            }
            
        case .Sunday:
            return self.minDate.dateByAddingTimeInterval(NSTimeInterval(-week+1)*WholeDay)
        }
    }()
    
    private override init() {}
}
