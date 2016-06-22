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

    var collectionView:UICollectionView!
    var collectionModel:YQCollectionProtocal = YQMonthViewModel()
    var collectionLayout: UICollectionViewFlowLayout!
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
        super.init(frame: frame)
        self.prepareCollectionView()
    }
    required init?(coder aDecoder: NSCoder) {
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
        self.collectionLayout = UICollectionViewFlowLayout()
        self.collectionLayout.minimumLineSpacing = 0
        self.collectionLayout.minimumInteritemSpacing = 0
        self.collectionLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.collectionLayout)
        self.collectionView.pagingEnabled = true
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: NSLayoutAttribute.Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        
        self.collectionView.registerClass(YQCalendarDayCell.classForCoder(), forCellWithReuseIdentifier: kCellIdentifier)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as! YQCalendarDayCell
        cell.model = YQDayModel(indexPath: indexPath, mode: self.mode, firstDay: YQCalendarConfigure.sharedInstance.firstDay)
//        cell.backgroundColor = UIColor(colorLiteralRed: Float(random()%255)/255.0, green: Float(random()%255)/255.0, blue: Float(random()%255)/255.0, alpha: 1)
        return cell
    }
    

}
