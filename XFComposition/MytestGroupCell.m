//
//  MytestGroupCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MytestGroupCell.h"

@implementation MytestGroupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt.frame = CGRectMake(20, 5, 30, 30);
        [self.bt setBackgroundImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateSelected];
        [self.bt addTarget:self action:@selector(clickgroup :) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.bt];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bt.frame)+10, 5, WidthFrame-40-80, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}
-(void)clickgroup :(UIButton *)bt{
    bt.selected = !bt.selected;
    if ([self.delegate respondsToSelector:@selector(xuanzhong:)]) {
        [self.delegate xuanzhong:bt];
    }
}
@end
