//
//  ReadnotesCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetBookBjListModel.h"
#import "GetMybookListModel.h"
@class ReadnotesCell;

@protocol ReadnotesCellDelegate <NSObject>

-(void)xiugaiBJ :(UIButton *)bt;
-(void)delectBj :(UIButton *)bt;

@end
@interface ReadnotesCell : UITableViewCell

@property (nonatomic,strong)GetBookBjListModel *model;
@property (nonatomic,strong)GetMybookListModel *bookModel;
@property (nonatomic,weak)id<ReadnotesCellDelegate>delegate;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@end
