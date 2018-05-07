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
        [self.contentView sd_addSubviews:@[self.imgView,self.label,self.label2]];
        
        
        
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
        
        
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(WidthFrame-20-10, 5 , 20, 30)];;
        img2.image = [UIImage imageNamed:@"right-arrow-"];
        [self.contentView addSubview:img2];
        
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
