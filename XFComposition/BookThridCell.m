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
        label.text = @"图书封面：";
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        
        
        
        self.shangchuanbt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shangchuanbt.frame = CGRectMake(100, 5, 60, 60);
        [self.shangchuanbt setBackgroundImage:[UIImage imageNamed:@"add_photo_Img"] forState:UIControlStateNormal];
        [self.shangchuanbt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.shangchuanbt];
        
        self.addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addImgBtn.backgroundColor = hexColor(3691CE);
        self.addImgBtn.layer.cornerRadius = 5;
        [self.addImgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [self.addImgBtn setTitle:@"上传封面" forState:UIControlStateNormal];
        self.addImgBtn.titleLabel.font  = [UIFont systemFontOfSize:14];
        [self.addImgBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addImgBtn];
        [self.addImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shangchuanbt.mas_right).offset(10);
            make.centerY.equalTo(self.shangchuanbt.mas_centerY);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
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
