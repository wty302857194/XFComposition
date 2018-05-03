//
//  TakenotesCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetPageListModel.h"
@class TakenotesCell;
@protocol TakenotesCellDelegate <NSObject>
-(void)chakan :(UIButton *)bt;
@end

@interface TakenotesCell : UITableViewCell
@property (nonatomic,weak)id<TakenotesCellDelegate>delegate;
@property (nonatomic,strong)GetPageListModel *model;
@property (nonatomic,strong)UIButton *bt;
@end
