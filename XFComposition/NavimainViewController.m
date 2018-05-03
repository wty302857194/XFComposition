//
//  NavimainViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "NavimainViewController.h"

@interface NavimainViewController ()

@end

@implementation NavimainViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //改变导航栏（背景、字体）颜色
    self.navigationBar.barTintColor = navigation_barColor(1);
    self.navigationBar.barStyle = UIBarStyleBlack;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}

@end
