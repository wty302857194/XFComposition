//
//  SubmissionHeadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubmissionHeadView;
@protocol SubmissionHeadViewDelegate <NSObject>

-(void)reshData :(NSString *)str :(NSString *)str2 :(NSString *)str3;

@end
@interface SubmissionHeadView : UICollectionReusableView
@property (nonatomic,strong)id<SubmissionHeadViewDelegate>delegate;
@end
