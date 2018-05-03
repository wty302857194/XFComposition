//
//  VolunteerNewsTableViewCell.h
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerNewsListModel;

@interface VolunteerNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
//@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (strong, nonatomic) VolunteerNewsListModel *model;
@end
