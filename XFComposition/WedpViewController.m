//
//  WedpViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WedpViewController.h"
#import "WedpCell.h"
#import "GetDinaPinListRequst.h"
#import "DianPingModel.h"
#import "DPdetailViewController.h"
@interface WedpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dpArray;
@property (nonatomic,assign)NSInteger page;

@end

@implementation WedpViewController
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WedpCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)dpArray{
    if (!_dpArray) {
        _dpArray = [NSMutableArray array];
    }
    return _dpArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大家点评";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self Getdianping];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)Getdianping{
    GetDinaPinListRequst *requst = [[GetDinaPinListRequst alloc]init];
    [requst GetDinaPinListRequswithPageIndex:@"1" withPageSize:@"20" withclassId:@"0" withmodelId:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        [self.dpArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [self.dpArray addObject:model];

        }
        [self.tableView reloadData];
    }];
    
}
-(void)requstMore{
    self.page +=1;
    GetDinaPinListRequst *requst = [[GetDinaPinListRequst alloc]init];
    [requst GetDinaPinListRequswithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withclassId:@"0" withmodelId:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [self.dpArray addObject:model];
            
        }
        [self.tableView reloadData];
    }];
    
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dpArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DianPingModel *Model = self.dpArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[WedpCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WedpCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DianPingModel *Model = self.dpArray[indexPath.row];
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
    DianPingModel *Model = self.dpArray[indexPath.row];
    DPdetailViewController *vc = [[DPdetailViewController alloc]init];
    vc.dpID = Model.DPid;
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
