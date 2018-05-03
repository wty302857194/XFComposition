//
//  PostCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetTitleCommentModel.h"

@class PostCell;
@protocol  PostCellDelegate<NSObject>

-(void)clickMyps :(UIButton *)bt;

@end
@interface PostCell : UITableViewCell
@property (nonatomic,weak)id<PostCellDelegate>delegate;
@property (nonatomic,strong)GetTitleCommentModel *model;
@property (nonatomic,strong)UILabel *louLabel;
@property (nonatomic,strong)UIButton *bt;
@end
