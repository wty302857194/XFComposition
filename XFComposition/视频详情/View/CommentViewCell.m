//
//  CommentViewCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CommentViewCell.h"
#import "SDWebImageManager.h"
#import "DianPingModel.h"
#import "GetCommentListModel.h"

@implementation CommentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(id)data
{
    _data = data;
    if ([_data isKindOfClass:[DianPingModel class]]) {
        DianPingModel *model = (DianPingModel *)_data;
        _userNameLab.text = model.username;
        _dateLab.text = model.checktime;
        _contentLab.text = model.title;
    } else if ([_data isKindOfClass:[GetCommentListModel class]]) {
        GetCommentListModel *model = (GetCommentListModel *)_data;
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.UserPic]]];
        _userNameLab.text = model.UserName;
        _dateLab.text = model.C_Intime;
        _contentLab.text = model.C_Content;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
