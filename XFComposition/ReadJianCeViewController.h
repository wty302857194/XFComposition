//
//  ReadJianCeViewController.h
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "BaseViewController.h"

@interface ReadJianCeViewController : BaseViewController
@property (nonatomic,assign) NSString *isTeacher;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneViewLayout;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@end
