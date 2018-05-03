//
//  PostbackmyCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PostbackmyCell.h"
@interface PostbackmyCell()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
@implementation PostbackmyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *backview = [[UIView alloc]init];
        self.imgView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        [backview sd_addSubviews:@[self.imgView,self.label1,self.label2,self.label3]];
        [self.contentView addSubview:backview];
        backview.sd_layout.leftSpaceToView(self.contentView, 66).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10);
        backview.backgroundColor = [UIColor colorWithHexString:@"E4E9E9"];
        
        self.imgView.sd_layout.leftSpaceToView(backview, 20).topSpaceToView(backview, 20).widthIs(36).heightIs(36);
        self.imgView.layer.cornerRadius = 18;
        self.imgView.layer.masksToBounds = YES;
        self.label1.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(backview, 20).heightIs(20).widthIs(0);

        self.label1.font = [UIFont systemFontOfSize:14];
        self.label1.textColor = [UIColor colorWithHexString:@"63C0F2"];
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        
        self.label2.sd_layout.leftSpaceToView(self.label1, 20).topSpaceToView(backview, 20).heightIs(20).widthIs(0);
        
        self.label2.font = [UIFont systemFontOfSize:14];
        self.label2.textColor = [UIColor lightGrayColor];
        [self.label2 setSingleLineAutoResizeWithMaxWidth:WidthFrame-100];
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label2, 20).rightSpaceToView(backview, 10).autoHeightRatio(0);
        self.label3.font = [UIFont systemFontOfSize:14];
        [backview setupAutoHeightWithBottomView:self.label3 bottomMargin:2];
        [self setupAutoHeightWithBottomView:backview bottomMargin:2];
    }
    return self;
}
-(void)setModel:(GetTitleBackinfoModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.label1.text = _model.UserName;
    self.label2.text = _model.AddTime;
    self.label3.text = [NSString stringWithFormat:@"%@", _model.CommentInfo];
}
@end
