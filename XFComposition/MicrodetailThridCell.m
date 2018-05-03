//
//  MicrodetailThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailThridCell.h"

@implementation MicrodetailThridCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/3-15, HeightFrame/8)];
        self.imageView.image = [UIImage imageNamed:@"Mic01"];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame/8, WidthFrame/3-15, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"《写作技巧》";
        [self addSubview:self.titleLabel];
        
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, HeightFrame/8+20, 20, 20)];
        imgview.image = [UIImage imageNamed:@"icon_liulan"];
        [self addSubview:imgview];
        
        self.liulanLabel = [[UILabel alloc]init];
        [self addSubview:self.liulanLabel];
        self.liulanLabel.sd_layout.leftSpaceToView(imgview, 2).topSpaceToView(self.titleLabel, 5).heightIs(20);
        [self.liulanLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.liulanLabel.text = @"32浏览";
        self.liulanLabel.font = [UIFont systemFontOfSize:9];
        
        self.canyuLabel = [[UILabel alloc]init];
        [self addSubview:self.canyuLabel];
        self.canyuLabel.sd_layout.leftSpaceToView(self.liulanLabel, 0).topSpaceToView(self.titleLabel, 5).heightIs(20);
        [self.canyuLabel setSingleLineAutoResizeWithMaxWidth:0];
//        self.canyuLabel.text =@"8674参与";
        self.canyuLabel.font = [UIFont systemFontOfSize:9];
        
        
    }
    return self;
}
@end
