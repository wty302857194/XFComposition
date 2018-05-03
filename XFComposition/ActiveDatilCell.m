//
//  ActiveDatilCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveDatilCell.h"
@interface ActiveDatilCell()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;

@end
@implementation ActiveDatilCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView sd_addSubviews:@[self.label1,self.label2,self.label3,self.label4,self.label5,self.bt]];
        self.label1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).heightIs(30).widthIs(0);
        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];//加粗
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label2.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.label1, 20).heightIs(20).widthIs(0);
        self.label2.font = [UIFont systemFontOfSize:14];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label3.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.label2, 20).heightIs(20).widthIs(0);
        self.label3.font = [UIFont systemFontOfSize:14];
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label4.sd_layout.leftSpaceToView(self.label3, 20).topSpaceToView(self.label1, 20).heightIs(20).widthIs(0);
        self.label4.font = [UIFont systemFontOfSize:14];
        [self.label4 setSingleLineAutoResizeWithMaxWidth:0];
        
        
        self.bt.sd_layout.rightSpaceToView(self.contentView, 20).bottomSpaceToView(self.contentView, 20).heightIs(30).widthIs(80);
        self.bt.layer.masksToBounds = YES;
        self.bt.layer.cornerRadius = 4;
        self.bt.backgroundColor = [UIColor colorWithHexString:@"3791CD"];
        [self.bt setTitle:@"我要投稿" forState:UIControlStateNormal];
        [self.bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.bt addTarget:self action:@selector(tougao:) forControlEvents:UIControlEventTouchUpInside];
        [self setupAutoHeightWithBottomView:self.label3 bottomMargin:10];
        
    }
    return self;
}
-(void)tougao:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(click:)]) {
        [self.delegate click:bt];
    }
    
}
-(void)setModel:(ActiveDatilThridModel *)model{
    _model = model;
    self.label1.text = _model.name;
    self.label2.text = [NSString stringWithFormat:@"所有投稿：%@",_model.allcount];
    self.label3.text = [NSString stringWithFormat:@"征文时间："];
    self.label4.text = [NSString stringWithFormat:@"入围作品：%@",_model.rukucount];
}
-(void)setModel2:(ActiveDatilSecondModel *)model2{
    _model2 = model2;
    self.label1.text = _model2.name;
    self.label2.text = [NSString stringWithFormat:@"所有投稿：%@",_model2.allcount];
    self.label3.text = [NSString stringWithFormat:@"征文时间："];
    self.label4.text = [NSString stringWithFormat:@"入围作品：%@",_model2.rukucount];
}
@end
