//
//  FristHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConmHeadView;
@protocol FristHeadViewDelegate <NSObject>

-(void)srollView :(UIButton *)btn;
@end

@interface FristHeadView : UICollectionReusableView
@property (nonatomic, strong) NSMutableArray    *tabBtnArray;
@property (nonatomic,weak)id<FristHeadViewDelegate>delegate;
@end
