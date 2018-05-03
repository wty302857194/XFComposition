//
//  RingdetailTableViewCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMyHtListModel.h"
@interface RingdetailTableViewCell : UITableViewCell
@property (nonatomic,strong)GetMyHtListModel *model;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *userLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *titleLbel;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@end
