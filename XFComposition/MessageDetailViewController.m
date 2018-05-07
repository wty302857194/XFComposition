//
//  MessageDetailViewController.m
//  XFComposition
//
//  Created by qiannian on 2018/5/4.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetail.h"
@interface MessageDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"消息详情";
    
    [[XFRequestManager sharedInstance]  XFRequstGetMessageDetail:_msgId userid:[XFUserInfo getUserInfo].Loginid repondeBlock:^(NSString *requestName, id  responseData,BOOL isSuccess) {
        
        if ([requestName isEqualToString:XFReq_User_getMessageDetail]) {
            NSMutableArray * array =(NSMutableArray*) responseData;
            MessageDetail * detail = array[0];
            if (isSuccess){
                
                _titleLabel.text =detail.Metitle;
                _contentLabel.text = detail.Mecontain;
            }else{
                [SVProgressHUD showErrorWithStatus:responseData];
            }
        }
    }];
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
