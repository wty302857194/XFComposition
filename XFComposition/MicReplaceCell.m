//
//  MicReplaceCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicReplaceCell.h"

@implementation MicReplaceCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WidthFrame-40, 40)];
        self.alterLabel.text = @"暂无数据";
        self.alterLabel.font = [UIFont systemFontOfSize:12];
        self.alterLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.alterLabel];
    }
    return self;
}
@end
