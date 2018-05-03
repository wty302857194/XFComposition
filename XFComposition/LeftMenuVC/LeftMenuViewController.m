//
//  LeftMenuViewController.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuModel.h"
#import "LeftDetailViewController.h"

@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *dataArr;
@end

@implementation LeftMenuViewController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self leftMenuRequestData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LeftMenuModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.name?:@"";
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
    LeftMenuModel *leftModel = self.dataArr[indexPath.row];
    
    LeftDetailViewController *vc = [[LeftDetailViewController alloc] init];
    vc.childsecondArr = leftModel.childfirst;
    [self cw_pushViewController:vc];

}
/*
 "Action:GetLabelTypeTreelistAll
 Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
 ID：0   //标签父节点标识
 Flag:0 // 标签类别
 modelid：1   //0默认 1作文库标签 7 活动标签 9 大家语文标签"
 */
- (void)leftMenuRequestData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetLabelTypeTreelistAll",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"ID":@"0",
                          @"Flag":@"-1",
                          @"modelid":@"1"
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        NSArray *arr = succeedResult[@"ret_data"];

        for (NSDictionary *dic in arr) {
            LeftMenuModel *leftModel = [LeftMenuModel mj_objectWithKeyValues:dic];
            [self.dataArr addObject:leftModel];
        }
        [self.tableView reloadData];
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
@end
