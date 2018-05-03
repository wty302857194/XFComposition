//
//  MytestpaperCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageListModel.h"
@class MytestpaperCell;
@protocol MytestpaperCellDelegate <NSObject>
-(void)lookit :(UIButton *)bt;
-(void)browse :(UIButton *)bt;
-(void)delecttest :(UIButton *)bt;

@end
@interface MytestpaperCell : UITableViewCell
@property (nonatomic,strong)MyPageListModel *model;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)UIButton *bt3;
@property (nonatomic,weak)id<MytestpaperCellDelegate>delegate;
@end
