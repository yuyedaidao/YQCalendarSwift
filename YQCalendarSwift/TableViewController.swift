//
//  TableViewController.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/27.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit
let kCalendarContentTop: CGFloat = 200.0
let kCalendarMaxHeight: CGFloat = 200.0
let kCalendarMinHeight: CGFloat = floor(kCalendarMaxHeight/CGFloat(kCalendarRow))
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var calendarWeekdayLabel: YQCalendarWeekdayLabel!
    var monthCalendar: YQCalendar!
    var monthCalendarContainer: UIView!
    var weekCalendar: YQCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarWeekdayLabel = YQCalendarWeekdayLabel(mode: .Monday)
        self.calendarWeekdayLabel.frame = CGRectMake(0, 20, self.view.bounds.width, 30)
        self.monthCalendar = YQCalendar(frame: CGRectMake(0,50,self.view.bounds.size.width,kCalendarContentTop))
        self.tableView = UITableView(frame: CGRectMake(0, kCalendarContentTop, self.view.bounds.size.width, self.view.bounds.size.height-kCalendarContentTop), style: UITableViewStyle.Plain)
        self.tableView.rowHeight = 60;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        self.view.addSubview(self.calendarWeekdayLabel)
        self.view.addSubview(self.monthCalendar)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delaysContentTouches = true
        self.tableView.scrollEnabled = false
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.view.addGestureRecognizer(pan)
    }

    //Mark:: handler
    func panAction(gesture: UIPanGestureRecognizer) {
        print(gesture.locationInView(self.view))
        print(gesture.velocityInView(self.view))
    }
    // Mark:: table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
