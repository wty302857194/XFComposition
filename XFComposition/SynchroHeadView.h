//
//  SynchroHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SynchroHeadView;
@protocol synchroDelegate <NSObject>

-(void)choosePag :(UIButton *)bt;

@end

@interface SynchroHeadView : UIView
@property (nonatomic,weak)id<synchroDelegate>delegate;
//@property (nonatomic, strong) NSMutableArray    *tabBtnArray;
@end
