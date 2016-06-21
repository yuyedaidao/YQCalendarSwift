//
//  YQCalendar.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/9/24.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit

let kCellIdentifier = "YQCalendarItem"

enum YQCalendarMode{
    case Week
    case Month
}

class YQCalendar: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    let collectionView:UICollectionView!
    var collectionModel:YQCollectionProtocal = YQMonthViewModel()
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
    
    override init(frame: CGRect) {
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        self.prepareCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(20, 20)
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        super.init(coder: aDecoder)
        self.prepareCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.size.width/CGFloat(kCalendarColumn)
        let height = self.frame.size.height/CGFloat(kCalendarRow)
        (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSizeMake(width,height)
    }
    
    /*handler*/
    func prepareCollectionView() {
        
        self.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: NSLayoutAttribute.Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        
        self.collectionView.registerClass(YQCollectionDayCell.classForCoder(), forCellWithReuseIdentifier: kCellIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.reloadData()
    }
    
    /*collection delegate*/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.collectionModel.numberOfSections
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionModel.numberOfItemsInSection(section);
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as YQCollectionDayCell
        
        return cell
    }
    

}
