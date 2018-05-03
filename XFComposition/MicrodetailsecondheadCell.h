//
//  MicrodetailsecondheadCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/15.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MicrodetailsecondheadCell;
@protocol MicroHeadDelegate <NSObject>

-(void)srollView :(UIButton *)btn;

@end
@interface MicrodetailsecondheadCell : UICollectionViewCell
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,weak)id<MicroHeadDelegate>delegate;
@end
