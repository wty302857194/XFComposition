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
        imgView1.size = CGSizeMake(30, 30);
        imgView1.center = CGPointMake(WidthFrame/4, 25);
//        imgView1.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:imgView1];
        
        UIImageView *imgView2 = [[UIImageView alloc]init];
        imgView2.image = [UIImage imageNamed:@"icon_xianfengbi"];
        imgView2.size = CGSizeMake(30, 30);
//        imgView2.backgroundColor = [UIColor blueColor];
        imgView2.center = CGPointMake(WidthFrame/4*3, 25);
        [self.contentView addSubview:imgView2];
        
        self.integralLabel = [[UILabel alloc]init];
        self.integralLabel.size = CGSizeMake(WidthFrame/2, 15);
        self.integralLabel.center = CGPointMake(WidthFrame/4, 50);
        self.integralLabel.text = @"积分：10";
        self.integralLabel.font = [UIFont systemFontOfSize:10];
        self.integralLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.integralLabel];
        
        self.coinLabel = [[UILabel alloc]init];
        self.coinLabel.size = CGSizeMake(WidthFrame/2, 15);
        self.coinLabel.center = CGPointMake(WidthFrame/4*3, 50);
        self.coinLabel.text = @"先锋币：15";
        self.coinLabel.font = [UIFont systemFontOfSize:10];
        self.coinLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.coinLabel];
        
        if (!self.lineLabel) {
            self.lineLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.lineLabel];
        }
        self.lineLabel.sd_layout.bottomSpaceToView(self.contentView, 1).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
        self.lineLabel.backgroundColor = UIColorFromRGB(0xd9d9d9);
        
        if (!self.VlineLabel) {
            self.VlineLabel = [[UILabel alloc] init];
            [self.contentView addSubview:self.VlineLabel];
        }
    self.VlineLabel.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView(self.contentView).heightIs(65).widthIs(1);
        self.VlineLabel.backgroundColor = UIColorFromRGB(0xd9d9d9);
        
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
