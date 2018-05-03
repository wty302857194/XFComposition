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
        [self.contentView addSubview:self.imgView];
        
        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:self.label];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.contentView, 15).heightIs(30);
        [self.label setSingleLineAutoResizeWithMaxWidth:0];
        
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
