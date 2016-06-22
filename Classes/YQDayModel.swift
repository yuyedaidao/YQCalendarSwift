//
//  YQDayModel.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/20.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit
import SwiftDateTools

enum YQDateType {
    case CurrentMoth
    case Today
    case PreMonth //previous
    case NextMonth
}

class YQDayModel: NSObject {
    var dateType: YQDateType = .CurrentMoth
    var month: NSDate
    var date: NSDate {
        didSet {
            print("hello, everybody")
            if date < month {
                self.dateType = .PreMonth
            } else if date > month.endOfMonth {
                self.dateType = .NextMonth
            } else if date == NSDate.today() {
                self.dateType = .Today
            }
            print(self.dateType)
        }
    }
    init(indexPath: NSIndexPath, mode: YQCalendarMode, firstDay: YQCalendarFirstDay) {
        
        //先获取月份第一天再根据月份的第一天是星期几判断当前日期
        self.month = YQCalendarConfigure.sharedInstance.minDate.dateByAddingMonths(indexPath.section)//这就是月份的第一天的日期，因为最小日期是某个月份的第一天
        if mode == .Month {
            //先变换坐标
            let column = indexPath.item / kCalendarRow
            let row = indexPath.item % kCalendarRow
            let index = row * kCalendarColumn + column
            var offset = month.weekday - 1
            if firstDay == .Monday {
                if month.weekday == 1 {
                    offset = 6
                } else {
                    offset = month.weekday - 2
                }
            }
            self.date = month.dateByAddingDays(index-offset)
        } else { //mode == .Week
            self.date = YQCalendarConfigure.sharedInstance.beginningDate.dateByAddingDays(indexPath.item)
        }
        super.init()
    }
}
