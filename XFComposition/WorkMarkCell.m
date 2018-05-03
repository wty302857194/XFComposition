//
//  WorkMarkCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WorkMarkCell.h"
@interface WorkMarkCell()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;

@end
@implementation WorkMarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.titleLabel = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        UILabel *jgLable1 = [[UILabel alloc]init];
        UILabel *jgLable2 = [[UILabel alloc]init];
        UIImageView *bgimgView = [[UIImageView alloc]init];
        
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView *backView = [[UIImageView alloc]init];
        [backView sd_addSubviews:@[self.titleLabel,self.label3,self.label4,self.bt,jgLable1,jgLable2,bgimgView]];
        [self.contentView addSubview:backView];
        backView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
//        backView.backgroundColor = [UIColor whiteColor];
        backView.image = [UIImage imageNamed: @"bg_dashubiji"];
        backView.userInteractionEnabled = YES;
        
        self.titleLabel.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(backView, 10).rightSpaceToView(backView, 0).autoHeightRatio(0);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"3995D1"];
        
        bgimgView.sd_layout.leftSpaceToView(backView, 20).topSpaceToView(self.titleLabel, 20).widthIs(WidthFrame-80).heightIs(2);
        bgimgView.image = [UIImage imageNamed:@"xuxian"];
        
        CGFloat w = (WidthFrame-40)/3;
        
        self.label3.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(bgimgView, 3).widthIs(w).heightIs(40);
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.font = [UIFont systemFontOfSize:14];
        self.label3.textColor = [UIColor colorWithHexString:@"8A8D8D"];
        
        jgLable1.sd_layout.leftSpaceToView(self.label3, 0).topSpaceToView(bgimgView, 3).widthIs(1).heightIs(40);
        jgLable1.backgroundColor = [UIColor lightGrayColor];
        self.label4.sd_layout.leftSpaceToView(jgLable1, 0).topSpaceToView(bgimgView, 3).widthIs(w).heightIs(40);
        self.label4.textAlignment = NSTextAlignmentCenter;
        self.label4.font = [UIFont systemFontOfSize:14];
        self.label4.textColor = [UIColor colorWithHexString:@"8A8D8D"];
        jgLable2.sd_layout.leftSpaceToView(self.label4, 0).topSpaceToView(bgimgView, 3).widthIs(1).heightIs(40);
        jgLable2.backgroundColor = [UIColor lightGrayColor];
        
        self.bt.sd_layout.leftSpaceToView(jgLable2, 20).topSpaceToView(bgimgView, 10).widthIs(w-40).heightIs(20);
        [self.bt addTarget:self action:@selector(dp :) forControlEvents:UIControlEventTouchUpInside];
        self.bt.layer.cornerRadius = 4;
        [self.bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bt.layer.masksToBounds = YES;
        self.bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [backView setupAutoHeightWithBottomView:self.label3 bottomMargin:2];
        [self setupAutoHeightWithBottomView:backView bottomMargin:3];
    }
    return self;
}
-(void)dp :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(dianping :)]) {
        [self.delegate dianping:bt];
    }
}

-(void)setModel:(GetTeachNeedCheckListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.WorkName];
    if ([_model.IsCheck integerValue] == 0) {
        self.label3.text = @"未点评";
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"358ECD"]];
        [self.bt setTitle:@"点评习作" forState:UIControlStateNormal];
        self.bt.enabled = YES;
    }else {
        self.label3.text = @"已点评";
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"BEBFBE"]];
        self.bt.enabled = NO;
        [self.bt setTitle:@"已点评" forState:UIControlStateNormal];
    }
    if ([_model.Isback integerValue] == 0) {
        self.label4.text = @"未评审";
    }else{
        self.label4.text = @"已评审.优秀";
    }
}
@end
