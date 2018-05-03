//
//  PicListCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetWritePicModel.h"
@interface PicListCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,assign)GetWritePicModel *model;
@end
