//
//  VolunteerThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerThridCell.h"

@implementation VolunteerThridCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WidthFrame-20-20)/3, 80)];
        self.imgView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.imgView];
    }
    return self;
}
@end
