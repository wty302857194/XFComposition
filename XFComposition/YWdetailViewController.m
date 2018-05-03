//
//  YWdetailViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "YWdetailViewController.h"
#import "YWdatailFristCell.h"
#import "LeaVmessgeTableViewCell.h"
#import "GetCommentListRequst.h"
#import "GetCommentListModel.h"
#import "WeikePostCommentRequst.h"

@interface YWdetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *MessgetextView;
@property (nonatomic,strong)NSMutableArray *messgeArray;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,assign)NSInteger page;
@end

@implementation YWdetailViewController
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
        [_tableView registerClass:[YWdatailFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[LeaVmessgeTableViewCell class] forCellReuseIdentifier:@"cell2"];
//
//        [_tableView registerClass:[ReplaceCell class] forCellReuseIdentifier:@"replacecell"];
    }
    return _tableView;
}
-(NSMutableArray *)messgeArray{
    if (!_messgeArray) {
        _messgeArray = [NSMutableArray array];
    }
    return _messgeArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetCommentListRequst];
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
-(void)addpinglun{
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        return;
    }
    __weak typeof (self) weakSelf = self;
    WeikePostCommentRequst *requst = [[WeikePostCommentRequst alloc]init];
    [requst WeikePostCommentRequstwithuserid:self.xf.Loginid withmodelid:@"9" withclassid:self.model.ID withuserip:@"127.0.0.1" withCommentinfo:self.MessgetextView.text :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]) {
            [weakSelf GetCommentListRequst];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }]];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    }];

}

-(void)GetCommentListRequst{
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.model.ID withmodelId:@"9" withPageIndex:@"1" withPageSize:@"20" :^(NSDictionary *json) {
        [self.messgeArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [self.messgeArray addObject:model];
        }
//        NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:1];    //刷新第1段
//        [self.tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
        
    }];
    
}
-(void)requstMore{
    self.page +=1;
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.model.ID withmodelId:@"9" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [self.messgeArray addObject:model];
        }
        NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:1];    //刷新第1段
        [self.tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.messgeArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self.tableView cellHeightForIndexPath:indexPath model:self.model keyPath:@"model1" cellClass:[YWdatailFristCell class] contentViewWidth:[self cellContentViewWith]];
        
        
    }
    GetCommentListModel *Model = self.messgeArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[LeaVmessgeTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        YWdatailFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.model1 = self.model;
        return cell;
        
    }else if (indexPath.section == 1){
        
        LeaVmessgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetCommentListModel *Model = self.messgeArray[indexPath.row];
        cell.model = Model;
        return cell;
    }
    
    return nil;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 160)];
    self.MessgetextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame-40, 120)];
    self.MessgetextView.layer.borderWidth = 0.5;
    self.MessgetextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.MessgetextView.layer.cornerRadius = 6;
    self.MessgetextView.layer.masksToBounds = YES;
    [view addSubview:self.MessgetextView];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setTitle:@"添加" forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    bt.layer.cornerRadius = 4;
    bt.layer.masksToBounds = YES;
    bt.frame = CGRectMake(WidthFrame-80-20, CGRectGetMaxY(self.MessgetextView.frame)+5, 80, 25);
    [bt addTarget:self action:@selector(addpinglun) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bt];
    return view;
    
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
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
