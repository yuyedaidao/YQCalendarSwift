//
//  ViewModel.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/28.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    var mode: YQCalendarMode = .Month {
        didSet {
            if mode == .Month {
                self.calendar = self.monthCalendar
            } else {
                self.calendar = self.weekCalendar
            }
        }
    }
    var monthCalendar: YQCalendar!
    var weekCalendar: YQCalendar!
    var calendar: YQCalendar!
    init(monthCalendar: YQCalendar, weekCalendar: YQCalendar) {
        super.init()
        self.monthCalendar = monthCalendar
        self.calendar = monthCalendar
        self.weekCalendar = weekCalendar
    }
    
}
