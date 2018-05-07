//
//  PerCenterViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PerCenterViewController.h"
#import "PerCenterCell.h"
#import "GetMessageListRequst.h"
#import "GetMessageListModel.h"
#import "ReplaceCell.h"
#import "MessageDetailViewController.h"
@interface PerCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger index;
    
}
@property (nonatomic,strong) XFUserInfo *xf;

@end

@implementation PerCenterViewController
- (UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tabelView.backgroundColor = [UIColor whiteColor];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        [_tabelView registerClass:[PerCenterCell class] forCellReuseIdentifier:@"cell"];
        [_tabelView registerClass:[ReplaceCell class] forCellReuseIdentifier:@"replacecell"];
        _tabelView.estimatedRowHeight=450.0f;
    }
    return _tabelView;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
-(NSMutableArray *)messgeArray{
    if (!_messgeArray) {
        _messgeArray = [[NSMutableArray alloc]init];
    }
    return _messgeArray;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabelView.mj_header beginRefreshing];

}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.tabelView.mj_header endRefreshing];
    [self.tabelView.mj_footer endRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabelView];
    
    
    self.xf = [XFUserInfo getUserInfo];
    [self GetMessagelist];
}

-(void)GetMessagelist{
    __weak typeof (self) weakSelf = self;
    
    index = 1;
    
    weakSelf.tabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        index = 1;
        GetMessageListRequst *requst = [[GetMessageListRequst alloc]init];
        [requst GetMessageListRequstwithPageIndex:[NSString stringWithFormat:@"%ld",(long)index] withPageSize:@"10" withtype:self.typeStr withflag:self.flagStr withuserid:self.xf.Loginid :^(NSDictionary *json) {
            
            [weakSelf.messgeArray removeAllObjects];
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                GetMessageListModel *model = [[GetMessageListModel alloc] initWithDictionary:dic];
                [weakSelf.messgeArray addObject:model];
            }
            [weakSelf.tabelView reloadData];
            
            [weakSelf.tabelView.mj_header endRefreshing];
            [weakSelf.tabelView.mj_footer endRefreshing];
            
        }];
    }];
    
    weakSelf.tabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        index ++ ;
        GetMessageListRequst *requst = [[GetMessageListRequst alloc]init];
        [requst GetMessageListRequstwithPageIndex:[NSString stringWithFormat:@"%ld",(long)index] withPageSize:@"10" withtype:self.typeStr withflag:self.flagStr withuserid:self.xf.Loginid :^(NSDictionary *json) {
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                GetMessageListModel *model = [[GetMessageListModel alloc] initWithDictionary :dic];
                [weakSelf.messgeArray addObject:model];
            }
            [weakSelf.tabelView reloadData];
            [weakSelf.tabelView.mj_header endRefreshing];
            [weakSelf.tabelView.mj_footer endRefreshing];
        }];
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.messgeArray.count == 0) {
        return 1;
    }
    return self.messgeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.messgeArray.count == 0) {
        ReplaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replacecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
    PerCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GetMessageListModel *Model = self.messgeArray[indexPath.row];
    cell.model = Model;
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GetMessageListModel *Model = self.messgeArray[indexPath.row];
//    return [self.tabelView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[PerCenterCell class] contentViewWidth:[self cellContentViewWith]];
    if (self.messgeArray.count == 0) {
        return HeightFrame-64;
    }
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MessageDetailViewController * vc = [[MessageDetailViewController alloc]init];
     GetMessageListModel *Model = self.messgeArray[indexPath.row];
    vc.msgId = Model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
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
#pragma mark ----------------单例--------------------
+ (instancetype)defaultPlainViewController{
    static PerCenterViewController *defaultPVC = nil;
    if (!defaultPVC) {
        defaultPVC = [[PerCenterViewController alloc] init];
    }
    return defaultPVC;
}

@end
