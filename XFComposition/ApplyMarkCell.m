//
//  ApplyMarkCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyMarkCell.h"
@interface ApplyMarkCell ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;


@end
@implementation ApplyMarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        UILabel *jgLable2 = [[UILabel alloc]init];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *backView = [[UIView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.timeLabel,self.label1,self.label2,self.label3,self.label4,self.label5,self.bt,jgLable1,jgLable2,bgimgView]];
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
        
        self.label1.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.titleLabel, 5).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label1.layer.cornerRadius =4;
        self.label1.layer.masksToBounds =YES;
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.backgroundColor = [UIColor colorWithHexString:@"2FC598"];
        self.label1.textColor = [UIColor whiteColor];
        self.label2.sd_layout.leftSpaceToView(self.label1, 5).topSpaceToView(self.titleLabel, 5).heightIs(20).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.layer.cornerRadius =4;
        self.label2.layer.masksToBounds =YES;
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.backgroundColor = [UIColor colorWithHexString:@"3690CE"];
        self.label2.textColor = [UIColor whiteColor];
        bgimgView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.label1, 5).widthIs(WidthFrame-40).heightIs(2);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];
        CGFloat w = (WidthFrame-40)/3;
        
        self.label3.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.label1, 10).widthIs(w).heightIs(40);
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.font = [UIFont systemFontOfSize:14];
        
        jgLable1.sd_layout.leftSpaceToView(self.label3, 0).topSpaceToView(self.label1, 10).widthIs(1).heightIs(40);
        jgLable1.backgroundColor = [UIColor lightGrayColor];
        self.label4.sd_layout.leftSpaceToView(jgLable1, 0).topSpaceToView(self.label1, 10).widthIs(w).heightIs(40);
        self.label4.textAlignment = NSTextAlignmentCenter;
        self.label4.font = [UIFont systemFontOfSize:14];
        jgLable2.sd_layout.leftSpaceToView(self.label4, 0).topSpaceToView(self.label1, 10).widthIs(1).heightIs(40);
        jgLable2.backgroundColor = [UIColor lightGrayColor];
        self.bt.sd_layout.leftSpaceToView(jgLable2, 10).topSpaceToView(self.label1, 20).widthIs(20).heightIs(20);
        [self.bt addTarget:self action:@selector(click :) forControlEvents:UIControlEventTouchUpInside];
        
        self.label5.sd_layout.leftSpaceToView(self.bt, 5).topSpaceToView(self.label1, 10).widthIs(w-37).heightIs(40);
        self.label5.textAlignment = NSTextAlignmentCenter;
        self.label5.font = [UIFont systemFontOfSize:14];
        [backView setupAutoHeightWithBottomView:self.label4 bottomMargin:2];
        
        [self setupAutoHeightWithBottomView:backView bottomMargin:2];
    }
    return self;
}
-(void)click :(UIButton *)bt{
//    [bt setBackgroundImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateNormal];
//    bt.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(Thanks :)]) {
        [self.delegate Thanks:bt];
    }
    
}
-(void)setModel:(GetMyActiveWorkListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.BlogTitle];
    self.timeLabel.text = _model.AddTime;
    self.label1.text = @"自由投稿";
    self.label2.text = _model.WriteCheckStatic;
    if ([_model.IsCheck intValue] == 0) {
        self.label3.text = @"未点评";
        self.label3.textColor = [UIColor colorWithHexString:@"7C7F7F"];
    }else {
        
        self.label3.text = @"已点评";
        self.label3.textColor = [UIColor blackColor];
    }
    if([_model.SocreInfo intValue] == 0){
        self.label4.text = @"未评审";
        self.label4.textColor = [UIColor colorWithHexString:@"7C7F7F"];

    }else if ([_model.SocreInfo intValue] == 1){
        self.label4.text = @"已评审 优秀";
        self.label4.textColor = [UIColor blackColor];
    }else if ([_model.SocreInfo intValue] == 2){
        self.label4.text = @"已评审 良好";
        self.label4.textColor = [UIColor blackColor];
    }else if ([_model.SocreInfo intValue] == 3){
        self.label4.text = @"已评审 一般";
        self.label4.textColor = [UIColor blackColor];
    }
    if ([_model.IsDx intValue] == -1) {
        self.label5.text = @"答谢点评";
        self.label5.textColor = [UIColor colorWithHexString:@"7C7F7F"];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
        self.bt.enabled = YES;

    }else{
        self.label5.text = @"已经答谢";
        self.label5.textColor = [UIColor blackColor];
        [self.bt setBackgroundImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateNormal];
        self.bt.enabled = NO;
    }
    

}

@end
