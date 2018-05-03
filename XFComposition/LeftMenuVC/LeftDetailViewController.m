//
//  LeftDetailViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LeftDetailViewController.h"
#import "LeftMenuModel.h"

@interface LeftDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LeftDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.childsecondArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50-5, kScreenWidth, 5)];
        view.backgroundColor = [UIColor colorWithHexString:@"e8f3fa"];
        [cell.contentView addSubview:view];
    }
    LeftMenuSecondModel *model = self.childsecondArr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuSecondModel *model = self.childsecondArr[indexPath.row];
    
    NSDictionary *dic = @{@"userid":model.userid?:@""};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CropOK" object:nil userInfo:dic];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
