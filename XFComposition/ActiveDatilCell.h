//
//  ActiveDatilCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveDatilThridModel.h"
#import "ActiveDatilSecondModel.h"
@class ActiveDatilCell;
@protocol  ActiveDatilCellDelegate<NSObject>

-(void)click :(UIButton *)bt;

@end

@interface ActiveDatilCell : UITableViewCell
@property (nonatomic,weak)id<ActiveDatilCellDelegate>delegate;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)ActiveDatilThridModel *model;
@property (nonatomic,strong)ActiveDatilSecondModel *model2;
@end
