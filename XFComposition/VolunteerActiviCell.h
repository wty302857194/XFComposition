//
//  VolunteerActiviCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/19.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VolunteerActiviCell;
@protocol VolunterrApplyteacherDelegate <NSObject>
-(void)gotodetail :(UIButton *)btn;
-(void)Applyteacher;
-(void)Applywork :(UIButton *)bt;
-(void)Submission;
@end
@protocol VolunterrApplyworkDelegate <NSObject>



@end

@interface VolunteerActiviCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *xqlabel;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIButton *detailBt;
@property (nonatomic,strong)UIButton *teacherbt;
@property (nonatomic,strong)UIButton *workbt;
@property (nonatomic,strong)UIButton *tougaobt;

@property (nonatomic,weak)id<VolunterrApplyteacherDelegate>delegate;
@end
