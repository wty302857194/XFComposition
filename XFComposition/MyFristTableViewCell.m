//
//  MyFristTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyFristTableViewCell.h"

@implementation MyFristTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 120)];
        backImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:backImageView];
        
        self.photoImageView = [[UIImageView alloc]init];
        self.photoImageView.size =CGSizeMake(70, 70);

        self.photoImageView.center = CGPointMake(WidthFrame/2, 45);
        self.photoImageView.layer.cornerRadius = 35;
        self.photoImageView.clipsToBounds = YES;
        self.photoImageView.backgroundColor = [UIColor yellowColor];
//        self.photoImageView.image = [UIImage imageNamed:@""];
        [backImageView addSubview:self.photoImageView];
        
        self.label = [[UILabel alloc]init];
        [backImageView addSubview:self.label];
        self.label.size = CGSizeMake(WidthFrame, 20);
        self.label.center =CGPointMake(WidthFrame/2, 100);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:13];
//        self.label.text = @"我读书我快乐";
        
//        self.sexLabel = [[UILabel alloc]init];
//        [backImageView addSubview:self.sexLabel];
//        self.sexLabel.sd_layout.leftSpaceToView(self.label, 5).topEqualToView(self.label).heightIs(20);
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
