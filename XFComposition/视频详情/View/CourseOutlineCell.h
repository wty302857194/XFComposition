//
//  CourseOutlineCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicroVideoModel.h"

@interface CourseOutlineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *classLab;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLab;

@property (nonatomic, strong) MicroVideoModel *videoModel;

-(void)setVideoModel:(MicroVideoModel *)videoModel atIndex:(NSInteger)index;

@end
