//
//  VolunteerWebViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/1.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "VolunteerWebViewController.h"

@interface VolunteerWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation VolunteerWebViewController
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _webView.delegate = self;
        _webView.scalesPageToFit=YES;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新闻详情";
    
    [self.webView loadHTMLString:self.urlStr baseURL:nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

@end
