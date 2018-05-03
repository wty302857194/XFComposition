//
//  RingdetaiSecondCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class RingdetaiSecondCell;
//@protocol RingdetaiSecondCellDelegate <NSObject>
//
//-(void)didselect :(NSIndexPath *)indexpath;
//@end

@class RingdetaiSecondCell;
@protocol  RingdetaiotherDelegate<NSObject>

-(void)didselect :(NSIndexPath *)indexpath;

@end

@interface RingdetaiSecondCell : UICollectionViewCell
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,weak)id<RingdetaiotherDelegate>delegate;
@end
