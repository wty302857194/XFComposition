//
//  MywritingCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MywritingCell.h"

@implementation MywritingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.label1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        self.label6 = [[UILabel alloc]init];
        self.label7 = [[UILabel alloc]init];
        UILabel *label8 = [[UILabel alloc]init];
        UILabel *label9 = [[UILabel alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt4 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt5 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        UIImageView *imgView = [[UIImageView alloc]init];
        UILabel *jglabel1 = [[UILabel alloc]init];
        UILabel *jglabel2 = [[UILabel alloc]init];
        UILabel *jglabel3 = [[UILabel alloc]init];
        
        [backView sd_addSubviews:@[self.label1,self.label2,self.label3,self.label4,self.label5,self.label6,self.label7,label8,label9,self.bt1,self.bt2,self.bt3,self.bt4,self.bt5,imgView,jglabel1,jglabel2,jglabel3]];
        
        [self.contentView addSubview:backView];
        
        backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 2).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        backView.backgroundColor = [UIColor whiteColor];
        self.bt1.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(backView, 10).widthIs(20).heightIs(20);
        [self.bt1 addTarget:self action:@selector(xz :) forControlEvents:UIControlEventTouchUpInside];
//        [self.bt1 setImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
//        [self.bt1 setImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateSelected];
        self.bt1.layer.cornerRadius = 10;
        self.bt1.layer.masksToBounds = YES;
        self.bt1.backgroundColor = [UIColor lightGrayColor];
        
        self.label1.sd_layout.leftSpaceToView(self.bt1, 10).topSpaceToView(backView, 10).rightSpaceToView(backView, 20).heightIs(30);
        [self.label1 addTarget:self action:@selector(showView :) forControlEvents:UIControlEventTouchUpInside];
        self.label1.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.label1 setTitleColor:[UIColor colorWithHexString:@"3D9CD4"] forState:UIControlStateNormal];

    
        self.label2.sd_layout.leftSpaceToView(self.bt1, 10).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);

        [self label:self.label2 :@"45A3C6"];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label3.sd_layout.leftSpaceToView(self.label2, 5).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        [self label:self.label3 :@"3691CE"];
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label4.sd_layout.leftSpaceToView(self.label3, 5).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        [self label:self.label4 :@"88ABD9"];
        [self.label4 setSingleLineAutoResizeWithMaxWidth:0];
        self.label5.sd_layout.leftSpaceToView(self.label4, 5).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        [self label:self.label5 :@"84CCC8"];
        [self.label5 setSingleLineAutoResizeWithMaxWidth:0];
        
//        imgView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.label2, 60).widthIs(WidthFrame-20).heightIs(2);
        imgView.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(self.label2, 4).widthIs(WidthFrame-20).heightIs(2);
        imgView.image = [UIImage imageNamed:@"xuxian"];
//        imgView.backgroundColor = [UIColor lightGrayColor];
        
        CGFloat w1 = (WidthFrame -20)/4;

        
        self.bt2.sd_layout.leftSpaceToView(backView, w1/2).topSpaceToView(imgView, 5).widthIs(20).heightIs(20);
        [self.bt2 setImage:[UIImage imageNamed:@"icon_liulan"] forState:UIControlStateNormal];
        self.label6.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(self.bt2, 0).widthIs(w1).heightIs(20);
        self.label6.textAlignment = NSTextAlignmentCenter;
        
        jglabel1.sd_layout.leftSpaceToView(self.label6, 0).topSpaceToView(imgView, 2).widthIs(2).heightIs(46);
        jglabel1.backgroundColor = [UIColor lightGrayColor];
        
        self.bt3.sd_layout.leftSpaceToView(jglabel1, w1/2-10).topSpaceToView(imgView, 5).widthIs(20).heightIs(20);
        [self.bt3 setImage:[UIImage imageNamed:@"icon_fenxiang"] forState:UIControlStateNormal];
        self.label7.sd_layout.leftSpaceToView(jglabel1, 0).topSpaceToView(self.bt3, 0).widthIs(w1).heightIs(20);
        self.label7.textAlignment = NSTextAlignmentCenter;
        
        jglabel2.sd_layout.leftSpaceToView(self.label7, 0).topSpaceToView(imgView, 2).widthIs(2).heightIs(46);
        jglabel2.backgroundColor = [UIColor lightGrayColor];
        
        self.bt4.sd_layout.leftSpaceToView(jglabel2, w1/2-10).topSpaceToView(imgView, 5).widthIs(20).heightIs(20);
        [self.bt4 addTarget:self action:@selector(xiugai :) forControlEvents:UIControlEventTouchUpInside];
        [self.bt4 setImage:[UIImage imageNamed:@"icon_xiugai"] forState:UIControlStateNormal];
        label8.sd_layout.leftSpaceToView(jglabel2, 0).topSpaceToView(self.bt4, 0).widthIs(w1).heightIs(20);
        label8.textAlignment = NSTextAlignmentCenter;
        label8.font = [UIFont systemFontOfSize:10];
        label8.text = @"修改";
        
        jglabel3.sd_layout.leftSpaceToView(label8, 0).topSpaceToView(imgView, 2).widthIs(2).heightIs(46);
        jglabel3.backgroundColor = [UIColor lightGrayColor];
        self.bt5.sd_layout.leftSpaceToView(jglabel3, w1/2-10).topSpaceToView(imgView, 5).widthIs(20).heightIs(20);
        [self.bt5 addTarget:self action:@selector(shanchu :) forControlEvents:UIControlEventTouchUpInside];
        [self.bt5 setImage:[UIImage imageNamed:@"icon_shanchu"] forState:UIControlStateNormal];
        label9.sd_layout.leftSpaceToView(jglabel3, 0).topSpaceToView(self.bt5, 0).widthIs(w1).heightIs(20);
        label9.textAlignment = NSTextAlignmentCenter;
        label9.text = @"删除";
        label9.font = [UIFont systemFontOfSize:10];
        
        [backView setupAutoHeightWithBottomView:label9 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backView bottomMargin:5];
        
    }
    return self;

}
-(void)xz :(UIButton *)bt{
//    bt.selected = !bt.selected;
    if ([self.delegate respondsToSelector:@selector(xuanzhong:)]) {
        [self.delegate xuanzhong:bt];
    }
    
}
-(void)showView :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(showContent:)]) {
        [self.delegate showContent:bt];
    }

}
-(void)xiugai :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(modify:)]) {
        [self.delegate modify:bt];
    }

}
-(void)shanchu :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:bt];
    }
    
}

-(void)setModel:(MywritingModel *)model{
    _model = model;
    if ([_model.BlogTitle isEqualToString:@""]) {
        
        [self.label1 setTitle:@"暂无" forState:UIControlStateNormal];
    }else{
        [self.label1 setTitle:_model.BlogTitle forState:UIControlStateNormal];
        
    }
    self.label2.text = @"微课习作";
    if ([_model.BlogStatic integerValue] == 0) {
        self.label3.text = @"可编辑";
    }else{
        self.label3.text = @"不可编辑";
        
    }
    if ([_model.BlogIsHost integerValue] == 0) {
        self.label4.text = @"热点";
    }else{
        
        self.label4.text = @"非热点";
    }
    
    if ([_model.BlogIsTuijian integerValue] == 0) {
        self.label5.text = @"推荐";
    }else{
        self.label5.text = @"不推荐";
    }
    
    
    self.label6.text = [NSString stringWithFormat:@"%@",_model.BlogViewTimes];
    self.label7.text = [NSString stringWithFormat:@"%@",_model.PyNum];
}

-(void)label :(UILabel *)label :(NSString *)str{
    label.font = [UIFont systemFontOfSize:13];
    label.layer.cornerRadius = 4;
    label.layer.masksToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithHexString:str];
    
    
}
@end
