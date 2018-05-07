//
//  SendMessageViewController.m
//  XFComposition
//
//  Created by qiannian on 2018/5/7.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "SendMessageViewController.h"
@interface SendMessageViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet PlaceholderTextView *inputTextView;
@end

@implementation SendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发信";
    self.inputTextView.font = [UIFont systemFontOfSize:13];
    self.inputTextView.delegate = self;
    self.inputTextView.PlaceholderLabel.text = @"请输入内容";
    self.inputTextView.placeholderColor = hexColor(cccccc);
    self.inputTextView.placeholderFont = [UIFont systemFontOfSize:13];
    self.inputTextView.textColor =hexColor(666666);
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
