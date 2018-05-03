//
//  RingdetaiFristCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RingdetaiFristCell;
@protocol  RingdetaiFristCellDelegate<NSObject>
-(void)showmember;
-(void)joinRing :(UIButton *)bt;

@end
@interface RingdetaiFristCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgView;

@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UIButton *memberbt;
@property (nonatomic,strong)UIButton *bt;

@property (nonatomic,weak)id<RingdetaiFristCellDelegate>delegate;
@end
