//
//  ActiveHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveHeadView.h"

@implementation ActiveHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UILabel *backLabel = [[UILabel alloc]init];
        
        [self sd_addSubviews:@[self.imgView,self.label1,self.label2,self.label3,self.bt1]];
        self.imgView.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self, 20).widthIs(120).heightIs(80);
        [self.imgView addSubview:self.label4];
        self.label4.sd_layout.leftSpaceToView(self.imgView, 0).topSpaceToView(self.imgView, 60).widthIs(120).heightIs(20);
        self.label4.backgroundColor = [UIColor colorWithHexString:@"5A5A5A" alpha:0.8];
        self.label4.font = [UIFont systemFontOfSize:8];
        self.label4.textAlignment = NSTextAlignmentRight;
        self.label4.textColor = [UIColor whiteColor];
        
        self.label1.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self, 20).rightSpaceToView(self.bt1, 20).autoHeightRatio(0);
        self.label1.font = [UIFont systemFontOfSize:14];
        
        self.label2.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label1, 20).rightSpaceToView(self, 20).autoHeightRatio(0);
        self.label2.font = [UIFont systemFontOfSize:12];
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label2, 10).rightSpaceToView(self, 20).autoHeightRatio(0);
        self.label3.font = [UIFont systemFontOfSize:12];
        
        self.bt1.sd_layout.rightSpaceToView(self, 20).topSpaceToView(self, 20).widthIs(80).heightIs(30);
        self.bt1.layer.masksToBounds = YES;
        self.bt1.layer.cornerRadius = 4;
        [self.bt1 setTitle:@"正在进行" forState:UIControlStateNormal];
        [self.bt1 setTitleColor:[UIColor colorWithHexString:@"F3A832"] forState:UIControlStateNormal];
        self.bt1.layer.borderColor = [[UIColor colorWithHexString:@"F3A832"] CGColor];
        self.bt1.layer.borderWidth = 1;
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.bt1.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        backLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.label3, 10).widthIs(WidthFrame).heightIs(2);
        backLabel.backgroundColor = [UIColor lightGrayColor];
        [self setupAutoHeightWithBottomView:self.label3 bottomMargin:20];
    }
    return  self;
}

@end
