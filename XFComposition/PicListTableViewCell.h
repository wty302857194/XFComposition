//
//  PicListTableViewCell.h
//  XFComposition
//
//  Created by qiannian on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYStarReplay.h"

typedef void(^PicListTableViewCellBlock)(StandardInfo * info);

@interface PicListTableViewCell : UITableViewCell
-(void)reloadData:(FMBean*)bean;
@property(nonatomic , strong)UILabel * label;
@property(nonatomic , strong) QYStarReplay * starReplay;
@property(nonatomic , assign) BOOL  isChange;
@property(nonatomic , strong) StandardInfo  * info;
@property(nonatomic , copy) PicListTableViewCellBlock   cellBlock;

@end
