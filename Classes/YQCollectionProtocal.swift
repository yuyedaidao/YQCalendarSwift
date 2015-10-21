//
//  YQCollectionProtocal.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/10/10.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import Foundation

@objc protocol YQCollectionProtocal {

    optional var beginningDate:NSDate? {get set}
    
    var numberOfSections:Int {get}
    func numberOfItemsInSection(section:Int) -> Int
}