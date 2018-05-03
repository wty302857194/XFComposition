//
//  MytestGroupCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MytestGroupCell;
@protocol MytestGroupCellDelegate <NSObject>
-(void)xuanzhong :(UIButton *)bt;
@end
@interface MytestGroupCell : UITableViewCell
@property (nonatomic,weak)id<MytestGroupCellDelegate>delegate;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)UILabel *titleLabel;
@end
