//
//  ConmHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConmHeadView;
@protocol HeadViewDelegate <NSObject>

-(void)srollView :(UIButton *)btn;
@end
@interface ConmHeadView : UIView
@property (nonatomic, strong) NSMutableArray    *tabBtnArray;
@property (nonatomic,weak)id<HeadViewDelegate>delegate;

@end
