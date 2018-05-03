//
//  RealnameThridCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RealnameThridCell;
@protocol RealnameThridCellDelegate <NSObject>

-(void)xuanSex :(UIButton *)bt;

@end

@interface RealnameThridCell : UITableViewCell
@property (nonatomic,weak)id<RealnameThridCellDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *btArray;
@end
