//
//  BookDetailSecondCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBookInfoModel.h"
@interface BookDetailSecondCell : UITableViewCell

@property (nonatomic ,strong) UILabel *table;
@property (nonatomic ,strong) UIView *yijingview;
@property (nonatomic ,strong) UIView *quanbuview;

@property (nonatomic,strong)GetBookInfoModel *model;

@end
