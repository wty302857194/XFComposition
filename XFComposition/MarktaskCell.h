//
//  MarktaskCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetTeacherNeedActiveModel.h"
@class MarktaskCell;
@protocol MarktaskCellDelegate <NSObject>

-(void)markTask :(UIButton *)bt;

@end
@interface MarktaskCell : UITableViewCell
@property (nonatomic,strong)GetTeacherNeedActiveModel *model;
@property (nonatomic,weak)id<MarktaskCellDelegate>delegate;
@end
