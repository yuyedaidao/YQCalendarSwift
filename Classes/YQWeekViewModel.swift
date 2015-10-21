//
//  YQWeekViewModel.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/10/10.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit

class YQWeekViewModel:NSObject,YQCollectionProtocal {
    var beginningDate:NSDate?
    var cacheNumberOfItems:Int?
    
    // yqcollection protocal
    var numberOfSections:Int {
        return 1
    }
    func numberOfItemsInSection(section: Int) -> Int {
        if cacheNumberOfItems == nil{
            let configure = YQCalendarConfigure.sharedInstance
            //先判断当前月份第一天是星期几，然后得出最小开始日期
            let week  = configure.minDate.weekday
            switch configure.firstDay{
            case .Monday:
                if(week == 1){//星期天的情况
                    self.beginningDate = configure.minDate.dateByAddingTimeInterval(-6*WholeDay)
                }else{//非星期天的情况
                    self.beginningDate = configure.minDate.dateByAddingTimeInterval(NSTimeInterval(-week+2)*WholeDay)
                }
                
            case .Sunday:
                self.beginningDate = configure.minDate.dateByAddingTimeInterval(NSTimeInterval(-week+1)*WholeDay)
            }
            cacheNumberOfItems = Int((configure.maxDate.timeIntervalSince1970-self.beginningDate!.timeIntervalSince1970)/NSTimeInterval(WholeDay*7));
        }
        
        return self.cacheNumberOfItems!
    }
}
