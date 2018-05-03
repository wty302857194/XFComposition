//
//  MainTabBarViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "NavimainViewController.h"
#import "UIImage+Extension.h"
#import "WelecomeView.h"
#import "LoginViewController.h"

@interface MainTabBarViewController ()<UITabBarControllerDelegate,WelecomeViewDelegate>
@property (nonatomic,strong)WelecomeView *welecomeView;
@end

@implementation MainTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self WelecomeUiViewOnec];
    
}
-(WelecomeView *)welecomeView{
    if (!_welecomeView) {
        _welecomeView = [[WelecomeView alloc]initWithFrame:self.view.frame];
        _welecomeView.delegate = self;
    }
    return _welecomeView;
}
-(void)WelecomeUiViewOnec{
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([version isEqualToString:saveVersion]) {
        
        [self addChildViewcontrollers];
        //        [self checkb];//版本更新监测
        
        
    }else{
        //添加欢迎界面
        
        [self.view addSubview :self.welecomeView];
        
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

-(void)addChildViewcontrollers{
    
    
    self.delegate = self;
    NSArray *classNameArray = [[NSArray alloc]init];
    NSArray *classNameArray2 = [[NSArray alloc]init];
    classNameArray = @[@"HomeViewController",@"CompositionLibraryViewController",@"VolunteerViewController",@"MyViewController"];
    classNameArray2 = @[@"HomeViewController",@"CompositionLibraryViewController",@"VolunteerViewController",@"MyViewController"];
    NSMutableArray *controllerArray = [NSMutableArray array];
    for (int i = 0; i<classNameArray.count; i++) {
        Class class = NSClassFromString(classNameArray[i]);
        
        UIViewController *vc = [[class alloc]init];
        
        NavimainViewController *mnc = [[NavimainViewController alloc]initWithRootViewController:vc];//navi 改变了
        [controllerArray addObject:mnc];
        
    }
    self.viewControllers = controllerArray;
    [self setItems];
}
- (void)setItems{
    NSArray *titleArr = @[@"首页", @"作文库",@"志愿者活动", @"我的"];
    
    NSArray *normalArr = @[@"tab-bar_icon_shouye_n", @"tab-bar_icon_zwk_n",@"tab-bar_icon_zhiyanzhe_n",@"tab-bar_icon_wode_n"];
    
    NSArray *selectArr = @[@"tab-bar_icon_shouye_s",@"tab-bar_icon_zwk_s",@"tab-bar_icon_zhiyanzhe_s",@"tab-bar_icon_wode_s"];
    
    for (int i =0; i < titleArr.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageWithOriginalImageName:normalArr[i]] selectedImage:[UIImage imageWithOriginalImageName:selectArr[i]]];
        
    }
}
//移除欢迎界面
-(void)removeWelecomeView{
    [self.welecomeView removeFromSuperview];
    [self addChildViewcontrollers];
    
}
//版本检测
-(void)check{
    
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(viewController == [tabBarController.viewControllers objectAtIndex:3]){
        XFUserInfo *xf = [XFUserInfo getUserInfo];
//        NSLog(@"这是我的%@",xf.userId);
//        NSLog(@"TF%d",[XFUserInfo isLogin]);
        if (xf.userId == NULL) {
            LoginViewController *loginVc = [[LoginViewController alloc]init];
        
            [self presentViewController:loginVc animated:YES completion:nil];
            
            return NO;
            
        }else{
            return YES;
        }
        
    }
    return YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
