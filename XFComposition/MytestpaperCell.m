//
//  MytestpaperCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MytestpaperCell.h"
@interface MytestpaperCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@end
@implementation MytestpaperCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.titleLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        UILabel *jgLable2 = [[UILabel alloc]init];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.label1,self.label2,self.bt1,self.bt2,self.bt3,bt4,jgLable1,jgLable2,bgimgView]];
        [self.contentView addSubview:backView];
        
        backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 2).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        backView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(backView, 10).heightIs(40).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame/3*2];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3995D1"];
        self.label2.sd_layout.rightSpaceToView(backView, 20).topSpaceToView(backView, 17).heightIs(30).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:18];
        self.label1.sd_layout.rightSpaceToView(self.label2, 3).topSpaceToView(backView, 20).heightIs(30).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.text = @"试卷总分";
        self.label1.textColor = [UIColor colorWithHexString:@"333333"];
        
        bgimgView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.label2, 5).widthIs(WidthFrame-40).heightIs(.5);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];
        
        CGFloat w = (WidthFrame-40)/3;
        
        self.bt1.sd_layout.leftSpaceToView(backView, 40).topSpaceToView(bgimgView, 15).widthIs(w-40).heightIs(30);
        [self.bt1 setBackgroundColor:[UIColor colorWithHexString:@"F19833"]];
        self.bt1.layer.cornerRadius = 4;
        self.bt1.layer.masksToBounds = YES;
        [self.bt1 setTitle:@"发布到圈子" forState:UIControlStateNormal];
        [self.bt1 addTarget:self action:@selector(fabu :) forControlEvents:UIControlEventTouchUpInside];
        [self.bt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:12];
        
        jgLable1.sd_layout.leftSpaceToView(backView, WidthFrame/3).topSpaceToView(bgimgView, 20).widthIs(.5).heightIs(20);
        jgLable1.backgroundColor = RGB_COLOR(229, 229, 229);
        
        self.bt2.sd_layout.leftSpaceToView(jgLable1, 20).topSpaceToView(bgimgView, 15).widthIs(w-40).heightIs(30);
        [self.bt2 setBackgroundColor:[UIColor colorWithHexString:@"009dff"]];
        self.bt2.layer.cornerRadius = 4;
        self.bt2.layer.masksToBounds = YES;
        [self.bt2 addTarget:self action:@selector(liulan :) forControlEvents:UIControlEventTouchUpInside];
        [self.bt2 setTitle:@"浏览" forState:UIControlStateNormal];
        [self.bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bt2.titleLabel.font = [UIFont systemFontOfSize:12];
        
        jgLable2.sd_layout.leftSpaceToView(backView, WidthFrame/3*2).topSpaceToView(bgimgView, 20).widthIs(.5).heightIs(20);
        jgLable2.backgroundColor = RGB_COLOR(229, 229, 229);
        self.bt3.sd_layout.leftSpaceToView(backView, WidthFrame/6*5 -10).topSpaceToView(bgimgView, 10).widthIs(20).heightIs(20);
        [self.bt3 setBackgroundImage:[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        [self.bt3 addTarget:self action:@selector(shanchu :) forControlEvents:UIControlEventTouchUpInside];
        
        bt4.sd_layout.leftSpaceToView(backView, WidthFrame/6*5 -20).topSpaceToView(self.bt3, 0).widthIs(40).heightIs(20);
        [bt4 setTitle:@"删除" forState:UIControlStateNormal];
        bt4.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt4 setTitleColor:[UIColor colorWithHexString:@"9A9B9A"] forState:UIControlStateNormal];
        
        [backView setupAutoHeightWithBottomView:bt4 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backView bottomMargin:5];
    }
    return self;
}
-(void)fabu :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(lookit:)]) {
        [self.delegate lookit:bt];
    }
    
}
-(void)liulan :(UIButton *)bt{
    
    if ([self.delegate respondsToSelector:@selector(browse:)]) {
        [self.delegate browse:bt];
    }
    
}
-(void)shanchu :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(delecttest :)]) {
        [self.delegate delecttest:bt];
    }

}

-(void)setModel:(MyPageListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.PageTitle];
    self.label2.text = [NSString stringWithFormat:@"%ld",(long)_model.PageAllScore];
}
@end
