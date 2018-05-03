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
//        self.Textfield = [[UITextField alloc]init];
        
        
        [self.contentView sd_addSubviews:@[imgView,label]];
        
        
        label.sd_layout.rightSpaceToView(self.contentView, WidthFrame -120).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(0);
        label.text = @"性别：";
        
        label.textAlignment = NSTextAlignmentRight;;
        label.font  = [UIFont systemFontOfSize:14];
        [label setSingleLineAutoResizeWithMaxWidth:0];
        imgView.sd_layout.rightSpaceToView(label, 0).topSpaceToView(self.contentView, 15).heightIs(10).widthIs(10);
        imgView.backgroundColor = [UIColor lightGrayColor];
        
        self.btArray = [[NSMutableArray alloc]init];
        NSArray *array = [NSArray array];
        array = @[@"男",@"女",@"保密"];
        for (int i =0; i<3; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(120+56*i, 12, 16, 16);
            bt.layer.cornerRadius = 8;
            bt.layer.masksToBounds = YES;
            bt.tag = 1000+i;
            [bt addTarget:self action:@selector(clicksex :) forControlEvents:UIControlEventTouchUpInside];
            bt.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:bt];
            [self.btArray addObject:bt];
            UILabel *sexLabel = [[UILabel alloc]init];
            sexLabel.frame = CGRectMake(136+56*i, 5, 40, 30);
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
