//
//  YQCalendarWeekdayLabel.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/27.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

class YQCalendarWeekdayLabel: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var labels: [UILabel]!
    var mode: YQCalendarFirstDay = .Monday {
        didSet {
            for (index, value) in self.weekDayLabelTitles().enumerate() {
                self.labels[index].text = value
            }
        }
    }
    init(mode: YQCalendarFirstDay) {
        self.mode = mode
        super.init(frame: CGRectZero)
        self.prepareLabels()
    }
    init() {
        super.init(frame: CGRectZero)
        self.prepareLabels()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        self.prepareLabels()
    }

    func prepareLabels() {
        self.labels = [UILabel]()
        for (index, value) in self.weekDayLabelTitles().enumerate() {
            let label = UILabel()
            label.backgroundColor = self.backgroundColor
            label.textColor = UIColor.lightTextColor()
            label.textAlignment = .Center
            label.text = value
            label.tag = index
            self.labels.append(label)
            self.addSubview(label)
        }
    }
    
    func weekDayLabelTitles() -> [String] {
        if self.mode == .Monday {
            return ["一","二","三","四","五","六","日"]
        } else {
            return ["日","一","二","三","四","五","六"]
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let labels = self.labels {
            let width = floor(self.bounds.width / CGFloat(labels.count))
            for (index, label) in labels.enumerate() {
                label.frame = CGRectMake(width*CGFloat(index), 0, width, self.bounds.height)
            }
        }
    }
    

}
