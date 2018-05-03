//
//  RingdetailHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RingdetailHeadView;
@protocol RingdetailHeadViewDelegate <NSObject>

-(void)scrollrRingView:(UIButton *)bt;

@end
@interface RingdetailHeadView : UICollectionReusableView
@property (nonatomic,strong)NSArray *btArray;
@property (nonatomic, strong) NSMutableArray *tabBtnArray;
@property (nonatomic,weak)id<RingdetailHeadViewDelegate>delegate;
@end
