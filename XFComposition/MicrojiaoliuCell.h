//
//  MicrojiaoliuCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCommentListModel.h"
@interface MicrojiaoliuCell : UITableViewCell
@property (nonatomic,strong)GetCommentListModel *model;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *teacherlable;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *txtLabel;

@end
