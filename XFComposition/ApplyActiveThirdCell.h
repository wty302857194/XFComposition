//
//  ApplyActiveThirdCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApplyActiveThirdCell;
@protocol ApplyActiveThirdCellDelegate <NSObject>

-(void)showTextfield :(UIButton *)bt;

@end
@interface ApplyActiveThirdCell : UITableViewCell
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;

@property (nonatomic,weak)id<ApplyActiveThirdCellDelegate>delegate;
@end
