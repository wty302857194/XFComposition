//
//  AddTestCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetMyPageSubjectListModel.h"
@class AddTestCell;
@protocol AddTestCellDelegate <NSObject>

-(void)gengxinnimabi :(UIButton *)bt;
-(void)chakan :(UIButton *)bt;
@end
@interface AddTestCell : UITableViewCell
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)UILabel *joinbt;
@property (nonatomic,strong)GetMyPageSubjectListModel *model;
@property (nonatomic,weak)id<AddTestCellDelegate>delegate;
@end
