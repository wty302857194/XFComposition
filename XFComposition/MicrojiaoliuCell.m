//
//  MicrojiaoliuCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrojiaoliuCell.h"

@implementation MicrojiaoliuCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
        self.imgView.image = [UIImage imageNamed:@"icon_01"];
        [self.contentView addSubview:self.imgView];
        self.teacherlable = [[UILabel alloc]init];
        [self.contentView addSubview:self.teacherlable];
        self.teacherlable.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 10).heightIs(20);
        [self.teacherlable setSingleLineAutoResizeWithMaxWidth:0];
        self.teacherlable.font = [UIFont systemFontOfSize:10];
        self.teacherlable.text = @"teacher";
        
        self.timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.sd_layout.rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).heightIs(20);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        
        self.timeLabel.text = @"20017/8/11 14:12:11";
        
        self.txtLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.txtLabel];
        self.txtLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.teacherlable, 10).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
        self.txtLabel.font = [UIFont systemFontOfSize:12];
        [self setupAutoHeightWithBottomView:self.txtLabel bottomMargin:10];
    }
    return self;
}
-(void)setModel:(GetCommentListModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    self.teacherlable.text = _model.UserName;
    self.timeLabel.text = _model.C_Intime;
    self.txtLabel.text = _model.C_Content;
}

@end
