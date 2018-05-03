//
//  HomePaThridCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePaThridCell;
@protocol  HomePaThridCellDelegate<NSObject>

-(void)gotoVolunactive :(NSIndexPath *)index;
@end
@interface HomePaThridCell : UICollectionViewCell
@property (nonatomic,weak)id<HomePaThridCellDelegate>delegate;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *array;
@end
