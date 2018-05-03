//
//  TakenotesCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "TakenotesCell.h"
@interface TakenotesCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;

@end
@implementation TakenotesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        UILabel *jgLable2 = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        UIView *backView = [[UIView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.timeLabel,self.label1,self.label2,self.label3,self.label4,self.bt,jgLable1,jgLable2,bgimgView]];
        [self.contentView addSubview:backView];
        backView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 2).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        backView.backgroundColor = [UIColor whiteColor];
        self.titleLabel.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(backView, 10).heightIs(40).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame-40];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3995D1"];
        self.timeLabel.sd_layout.rightSpaceToView(backView, 20).topSpaceToView(self.titleLabel, 5).heightIs(20).widthIs(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        
        bgimgView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.timeLabel, 5).widthIs(WidthFrame-40).heightIs(2);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];

        CGFloat w = (WidthFrame-40)/3;
        self.label1.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(bgimgView, 5).widthIs(w).heightIs(30);
        self.label1.font = [UIFont systemFontOfSize:18];
        self.label1.textAlignment = NSTextAlignmentCenter;
        jgLable1.sd_layout.leftSpaceToView(self.label1, 0).topSpaceToView(bgimgView, 5).widthIs(1).heightIs(50);
        jgLable1.backgroundColor = [UIColor lightGrayColor];
        self.label3.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.label1, 0).widthIs(w).heightIs(20);
        self.label3.font = [UIFont systemFontOfSize:12];
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label2.sd_layout.leftSpaceToView(jgLable1, 0).topSpaceToView(bgimgView, 5).widthIs(w).heightIs(30);
        self.label2.textColor = [UIColor redColor];
        self.label2.font = [UIFont systemFontOfSize:16];
        self.label2.textAlignment = NSTextAlignmentCenter;
        jgLable2.sd_layout.leftSpaceToView(self.label2, 0).topSpaceToView(bgimgView, 5).widthIs(1).heightIs(50);
        jgLable2.backgroundColor = [UIColor lightGrayColor];
        
        self.label4.sd_layout.leftSpaceToView(jgLable1, 0).topSpaceToView(self.label2, 0).widthIs(w).heightIs(20);
        self.label4.textAlignment = NSTextAlignmentCenter;
        self.label4.font = [UIFont systemFontOfSize:12];
        self.bt.sd_layout.leftSpaceToView(jgLable2, 20).topSpaceToView(bgimgView, 20).widthIs(w-40).heightIs(30);
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3690CE"]];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.bt.layer.cornerRadius = 6;
        [self.bt addTarget:self action:@selector(ck:) forControlEvents:UIControlEventTouchUpInside];
        self.bt.layer.masksToBounds = YES;
        [self.bt setTitle:@"查看记录" forState:UIControlStateNormal];
        
        [backView setupAutoHeightWithBottomView:self.label3 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backView bottomMargin:2];
        
    }
    return  self;
}
-(void)ck:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(chakan :)]) {
        [self.delegate chakan:bt];
    }
    
}
-(void)setModel:(GetPageListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_model.Attribute2];
    self.timeLabel.text = _model.addtime;
    self.label1.text = [NSString stringWithFormat:@"%@",_model.allsocre];
    if (_model.allsocre <_model.testOkSocre) {
        self.label2.text = @"不合格";
    }else{
        self.label2.text = @"合格";
    }
    self.label3.text = @"获得分数";
    self.label4.text = @"合格分数";

}
@end
