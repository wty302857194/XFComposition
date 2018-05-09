//
//  WorkMarkCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetTeachNeedCheckListModel.h"
@class WorkMarkCellDelegate;
@protocol WorkMarkCellDelegate <NSObject>

-(void)dianping :(UIButton *)bt withModel:(GetTeachNeedCheckListModel*)model;

@end

@interface WorkMarkCell : UITableViewCell
@property (nonatomic,strong)GetTeachNeedCheckListModel *model;
@property (nonatomic,weak)id<WorkMarkCellDelegate>delegate;
@end
