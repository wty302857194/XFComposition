//
//  RecruiteacherFristCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecruiteacherFristCell;
@protocol RecruiteacherFristCellDelegate <NSObject>

-(void)Submission;

@end

@interface RecruiteacherFristCell : UICollectionViewCell


@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *xqlabel;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIButton *bmbt;
@property (nonatomic,strong)UILabel *mingelabel;
@property (nonatomic,weak)id<RecruiteacherFristCellDelegate>delegate;
@end
