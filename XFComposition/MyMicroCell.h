//
//  MyMicroCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMicroCell;
@protocol MyMicroCellDelegate <NSObject>

-(void)CancelCollect :(UIButton *)bt;

@end

@interface MyMicroCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,weak)id<MyMicroCellDelegate>delegate;
@end
