//
//  YQCalendar.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/9/24.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit

enum YQCalendarMode{
    case Week
    case Month
}

class YQCalendar: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    /*
    
    */
    var collectionModel:YQCollectionProtocal = YQMonthViewModel();
    var mode:YQCalendarMode = .Month {
        didSet{
            switch(mode){
                case .Month:
                    self.collectionModel = YQMonthViewModel()
                case .Week:
                    self.collectionModel = YQWeekViewModel()
            }
        }
    }
//    let minDate:NSDate = NSCalendar
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.collectionModel.numberOfSections
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier("YQCalendarItem", forIndexPath: indexPath);
        return cell
    }
    
    
    
    
    

}
