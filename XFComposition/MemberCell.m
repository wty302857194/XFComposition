//
//  MemberCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        
        [self.contentView sd_addSubviews:@[self.imgView,self.label1,self.label2,self.label3]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).widthIs(36).heightIs(36);
        self.imgView.layer.masksToBounds =YES;
        self.imgView.layer.cornerRadius = 18;
        
        self.label1.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:14];
        
        self.label2.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.label1, 5).heightIs(20).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:13];
        self.label2.textColor = [UIColor lightGrayColor];
        
        self.label3.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(24).widthIs(50);
        self.label3.font = [UIFont systemFontOfSize:14];
        self.label3.layer.masksToBounds = YES;
        self.label3.layer.cornerRadius = 4;
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.textColor = [UIColor whiteColor];
        self.label3.backgroundColor = [UIColor colorWithHexString:@"F4B246"];
    }
    return self;
}
-(void)setModel:(GetGroupUserModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.UserPic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    self.label1.text = _model.UserName;
    self.label2.text = [NSString stringWithFormat:@"加入时间：%@",_model.JoinTime];
    if ([_model.RoleType integerValue] == 1) {
        self.label3.text = @"管理员";
    }else{
        self.label3.text = @"用户";
        
    }
}
@end
