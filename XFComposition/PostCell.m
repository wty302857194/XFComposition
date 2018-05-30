//
//  PostCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PostCell.h"
@interface PostCell()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;


@property (nonatomic,strong)UILabel *labelbt;
@end
@implementation PostCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.louLabel = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.labelbt = [[UILabel alloc]init];
        [self.contentView sd_addSubviews:@[self.imgView,self.label1,self.label2,self.label3,self.louLabel,self.bt]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).widthIs(36).heightIs(36);
        self.imgView.layer.cornerRadius = 18;
        self.imgView.layer.masksToBounds = YES;
        self.label1.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 20).heightIs(20).widthIs(0);
        
        self.label1.font = [UIFont systemFontOfSize:14];
        self.label1.textColor = [UIColor colorWithHexString:@"63C0F2"];
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label2.sd_layout.leftSpaceToView(self.label1, 20).topSpaceToView(self.contentView, 20).heightIs(20).widthIs(0);
        
        self.label2.font = [UIFont systemFontOfSize:14];
        self.label2.textColor = [UIColor lightGrayColor];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:WidthFrame-100];
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label2, 20).rightSpaceToView(self.contentView, 100).autoHeightRatio(0);
        self.label3.font = [UIFont systemFontOfSize:14];
//        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.louLabel.sd_layout.rightSpaceToView(self.contentView, 10).topEqualToView(self.label1).heightIs(20).widthIs(0);
        
        self.louLabel.font = [UIFont systemFontOfSize:14];
        [self.louLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.louLabel.textColor = [UIColor colorWithHexString:@"EEB3C4"];
        
        self.bt.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 23).heightIs(10).widthIs(80);
        self.bt.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.bt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.bt addTarget:self action:@selector(clickmy :) forControlEvents:UIControlEventTouchUpInside];
        [self setupAutoHeightWithBottomView:self.label3 bottomMargin:10];
    }
    return self;
}
-(void)clickmy :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(clickMyps:)]) {
        [self.delegate clickMyps:bt];
    }
    
}
-(void)setModel:(GetTitleCommentModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    self.label1.text = _model.UserName;
    self.label2.text = _model.AddTime;
    self.label3.text = [NSString stringWithFormat:@"%@", _model.CommentInfo];
    [self.bt setTitle:[NSString stringWithFormat:@"回复（%lu）",(unsigned long)_model.backInfo.count] forState:UIControlStateNormal];
    
}
@end
