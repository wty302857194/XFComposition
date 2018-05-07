//
//  RealnameThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RealnameThridCell.h"

@implementation RealnameThridCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc]init];
        UILabel *label = [[UILabel alloc]init];
        [self.contentView sd_addSubviews:@[imgView,label]];
        
        
        imgView.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).heightIs(5).widthIs(5);
        imgView.image = [UIImage imageNamed:@"pic_star"];
        
        
        label.sd_layout.leftSpaceToView(imgView, 5).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(105);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"性别";
        label.font  = [UIFont systemFontOfSize:14];
        
    
        self.btArray = [[NSMutableArray alloc]init];
        NSArray *array = [NSArray array];
        array = @[@"男",@"女",@"保密"];
        for (int i =0; i<3; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(135+56*i, 12, 16, 16);
            bt.layer.cornerRadius = 8;
            bt.layer.masksToBounds = YES;
            bt.tag = 1000+i;
            [bt addTarget:self action:@selector(clicksex :) forControlEvents:UIControlEventTouchUpInside];
            bt.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:bt];
            [self.btArray addObject:bt];
            UILabel *sexLabel = [[UILabel alloc]init];
            sexLabel.frame = CGRectMake(155+56*i, 5, 40, 30);
            sexLabel.font = [UIFont systemFontOfSize:14];
            sexLabel.text = array[i];
            [self.contentView addSubview:sexLabel];
        }
        
        
    }
    return self;
}
-(void)clicksex :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(xuanSex :)]) {
        [self.delegate xuanSex:bt];
    }
}
@end
