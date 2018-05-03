//
//  MySecondTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MySecondTableViewCell.h"

@implementation MySecondTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView1 = [[UIImageView alloc]init];
        imgView1.image = [UIImage imageNamed:@"icon_jifen"];
        imgView1.size = CGSizeMake(15, 15);
        imgView1.center = CGPointMake(WidthFrame/4, 12.5);
//        imgView1.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:imgView1];
        
        UIImageView *imgView2 = [[UIImageView alloc]init];
        imgView2.image = [UIImage imageNamed:@"icon_xianfengbi"];
        imgView2.size = CGSizeMake(15, 15);
//        imgView2.backgroundColor = [UIColor blueColor];
        imgView2.center = CGPointMake(WidthFrame/4*3, 12.5);
        [self.contentView addSubview:imgView2];
        
        self.integralLabel = [[UILabel alloc]init];
        self.integralLabel.size = CGSizeMake(WidthFrame/2, 15);
        self.integralLabel.center = CGPointMake(WidthFrame/4, 27.5);
        self.integralLabel.text = @"积分：10";
        self.integralLabel.font = [UIFont systemFontOfSize:10];
        self.integralLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.integralLabel];
        
        self.coinLabel = [[UILabel alloc]init];
        self.coinLabel.size = CGSizeMake(WidthFrame/2, 15);
        self.coinLabel.center = CGPointMake(WidthFrame/4*3, 27.5);
        self.coinLabel.text = @"先锋币：15";
        self.coinLabel.font = [UIFont systemFontOfSize:10];
        self.coinLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.coinLabel];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
