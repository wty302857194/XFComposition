//
//  MircFiveCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MircFiveCell;
@protocol  MircFiveCellDelegate<NSObject>
-(void)gotoMircFiveCell :(NSIndexPath *)index;
@end

@interface MircFiveCell : UICollectionViewCell

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,weak)id<MircFiveCellDelegate>delegate;
@property (nonatomic,strong)NSArray *array;

@end


//@protocol  HomePaThridCellDelegate<NSObject>
//
//-(void)gotoVolunactive :(NSIndexPath *)index;
//@end
//@interface HomePaThridCell : UICollectionViewCell
//@property (nonatomic,weak)id<HomePaThridCellDelegate>delegate;
//
//@property (nonatomic,strong)UITableView *tableView;
//
//@property (nonatomic,strong)NSArray *array;
//@end

