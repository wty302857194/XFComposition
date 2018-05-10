//
//  NewMicoSeventhCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseCollectionViewCell.h"

typedef void(^ShowMoreBlock)();
typedef void(^ShowDetailBlock)(WriteListModel *model);

@interface NewMicoSeventhCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *courseCollView;// 课程collectionView
@property (nonatomic, strong) ShowMoreBlock showMoreBlock;
@property (nonatomic, strong) ShowDetailBlock showDetailBlock;
@property (nonatomic, strong) NSMutableArray *datas;

@end
