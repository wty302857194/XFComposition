//
//  ReadeightCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadeightCell : UICollectionViewCell
@property (nonatomic,strong)UITableView *WeekTableView;
@property (nonatomic,strong)UITableView *MonthTableView;
@property (nonatomic,strong)NSMutableArray *Warray;
@property (nonatomic,strong)NSMutableArray *Marray;
@end
