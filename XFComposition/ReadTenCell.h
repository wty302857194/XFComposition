//
//  ReadTenCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReadStartModel.h"

@interface ReadTenCell : UICollectionViewCell
//@property (nonatomic,strong)UITableView *tableView1;
//@property (nonatomic,strong)UITableView *tableView2;
@property (nonatomic,strong)GetReadStartModel *model;
//@property (nonatomic,strong)NSMutableArray *array2;

@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *schoolLab;
@property (nonatomic,strong) UILabel *numLab;

@end
