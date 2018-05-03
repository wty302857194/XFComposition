//
//  MywritingCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MywritingModel.h"
@class MywritingCell;
@protocol MywritingCellDelegate <NSObject>
-(void)xuanzhong :(UIButton *)bt;
-(void)showContent :(UIButton *)bt;
-(void)modify :(UIButton *)bt;
-(void)deleteCell :(UIButton *)bt;
@end

@interface MywritingCell : UITableViewCell

@property (nonatomic,strong)id<MywritingCellDelegate>delegate;
@property (nonatomic,strong)MywritingModel *model;
@property (nonatomic,strong)UIButton *label1;

@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UILabel *label5;
@property (nonatomic,strong)UILabel *label6;
@property (nonatomic,strong)UILabel *label7;

@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)UIButton *bt3;
@property (nonatomic,strong)UIButton *bt4;
@property (nonatomic,strong)UIButton *bt5;
@end
