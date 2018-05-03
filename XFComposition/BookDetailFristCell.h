//
//  BookDetailFristCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBookInfoModel.h"
@class BookDetailFristCell;
@protocol BookDetailFristCellDelegate <NSObject>

-(void)wantRead;
-(void)NowRead;
-(void)PastRead;
@end

@interface BookDetailFristCell : UITableViewCell
@property (nonatomic,strong)GetBookInfoModel *model;
@property (nonatomic,weak)id<BookDetailFristCellDelegate>delegate;

@end
