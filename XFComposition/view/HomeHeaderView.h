//
//  HomeHeaderView.h
//  XFComposition
//
//  Created by wbb on 2018/4/17.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GoPhotoBlock) ();

typedef void(^SeeDetailBlock) (NSInteger tag);
@interface HomeHeaderView : UIView
@property (nonatomic, copy)GoPhotoBlock goPhotoBlock;
@property (nonatomic, copy)SeeDetailBlock seeDetailBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerLayout;

@end
