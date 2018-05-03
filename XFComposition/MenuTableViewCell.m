//
//  MenuTableViewCell.m
//  HuiBlockmenu
//
//  Created by 周凤喜 on 2017/7/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MenuTableViewCell.h"
@interface MenuTableViewCell()

@end
@implementation MenuTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle=UITableViewCellSelectionStyleNone;
//        _label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)+2, CGRectGetMaxY(self.frame)+2, WidthFrame/5-5, 25)];
        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        _label.sd_layout.leftSpaceToView(self.contentView, 3).topSpaceToView(self.contentView, 3).rightSpaceToView(self.contentView, 3).bottomSpaceToView(self.contentView, 3);
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.layer.cornerRadius = 4;
        _label.layer.masksToBounds = YES;
        
//        [self.contentView addSubview:self.label];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label.frame)+1, WidthFrame, 1)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:lineLabel];
    }
    return self;
}

-(void)setStr:(NSString *)str{
    _str =str ;
    _label.text = str;

}
@end
