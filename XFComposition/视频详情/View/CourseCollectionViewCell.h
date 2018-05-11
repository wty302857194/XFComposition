//
//  CourseCollectionViewCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteListModel.h"

@interface CourseCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *courseImg;
@property (weak, nonatomic) IBOutlet UILabel *courseLab;

@property (nonatomic, strong) WriteListModel *dataModel;

@end
