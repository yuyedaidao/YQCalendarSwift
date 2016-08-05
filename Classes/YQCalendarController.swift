//
//  YQCalendarController.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/8/5.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

private let kCalendarContentTop: CGFloat = 200.0
private let kOffsetY: CGFloat = 80.0
private let kCalendarMaxHeight: CGFloat = 200.0
private let kCalendarMinHeight: CGFloat = floor(kCalendarMaxHeight/CGFloat(kCalendarRow))

private let reuseIdentifier = "YQCalendarFullCell"

class YQCalendarController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    var calendarWeekdayLabel: YQCalendarWeekdayLabel!
    var monthCalendar: YQCalendar!
    var monthCalendarContainer: UIView!
    var weekCalendar: YQCalendar!
    var originalY: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.monthCalendarContainer = UIView()
        self.monthCalendarContainer.frame = CGRectMake(0, 0, self.view.bounds.width, kCalendarMaxHeight)
//        self.view.addSubview(self.monthCalendarContainer)
        self.monthCalendarContainer.clipsToBounds = true
        self.monthCalendar = YQCalendar(frame: self.monthCalendarContainer.bounds)
        self.monthCalendarContainer.addSubview(self.monthCalendar)
        
        self.weekCalendar = YQCalendar(frame: CGRectMake(0, self.monthCalendarContainer.frame.minY,self.view.bounds.width, kCalendarMinHeight))
        self.weekCalendar.mode = .Week

        let layout = self.collectionViewLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.view.bounds.width,height: self.view.bounds.height-64);
        layout.scrollDirection = .Horizontal
        self.collectionView?.pagingEnabled = true
        self.collectionView?.bounces = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weekCalendar.collectionModel.numberOfItemsInSection(0)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(arc4random() % 255)/255, green: CGFloat(arc4random() % 255)/255, blue: CGFloat(arc4random() % 255)/255, alpha: 1)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
