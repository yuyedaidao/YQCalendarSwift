//
//  YQCalendarDayCell.swift
//  YQCalendarSwift
//
//  Created by Wang on 16/6/21.
//  Copyright © 2016年 王叶庆. All rights reserved.
//

import UIKit

class YQCalendarDayCell: UICollectionViewCell {
    var model: YQDayModel! {
        didSet {
            if oldValue != model {
                switch model.dateType {
                case .PreMonth,.NextMonth:
                    self.label.textColor = UIColor.lightTextColor()
                case .CurrentMoth:
                    self.label.textColor = UIColor.whiteColor()
                case .Today:
                    self.label.textColor = UIColor.redColor()
                }
                print(self.model.date)
                self.label.text = "\(model.date.day)"
            }
        }
    }
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareViews()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
    
    func prepareViews() {
        self.label = UILabel()
        self.label.textAlignment = .Center
        self.addSubview(self.label)
    }
}
