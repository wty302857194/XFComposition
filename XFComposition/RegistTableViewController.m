//
//  RegistTableViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "RegistTableViewController.h"

@interface RegistTableViewController () {
    NSString *_nameStr,*_pswStr;
    
}


@end

@implementation RegistTableViewController
- (IBAction)chooseQu:(UIButton *)sender {
}
- (IBAction)chooseSchool:(UIButton *)sender {
}
- (IBAction)teacherAndStudent:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.tag == 100) {
        
    }else {
        
    }
}
- (IBAction)nameChange:(UITextField *)sender {
    _nameStr = sender.text;
}
- (IBAction)pswChange:(UITextField *)sender {
    _pswStr = sender.text;
}
- (IBAction)switchChange:(UISwitch *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teacherBtn.selected = YES;
    
    GO_BACK;
}
- (void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)getRegistRequestData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetMicroClassList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"changeId":@"2",
                          @"masterId":@"0",
                          @"subjectId":@"0",
//                          @"PageIndex":@(_page),
                          @"PageSize":@"20",
                          @"prostatic":@"-1",
                          @"recommed":@"-1",
                          @"timeSpan":@"2"
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 0;
//}

@end
