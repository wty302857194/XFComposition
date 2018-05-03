//
//  HomeTableViewCell.h
//  XFComposition
//
//  Created by wbb on 2018/4/17.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeLessonModel;

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (strong, nonatomic) HomeLessonModel *lessonModel;
@end
