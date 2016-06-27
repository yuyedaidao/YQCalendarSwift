//
//  YQWeekViewModel.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/10/10.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit
import SwiftDateTools

class YQWeekViewModel:NSObject,YQCollectionProtocal {
    lazy var numberOfItems:Int = {
        let configure = YQCalendarConfigure.sharedInstance
        return Int((configure.maxDate.timeIntervalSince1970-configure.beginningDate.timeIntervalSince1970)/NSTimeInterval(WholeDay))
    }()
    
    // yqcollection protocal
    var numberOfSections:Int {
        return 1
    }
    func numberOfItemsInSection(section: Int) -> Int {
        return self.numberOfItems
    }
}
