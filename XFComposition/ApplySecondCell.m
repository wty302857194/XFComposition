//
//  ApplySecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplySecondCell.h"

@implementation ApplySecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.bt.frame = CGRectMake(WidthFrame/2-100, 10, 200, 120);
        [self.bt setBackgroundColor:[UIColor lightGrayColor]];

        [self.contentView addSubview:self.bt];
    }
    return self;
}

@end
