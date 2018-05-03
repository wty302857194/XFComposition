//
//  BookRankTableViewCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReadStartModel.h"
@interface BookRankTableViewCell : UITableViewCell
@property (nonatomic,strong)GetReadStartModel *model;

@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *numLabel;
@end
