//
//  CustomDatePicker.h
//  PublicLetter
//
//  Created by jiangxiao on 15/6/8.
//  Copyright (c) 2015年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic)int year;
@property(nonatomic)int month;
@property(nonatomic)int day;

@end
