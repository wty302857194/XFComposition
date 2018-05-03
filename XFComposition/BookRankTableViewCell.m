//
//  BookRankTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookRankTableViewCell.h"
@interface BookRankTableViewCell()

@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
@implementation BookRankTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.numLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        
        [self.contentView sd_addSubviews:@[self.imgView,self.numLabel,self.label1,self.label2,self.label3]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(20);
        self.numLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(20);
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        self.numLabel.font = [UIFont systemFontOfSize:12];
        
        self.label1.sd_layout.leftSpaceToView(self.numLabel, 20).topSpaceToView(self.contentView, 10).widthIs(0).heightIs(20);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:120];
        self.label1.font = [UIFont systemFontOfSize:14];
        
        
        self.label2.sd_layout.leftSpaceToView(self.contentView, WidthFrame/5*2).topSpaceToView(self.contentView, 10).rightSpaceToView(self.label3, 20).autoHeightRatio(0);
        self.label2.font = [UIFont systemFontOfSize:14];
        self.label2.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        self.label3.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(20);
        self.label3.font = [UIFont systemFontOfSize:14];
        [self.label3 setSingleLineAutoResizeWithMaxWidth:120];
        self.label3.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        [self setupAutoHeightWithBottomView:self.label2 bottomMargin:10];
        
    }
    return self;
}
-(void)setModel:(GetReadStartModel *)model{
    _model = model;
    self.label1.text = [NSString stringWithFormat:@"%@",_model.readpaihangid];
    self.label2.text = [NSString stringWithFormat:@"学校：%@",_model.conname];
    self.label3.text = [NSString stringWithFormat:@"阅读数：%@",_model.num];
    
}
@end
