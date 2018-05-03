//
//  ApplyMarkCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMyActiveWorkListModel.h"

@class ApplyMarkCell;
@protocol ApplyMarkCellDelegate <NSObject>

-(void)Thanks :(UIButton *)bt;

@end
@interface ApplyMarkCell : UITableViewCell
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)GetMyActiveWorkListModel *model;
@property (nonatomic,weak)id<ApplyMarkCellDelegate>delegate;
@end
