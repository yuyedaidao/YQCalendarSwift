//
//  YQCalendarFullCell.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/8/5.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

class YQCalendarFullCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
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
}
