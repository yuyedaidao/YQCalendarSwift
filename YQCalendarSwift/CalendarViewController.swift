//
//  CalendarViewController.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/8/5.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let calendarController = UIStoryboard(name: "YQCalendar", bundle: nil).instantiateInitialViewController()!
        calendarController.willMoveToParentViewController(self)
        self.view.addSubview(calendarController.view)
        calendarController.view.frame = self.view.bounds
        self.addChildViewController(calendarController)
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
