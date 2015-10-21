//
//  YQMonthViewModel.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/10/10.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit

class YQMonthViewModel:NSObject,YQCollectionProtocal {
    //var beginningDate:NSDate?//并不会使用，只是为了符合protocal规范  //已用 @objc解决
    
    var numberOfSections:Int {
        let configure = YQCalendarConfigure.sharedInstance;
        //如果最大日期是该月的起点，该月仍然要显示完整的一月
        return (configure.maxDate.year-configure.minDate.year)*12+configure.maxDate.month-configure.minDate.month+1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return 7*6;
    }
}
