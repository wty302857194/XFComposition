//
//  NewMicoSeventhCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseCollectionViewCell.h"

@interface NewMicoSeventhCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *courseCollView;// 课程collectionView

@end
