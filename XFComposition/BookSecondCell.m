
//
//  BookSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookSecondCell.h"

@implementation BookSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"图书简介：";
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 5, WidthFrame-120, 100)];
        self.textView.layer.borderWidth = 0.5;
        self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textView.layer.cornerRadius = 6;
        self.textView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.textView];
        
    }
    return self;
}

@end
