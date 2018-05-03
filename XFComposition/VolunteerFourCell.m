//
//  VolunteerFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerFourCell.h"

@implementation VolunteerFourCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/3-10, HeightFrame/6)];

        [self addSubview:self.imgView];
    }
    return self;
}
@end
