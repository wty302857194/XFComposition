//
//  ReadnineCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadnineCell.h"

@implementation ReadnineCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor colorWithHexString:@"ABD498"];
        [self.contentView addSubview:label];
    
    }
    
    return self;
}

@end
