//
//  HomePaFristheadView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePaFristheadView;
@protocol HomePaFristheadViewDelegate <NSObject>

-(void)getMore :(UIButton *)bt;

@end

@interface HomePaFristheadView : UICollectionReusableView
@property (nonatomic,strong)UILabel *textLable;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,weak)id<HomePaFristheadViewDelegate>delegate;
@end
