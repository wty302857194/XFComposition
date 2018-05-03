//
//  ActiveotherCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveotherCell.h"

@implementation ActiveotherCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.bt.frame = CGRectMake(20, 10, WidthFrame-40, 30);
        self.bt.layer.masksToBounds = YES;
        self.bt.layer.cornerRadius = 4;
        [self.bt setTitle:@"我要投稿" forState:UIControlStateNormal];
        [self.bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.bt];
    }
    return self;
}

@end
