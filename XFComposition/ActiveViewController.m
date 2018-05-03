//
//  ActiveViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveViewController.h"
#import "GetReadActiveRequst.h"

#import "VolunteerModel.h"
#import "AcitiveFristCell.h"
#import "ActiveDatilViewController.h"
@interface ActiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *activeArray;
@end

@implementation ActiveViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[AcitiveFristCell class] forCellReuseIdentifier:@"cell1"];
        
    }
    return _tableView;
}
-(NSMutableArray *)activeArray{
    if (!_activeArray) {
        _activeArray = [NSMutableArray array];
    }
    return _activeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self GetReadActive];
//    NSLog(@"%@",self.dic);
}
-(void)GetReadActive{
    GetReadActiveRequst *requst = [[GetReadActiveRequst alloc]init];
    [requst GetReadActiveRequstwithPageIndex:@"1" withPageSize:@"20" withkeyword:@"" withActiveTypeID:@"3" :^(NSDictionary *json) {
        [self.activeArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
            [self.activeArray addObject:model];
        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.activeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VolunteerModel *Model = self.activeArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[AcitiveFristCell class] contentViewWidth:[self cellContentViewWith]];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AcitiveFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    VolunteerModel *Model = self.activeArray[indexPath.row];
    cell.model = Model;
    
    return cell;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VolunteerModel *Model = self.activeArray[indexPath.row];
    ActiveDatilViewController *vc = [[ActiveDatilViewController alloc]init];
    vc.strid = Model.activeid;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)leftBarButton{
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
