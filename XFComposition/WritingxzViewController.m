//
//  WritingxzViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WritingxzViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "LoginViewController.h"
#import "NavimainViewController.h"


@interface WritingxzViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString *htmlStr;
@end

@implementation WritingxzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    self.title = @"作文习作";
    
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];

}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _webView.delegate = self;
        NSURL *url;
        XFUserInfo *xf = [XFUserInfo getUserInfo];
//        int x = arc4random() % 100;//生成随即数
        if (xf.userId == NULL) {
            //未登录加载，
            
            xf.userId = @"0";
        }
        //http://xf.vqune.com/mobile/write.html?id=262
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xf.vqune.com/mobile/write.html?random=%d&userid=%@",x,xf.userId]];
//        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xf.vqune.com/mobile/write.html?id=%@",self.workId]];
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xf.vqune.com/mobile/write.html?id=%@",self.workId]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //    // 3. 发送请求给服务器
        [_webView loadRequest:request];
 
    }
    return _webView;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"share"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        XFUserInfo *xf = [XFUserInfo getUserInfo];
        
        if (xf.userId == NULL) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LoginViewController *loginvc = [[LoginViewController alloc]init];
                [self presentViewController:loginvc animated:YES completion:nil];
                
                for (JSValue *jsVal in args) {
                    self.htmlStr = jsVal.toString;

                }
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(walkVCClick:) name:@"buttonLoseResponse" object:nil];
//                [self reloadView:str];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
    };
    
    
    
}
//重新加载页面
-(void)walkVCClick:(NSString *)str{
    NSLog(@"登录成功啦啦啦啦啦啦啦");
    int x = arc4random() % 100;//生成随即数
    XFUserInfo *xf = [XFUserInfo getUserInfo];
    NSLog(@"html%@", self.htmlStr);
    NSLog(@"用户%@", xf.Loginid );
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?random=%d&userid=%@",self.htmlStr,x,xf.Loginid]];
    NSLog(@"地址%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    // 3. 发送请求给服务器
    [_webView loadRequest:request];

}
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
