//
//  FristFootView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FristFootView;
@protocol GetmoreDelegate <NSObject>

-(void)getMoreWithdifference;

@end

@interface FristFootView : UICollectionReusableView
@property (nonatomic,strong)id<GetmoreDelegate>delegate;
@property (nonatomic,strong)UIButton *moreButton;
@end
