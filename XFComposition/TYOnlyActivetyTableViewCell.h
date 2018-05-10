//
//  TYOnlyActivetyTableViewCell.h
//  XFComposition
//
//  Created by wbb on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerModel;
@interface TYOnlyActivetyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) VolunteerModel *model;

@end
