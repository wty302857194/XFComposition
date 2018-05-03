//
//  ApplyActiveFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyActiveFristCell.h"

@implementation ApplyActiveFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        label.text = @"文章个数：";
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+10, 5, 50, 30)];
        self.textfield.layer.borderWidth = 0.5;
        self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textfield.font = [UIFont systemFontOfSize:12];
        self.textfield.minimumFontSize = 1;
        self.textfield.adjustsFontSizeToFitWidth= YES;
        self.textfield.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.textfield];
        
        
    }
    return self;
}

@end
