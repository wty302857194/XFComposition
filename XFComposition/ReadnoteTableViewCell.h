//
//  ReadnoteTableViewCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBookBjModel.h"
@class ReadnoteTableViewCell;
@protocol ReadnoteTableViewCellDelegate <NSObject>

-(void)comment :(UIButton *)bt;

@end
@interface ReadnoteTableViewCell : UITableViewCell
@property (nonatomic,strong)GetBookBjModel *model;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)id<ReadnoteTableViewCellDelegate>delegate;
@end
