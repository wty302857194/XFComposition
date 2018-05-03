//
//  ApplyActiveSecondCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplyActiveSecondCell;
@protocol  ApplyActiveSecondCellDelegate<NSObject>

-(void)xtfenpei;

@end
@interface ApplyActiveSecondCell : UITableViewCell
@property (nonatomic,weak)id<ApplyActiveSecondCellDelegate>delegate;
@property (nonatomic,strong)UIButton *bt1;
@end
