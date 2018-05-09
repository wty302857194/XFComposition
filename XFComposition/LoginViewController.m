//
//  LoginViewController1.m
//  XFComposition
//
//  Created by lc-macbook pro on 2018/4/13.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistTableViewController.h"
#import "NavimainViewController.h"

#import "LoginRequest.h"
//#import "LoginModel.h"
#import "XFUserInfo.h"
//#import "LoginModel.h"
#import "AppDelegate.h"
#import "RegistViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passworldField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    if (IS_IPHONE_X) {
        [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kNavBottom-40);
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(60);
        }];
    }
    
    [self.loginButton lc_borderWithColor:[UIColor clearColor] radiuce:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {

    __weak typeof (self) weakSelf = self;
    LoginRequest *request = [[LoginRequest alloc]init];
    [request LoginRequstphoneText:self.accountField.text password:self.passworldField.text :^(NSDictionary *dic) {
        
        XFUserInfo *model = [XFUserInfo loadWithJSOn:dic];
        
        if ([dic[@"ret_msg"] isEqualToString:@"成功"]) {
            [XFUserInfo saveUserInfo:model];
            NSNotification *LoseResponse = [NSNotification notificationWithName:@"buttonLoseResponse" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.accountField.text forKey:@"ZhangHao"];//是否登陆
            [defaults setObject:self.passworldField.text forKey:@"MiMa"];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UITabBarController *tabbarVC = delegate.tabbarVc;
            tabbarVC.selectedIndex = 3;
            tabbarVC.selectedViewController = tabbarVC.viewControllers[3];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"账户或密码错误"];
        }
    }];
}

- (IBAction)registButtonAction:(id)sender {
//    RegistViewController *vc = [[RegistViewController alloc]init];
//    vc.title = @"注册";
//
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//
//    [self presentViewController:nav animated:YES completion:nil];
    
    UIStoryboard *generalStoryboard = [UIStoryboard storyboardWithName:@"TYStoryboard" bundle:nil];
    RegistTableViewController *loginVC = [generalStoryboard instantiateViewControllerWithIdentifier:@"RegistTableViewController"];
    NavimainViewController *nav = [[NavimainViewController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];}

    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
