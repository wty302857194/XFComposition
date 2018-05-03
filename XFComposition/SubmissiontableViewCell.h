//
//  SubmissiontableViewCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveWriteListModel.h"
@interface SubmissiontableViewCell : UITableViewCell
@property (nonatomic,strong)ActiveWriteListModel *model;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *studentLabel;
@property (nonatomic,strong)UILabel *activityLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;

@end
