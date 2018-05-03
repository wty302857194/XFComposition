//
//  HomepaSecondCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomepaSecondCell;
@protocol HomePaSecondDelegate <NSObject>

-(void)Eightfunction :(UIButton *)bt;

@end

@interface HomepaSecondCell : UICollectionViewCell
@property (nonatomic,weak)id<HomePaSecondDelegate>delegate;
@end
