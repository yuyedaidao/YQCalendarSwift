//
//  YQCalendarFullCell.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/8/5.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

protocol YQCalendarFullCellDelegate {
    func yq_scrollViewWillBeginDragging(scrollView: UIScrollView)
    func yq_scrollViewDidScroll(scrollView: UIScrollView)
    func yq_scrollViewDidEndDecelerating(scrollView: UIScrollView)
    func yq_scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func yq_scrollViewDidEndScrollingAnimation(scrollView: UIScrollView)
}

class YQCalendarFullCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: YQCalendarFullCellDelegate?
    override func awakeFromNib() {
//        self.tableView.bounces = false
        self.tableView.scrollEnabled = false
        self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)

    }
    
    func panGesture(gesture: UIPanGestureRecognizer) {
        print("hello")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(arc4random() % 100)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell))
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: String(UITableViewCell))
        }
        cell!.backgroundColor = UIColor(red: CGFloat(arc4random() % 255)/255, green: CGFloat(arc4random() % 255)/255, blue: CGFloat(arc4random() % 255)/255, alpha: 1)
        cell!.selectionStyle = .None
        return cell!
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        delegate?.yq_scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.yq_scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        delegate?.yq_scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.yq_scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        delegate?.yq_scrollViewDidEndScrollingAnimation(scrollView)
    }
    
}
