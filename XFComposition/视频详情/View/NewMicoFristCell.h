//
//  NewMicoFristCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/7.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicrodetailModel.h"

typedef void(^ClickBtnBlock)(NSInteger itemIndex);

@interface NewMicoFristCell : UITableViewCell

@property (nonatomic, strong) ClickBtnBlock clickBlock;
@property (nonatomic, strong) MicrodetailModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;// 标题
@property (weak, nonatomic) IBOutlet UILabel *teacherLab;//课程设计导师
@property (weak, nonatomic) IBOutlet UILabel *courseLab;//课程时间
@property (weak, nonatomic) IBOutlet UILabel *teachGuideLab;//教学目标

@property (weak, nonatomic) IBOutlet UILabel *workLab;//习作要求

@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;//收藏
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;//分享

- (IBAction)collectionCourse:(id)sender;
- (IBAction)shareCourse:(id)sender;

- (float)getCellHeight;
@end
