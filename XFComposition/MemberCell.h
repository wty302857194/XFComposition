//
//  MemberCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetGroupUserModel.h"
@interface MemberCell : UITableViewCell
@property (nonatomic,strong)GetGroupUserModel *model;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
