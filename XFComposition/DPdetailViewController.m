//
//  DPdetailViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "DPdetailViewController.h"

@interface DPdetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation DPdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self leftBarButton];
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64)];
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
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xf.vqune.com/mobile/write.html?id=%@",self.dpID]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //    // 3. 发送请求给服务器
        [_webView loadRequest:request];
        
    }
    return _webView;
}

@end
