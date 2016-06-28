//
//  TableViewController.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/27.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit
let kCalendarContentTop: CGFloat = 200.0
let kOffsetY: CGFloat = 80.0
let kCalendarMaxHeight: CGFloat = 200.0
let kCalendarMinHeight: CGFloat = floor(kCalendarMaxHeight/CGFloat(kCalendarRow))
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var calendarWeekdayLabel: YQCalendarWeekdayLabel!
    var monthCalendar: YQCalendar!
    var monthCalendarContainer: UIView!
    var weekCalendar: YQCalendar!
    var viewModel: ViewModel!
    var originalY: CGFloat = 0
    var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarWeekdayLabel = YQCalendarWeekdayLabel(mode: .Monday)
        self.calendarWeekdayLabel.frame = CGRectMake(0, 20, self.view.bounds.width, 30)
        
        self.monthCalendarContainer = UIView()
        self.monthCalendarContainer.frame = CGRectMake(0, CGRectGetMaxY(self.calendarWeekdayLabel.frame), self.view.bounds.width, kCalendarMaxHeight)
        self.monthCalendarContainer.clipsToBounds = true
        self.monthCalendar = YQCalendar(frame: self.monthCalendarContainer.bounds)
        self.monthCalendarContainer.addSubview(self.monthCalendar)
        
        self.weekCalendar = YQCalendar(frame: CGRectMake(0, self.monthCalendarContainer.frame.minY,self.view.bounds.width, kCalendarMinHeight))
        self.weekCalendar.mode = .Week
        
        self.tableView = YQTableView(frame: CGRectMake(0, CGRectGetMaxY(self.monthCalendarContainer.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.monthCalendarContainer.frame)), style: UITableViewStyle.Plain)
        self.tableView.rowHeight = 60;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delaysContentTouches = true
//        self.tableView.scrollEnabled = false
        
        self.view.addSubview(self.calendarWeekdayLabel)
        self.view.addSubview(self.monthCalendarContainer)
        self.view.addSubview(self.weekCalendar)
        self.view.addSubview(self.tableView)
        
        self.weekCalendar.hidden = true
        self.viewModel = ViewModel(monthCalendar: self.monthCalendar, weekCalendar: weekCalendar)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.view.addGestureRecognizer(pan)
        self.panGesture = pan
    }

    //Mark:: handler
    func panAction(gesture: UIPanGestureRecognizer) {
//        print(gesture.locationInView(self.view))
//        print(gesture.velocityInView(self.view))
        let point = gesture.translationInView(self.view)
        switch gesture.state {
        case .Began:
            self.originalY = self.tableView.frame.minY
        case .Changed:
            var tFrame = self.tableView.frame
            tFrame.origin.y += point.y
            if abs(tFrame.minY - self.originalY) > kOffsetY {
                gesture.enabled = false
            } else {
                tFrame.size.height -= point.y
                var mFrame = self.monthCalendar.frame
                mFrame.origin.y += point.y
                self.tableView.frame = tFrame
                self.monthCalendar.frame = mFrame
                gesture.setTranslation(CGPointZero, inView: self.view)
            }
            
        case .Cancelled, .Failed:
            print("cancel or failed: \(gesture.state.rawValue)")
            var tFrame = self.tableView.frame
            tFrame.origin.y += point.y
            if abs(tFrame.minY - self.originalY) > kOffsetY {
                if self.viewModel.mode == .Month {
                    self.changeModeTo(.Week)
                } else {
                    self.changeModeTo(.Month)
                }
            } else {
                self.changeModeTo(self.viewModel.mode)
            }
            
            
        case .Ended:
            print("end")
            var tFrame = self.tableView.frame
            tFrame.origin.y += point.y
            if abs(tFrame.minY - self.originalY) > kOffsetY {
                if self.viewModel.mode == .Month {
                    self.changeModeTo(.Week)
                } else {
                    self.changeModeTo(.Month)
                }
            } else {
                self.changeModeTo(self.viewModel.mode)
            }

        default: break
            
        }
        
    }
    
    func changeModeTo(mode: YQCalendarMode) {
        if mode == .Month {
            UIView.animateWithDuration(0.25, animations: {
                self.monthCalendar.frame = self.monthCalendarContainer.bounds
                self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.monthCalendarContainer.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.monthCalendarContainer.frame))
                }, completion:{ (finish) in
                    self.panGesture.enabled = true
            } )
        } else {
            UIView.animateWithDuration(0.25, animations: {
                self.monthCalendar.frame = self.monthCalendarContainer.bounds
                self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.weekCalendar.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.weekCalendar.frame))
                }, completion: { (finish) in
                    self.panGesture.enabled = true
            })
        }
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
