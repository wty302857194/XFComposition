//
//  fenxiangViewController.m
//  XFComposition
//
//  Created by longrise on 2018/3/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "fenxiangViewController.h"
#import <Social/Social.h>
@interface fenxiangViewController ()

@end

@implementation fenxiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分享";
    [self leftBarButton];

}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSNotification *LoseResponse = [NSNotification notificationWithName:@"removeMV" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.判断平台是否可用(系统没有集成,用户设置账号)
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"设置界面设置自己的账号");
        return;
    }
    
    // 2.创建分享控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    // 2.1.添加分享的文字
    [composeVc setInitialText:@"梦想还是要有的,万一实现了呢"];
    
    // 2.2.添加分享的图片
    [composeVc addImage:[UIImage imageNamed:@"xingxing"]];
    
    // 3.弹出控制器进行分享
    [self presentViewController:composeVc animated:YES completion:nil];
    
    // 4.设置监听发送结果
    composeVc.completionHandler = ^(SLComposeViewControllerResult reulst) {
        if (reulst == SLComposeViewControllerResultDone) {
            NSLog(@"用户发送成功");
        } else {
            NSLog(@"用户发送失败");
        }
    };
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
