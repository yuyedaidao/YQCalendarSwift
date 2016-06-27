//
//  ViewController.swift
//  YQCalendarSwift
//
//  Created by 王叶庆 on 15/9/24.
//  Copyright © 2015年 王叶庆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calendar: YQCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically
        self.calendar.mode = .Week
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendar.scrollTo(NSDate(), animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

