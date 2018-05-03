//
//  PostHeadview.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PostHeadview.h"

@implementation PostHeadview
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatheadView];
    }
    return self;
}
-(void)creatheadView{
    self.backgroundColor = [UIColor whiteColor];
//    UIView *headview = [[UIView alloc]init];
    self.imgView = [[UIImageView alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    self.timeLabel = [[UILabel alloc]init];
    self.xximgView = [[UIImageView alloc]init];
    self.txtLabel = [[UILabel alloc]init];
    self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *jglabel1 = [[UILabel alloc]init];
    UILabel *jglabel2 = [[UILabel alloc]init];
    
    UIView *hhlable1 = [[UILabel alloc]init];
    UIView *hhlable2 = [[UILabel alloc]init];
    
    UILabel *label1 = [[UILabel alloc]init];
    UILabel *label2 = [[UILabel alloc]init];
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    [self sd_addSubviews:@[self.imgView,self.titleLabel,self.timeLabel,self.xximgView,self.txtLabel,self.bt1,self.bt2,self.bt3,jglabel1,jglabel2,hhlable1,hhlable2,label1,label2,scrollview]];
//    [self addSubview:headview];
//    headview.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 20).rightSpaceToView(self, 0).autoHeightRatio(0);
//    headview.backgroundColor = [UIColor whiteColor];
    self.imgView.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self, 20).widthIs(40).heightIs(40);
    self.imgView.layer.cornerRadius = 20;
    self.imgView.layer.masksToBounds = YES;
    
    self.titleLabel.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self, 20).widthIs(100).heightIs(30);
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    
    self.timeLabel.sd_layout.leftSpaceToView(self.titleLabel, 20).topSpaceToView(self, 30).heightIs(15).widthIs(0);
    
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor lightGrayColor];
//    self.timeLabel.text = @"222";
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame/2 - 60];
    
    self.xximgView.sd_layout.leftEqualToView(self.titleLabel).topSpaceToView(self.titleLabel, 12).widthIs(WidthFrame-100).heightIs(2);
    self.xximgView.image = [UIImage imageNamed:@"xuxian"];
//    self.txtLabel.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.xximgView, 5).rightSpaceToView(self, 20).autoHeightRatio(0);
//    self.txtLabel.text = @"1233222";
    self.txtLabel.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.xximgView, 5).widthIs(WidthFrame-100).heightIs(40);
    
    self.bt1.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.txtLabel, 40).widthIs(WidthFrame/3).heightIs(30);
    [self.bt1 setTitle:@"测试" forState: UIControlStateNormal];
    [self.bt1 setImage:[UIImage imageNamed:@"icon_xiaoren00"] forState:UIControlStateNormal];
    [self.bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bt1.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bt1 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    jglabel1.sd_layout.leftSpaceToView(self.bt1, 0).topSpaceToView(self.txtLabel, 41).widthIs(2).heightIs(28);
    jglabel1.backgroundColor = [UIColor lightGrayColor];
    
    self.bt2.sd_layout.leftSpaceToView(jglabel1, 0).topSpaceToView(self.txtLabel, 40).widthIs(WidthFrame/3).heightIs(30);
    [self.bt2 setTitle:@"浏览" forState: UIControlStateNormal];
    [self.bt2 setImage:[UIImage imageNamed:@"icon_liulan"] forState:UIControlStateNormal];
    [self.bt2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bt2.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bt2 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    
    jglabel2.sd_layout.leftSpaceToView(self.bt2, 0).topSpaceToView(self.txtLabel, 41).widthIs(2).heightIs(28);
    jglabel2.backgroundColor = [UIColor lightGrayColor];
    
    self.bt3.sd_layout.leftSpaceToView(jglabel2, 0).topSpaceToView(self.txtLabel, 40).widthIs(WidthFrame/3).heightIs(30);
    [self.bt3 setTitle:@"评论" forState: UIControlStateNormal];
    [self.bt3 setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
    [self.bt3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.bt3.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bt3 setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.bt3.tag = 4000;
    [self.bt3 addTarget:self action:@selector(pinglun :) forControlEvents:UIControlEventTouchUpInside];
    
    hhlable1.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.bt3, 0).widthIs(WidthFrame).heightIs(5);
    hhlable1.backgroundColor = [UIColor colorWithHexString:@"E7F2FA"];
    
    label1.sd_layout.leftSpaceToView(self, 20).topSpaceToView(hhlable1, 3).widthIs(4).heightIs(46);
    label1.backgroundColor = [UIColor colorWithHexString:@"1941E2"];
    
    label2.sd_layout.leftSpaceToView(label1, 20).topSpaceToView(hhlable1, 3).widthIs(WidthFrame-60).heightIs(46);
    label2.text = @"话题讨论列表";
    label2.font = [UIFont systemFontOfSize:18];
    
    hhlable2.sd_layout.leftSpaceToView(self, 0).topSpaceToView(label1, 2).widthIs(WidthFrame).heightIs(5);
    hhlable2.backgroundColor = [UIColor colorWithHexString:@"E7F2FA"];
    
    scrollview.sd_layout.leftSpaceToView(self, 0).topSpaceToView(hhlable2, 0).widthIs(WidthFrame).heightIs(40);
    
    NSArray *array = @[@"默认",@"最新",@"最早",@"只看楼主"];
    for (int i = 0; i<array.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(0+WidthFrame/4*i, 0, WidthFrame/4, 40);
        bt.tag = 2000+i;
        [bt setTitle:array[i] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(clickpost :) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:bt];
        [self.btnArray addObject:bt];
        if (i == 0) {
            [bt setTitleColor:[UIColor colorWithHexString:@"4892E2"] forState:UIControlStateNormal];
        }
    }
    
    [self setupAutoHeightWithBottomView:scrollview bottomMargin:5];
    
    
}

-(void)pinglun :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(pingluntiezi)]) {
        [self.delegate pingluntiezi];
    }
    
}
-(void)clickpost:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(click :)]) {
        [self.delegate click:bt];
    }
    
}
@end
