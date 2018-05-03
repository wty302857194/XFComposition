//
//  WedpCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WedpCell.h"
@interface WedpCell()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;

@end
@implementation WedpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        UIView *backview = [[UIView alloc]init];
        [backview sd_addSubviews:@[self.label1,self.label2,self.label3,self.label4,self.label5]];
        backview.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:backview];
        backview.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).autoHeightRatio(0);
        
        self.label1.sd_layout.leftSpaceToView(backview, 20).topSpaceToView(backview, 20).heightIs(20).widthIs(0);
        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        self.label1.textColor = [UIColor colorWithHexString:@"5AABDA"];
        [self.label1 setSingleLineAutoResizeWithMaxWidth:WidthFrame-40];
        
        self.label2.sd_layout.leftSpaceToView(backview, 20).topSpaceToView(self.label1, 10).heightIs(20).widthIs(0);
        self.label2.font = [UIFont systemFontOfSize:14];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:WidthFrame/2-20];
        
        self.label3.sd_layout.leftSpaceToView(backview, 20).topSpaceToView(self.label2, 10).heightIs(20).widthIs(0);
        self.label3.font = [UIFont systemFontOfSize:14];
        [self.label3 setSingleLineAutoResizeWithMaxWidth:WidthFrame-40];
        
        self.label4.sd_layout.leftSpaceToView(backview, 20).topSpaceToView(self.label3, 10).heightIs(20).widthIs(0);
        self.label4.font = [UIFont systemFontOfSize:13];
        [self.label4 setSingleLineAutoResizeWithMaxWidth:WidthFrame-40];
        
        self.label5.sd_layout.rightSpaceToView(backview, 20).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        self.label5.font = [UIFont systemFontOfSize:14];
        [self.label5 setSingleLineAutoResizeWithMaxWidth:WidthFrame/2-20];
        [backview setupAutoHeightWithBottomView:self.label4 bottomMargin:5];
        [self setupAutoHeightWithBottomView:backview bottomMargin:2];
    }
    return self;
}
-(void)setModel:(DianPingModel *)model{
    _model = model;
    self.label1.text = _model.title;
    self.label2.text = [NSString stringWithFormat:@"作者：%@",_model.username];
    self.label3.text = [NSString stringWithFormat:@"活动：%@",_model.activename];
    self.label4.text = [NSString stringWithFormat:@"批阅时间：%@",_model.checktime];
    self.label5.text = [NSString stringWithFormat:@"批阅老师：%@",_model.checkname];
}
@end
