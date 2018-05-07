//
//  MyThridTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyThridTableViewCell.h"
@interface MyThridTableViewCell ()

@end
@implementation MyThridTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
        self.label = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.lineLabel = [[UILabel alloc] init];
        [self.contentView sd_addSubviews:@[self.imgView,self.label,self.label2,self.lineLabel]];
        
        
        
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.sd_layout.leftSpaceToView(self.imgView, 20).centerYEqualToView(self.contentView).heightIs(30);
        [self.label setSingleLineAutoResizeWithMaxWidth:0];
        
        
        self.label2.sd_layout.leftSpaceToView(self.label, 20).centerYEqualToView(self.label).heightIs(20).widthIs(20);
        self.label2.layer.cornerRadius = 10;
        self.label2.layer.masksToBounds = YES;
        self.label2.textColor = [UIColor whiteColor];
        self.label2.backgroundColor = [UIColor redColor];
        self.label2.textAlignment = NSTextAlignmentCenter;
        [self.label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];//加粗
        
        
        UIImageView *img2 = [[UIImageView alloc]init];
        [self.contentView addSubview:img2];
        img2.sd_layout.centerYEqualToView(self.label).rightSpaceToView(self.contentView, 20).widthIs(22).heightIs(22);
        img2.image = [UIImage imageNamed:@"right-arrow-"];
        
        
        
        self.lineLabel.sd_layout.bottomSpaceToView(self.contentView, 1).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
        self.lineLabel.backgroundColor = UIColorFromRGB(0xd9d9d9);
        
        
        
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
