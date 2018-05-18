//
//  QiPaoTagView.h
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ContentStrBlock) (NSString *contentStr);
typedef void(^LocationBlock) (CGRect frame);
@interface QiPaoTagView : UIView
@property (nonatomic,copy) ContentStrBlock contentStrBlock;//编辑的信息
@property (nonatomic,copy) LocationBlock locationBlock;//编辑的信息

@property (nonatomic,copy) NSString *time;
@property (nonatomic,strong) FSTextView *textView ;
@end
