//
//  HomePageFristTableViewCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageFristTableViewCell;
@protocol HomePageFristDelegate <NSObject>

-(void)Eightfunction :(UIButton *)bt;

@end
@interface HomePageFristTableViewCell : UITableViewCell
@property (nonatomic,weak)id<HomePageFristDelegate>delegate;

@end
