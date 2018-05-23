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
        self.bt.frame = CGRectMake(20, (44 - 14)/2, 14, 14);
        [self.bt setBackgroundImage:[UIImage imageNamed:@"xf_quadrate"] forState:UIControlStateNormal];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"xf_quadrate_p"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.bt];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.bt.frame)+10, 0, WidthFrame-40-80, 44)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = hexColor(333333);
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}
@end
