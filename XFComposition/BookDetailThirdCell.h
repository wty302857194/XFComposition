//
//  BookDetailThirdCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSubejectModel.h"

@class BookDetailThirdCell;
@protocol BookDetailThirdCellDelegate <NSObject>

-(void)canyu;

@end

@interface BookDetailThirdCell : UITableViewCell
@property (nonatomic,strong)GetSubejectModel *model;
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIImageView *imgView;

@property (nonatomic,weak)id<BookDetailThirdCellDelegate>delegate;

@end
//@class BookDetailFristCell;
//@protocol BookDetailFristCellDelegate <NSObject>
//
//-(void)wantRead;
//-(void)NowRead;
//-(void)PastRead;
//@end
//
//@interface BookDetailFristCell : UITableViewCell
//@property (nonatomic,strong)GetBookInfoModel *model;
//@property (nonatomic,weak)id<BookDetailFristCellDelegate>delegate;


