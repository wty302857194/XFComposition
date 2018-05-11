//
//  AlertWriteView.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicPianduanmodel.h"

@protocol AddwritingViewDelegate <NSObject>

-(void)addWriting:(NSString *)title content:(NSString *)content flag:(NSString *)flg;

@end

@interface AlertWriteView : UIView 

@property (nonatomic, assign) id<AddwritingViewDelegate> delegate;


-(void)showViewWithModel:(MicPianduanmodel *)model content:(NSString *)content flag:(NSString *)flag;

@end
