//
//  MicrodetailFristHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MicrodetailFristHeadView;
@protocol MicrodetailHeadDelegate <NSObject>

-(void)srollView :(UIButton *)btn;

@end
@interface MicrodetailFristHeadView : UICollectionReusableView
@property (nonatomic,weak)id<MicrodetailHeadDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@end
