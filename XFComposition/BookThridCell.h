//
//  BookThridCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookThridCell;
@protocol BookThridCellDelegate <NSObject>

-(void)Uppic;

@end
@interface BookThridCell : UITableViewCell
@property (nonatomic,strong)UIButton *shangchuanbt;
@property (nonatomic,strong)id<BookThridCellDelegate>delegate;
@end
