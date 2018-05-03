//
//  BookThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookThridCell.h"

@implementation BookThridCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"图书简介：";
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        
        self.shangchuanbt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shangchuanbt.frame = CGRectMake(100, 5, 60, 60);
        self.shangchuanbt.layer.borderWidth = 0.5;
        self.shangchuanbt.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.shangchuanbt.layer.cornerRadius = 6;
        self.shangchuanbt.layer.masksToBounds = YES;
        [self.shangchuanbt setTitle:@"上传封面" forState:UIControlStateNormal];
        self.shangchuanbt.titleLabel.font  = [UIFont systemFontOfSize:10];
        [self.shangchuanbt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.shangchuanbt];
        
        UILabel *jglabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, WidthFrame-100, 20)];
        jglabel.font = [UIFont systemFontOfSize:10];
        jglabel.text = @"*支持jpg、jpeg、png、gif格式，文件大小在1M以内";
        jglabel.textColor = [UIColor redColor];
        [self.contentView addSubview:jglabel];
    }
    return self;
}
-(void)click{
    
    if ([self.delegate respondsToSelector:@selector(Uppic)]) {
        [self.delegate Uppic];
    }
}
@end
