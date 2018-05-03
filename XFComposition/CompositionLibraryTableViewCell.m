//
//  CompositionLibraryTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CompositionLibraryTableViewCell.h"
#import "CommwritelistModel.h"

@implementation CompositionLibraryTableViewCell

- (void)setListModel:(CommwritelistModel *)listModel {
    _listModel = listModel;
   
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,listModel.UserPic]] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.titleLab.text = [NSString stringWithFormat:@"《%@》",listModel.BlogTitle];
    self.nameLab.text = [NSString stringWithFormat:@"作者：%@",listModel.UserName];
    self.numPeople.text = [NSString stringWithFormat:@"点评人数：%@",listModel.PyNum];
    if ([listModel.labels isEqualToString:@""]) {
        listModel.labels = @"暂无";
    }
    self.tagLab.text = [NSString stringWithFormat:@"标签：%@",listModel.labels?:@""];
    self.contentLab.text = [NSString stringWithFormat:@"内容简介：%@",listModel.BlogContent?:@""];
}

@end
