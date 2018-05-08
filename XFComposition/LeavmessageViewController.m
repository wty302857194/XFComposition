//
//  LeavmessageViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "LeavmessageViewController.h"
#import "LeaVmessgeTableViewCell.h"
#import "ReplaceCell.h"
#import "GetCommentListRequst.h"
#import "GetCommentListModel.h"
#import "WeikePostCommentRequst.h"//添加评论

@interface LeavmessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)FSTextView *MessgetextView;
@property (nonatomic,strong)NSMutableArray *messgeArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation LeavmessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kLayoutViewMarginTop, WidthFrame, HeightFrame-kLayoutViewMarginTop) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LeaVmessgeTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[ReplaceCell class] forCellReuseIdentifier:@"replacecell"];
    }
    return _tableView;
}
-(NSMutableArray *)messgeArray{
    if (!_messgeArray) {
        _messgeArray = [[NSMutableArray alloc]init];
    }
    return _messgeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"留言";
    [self.view addSubview:self.tableView];
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self Getmessge];//获取评论
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
//获取评论
-(void)Getmessge{
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.leavMessgeId withmodelId:@"6" withPageIndex:@"1" withPageSize:@"20" :^(NSDictionary *json) {
        [self.messgeArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [self.messgeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)requstMore{
    self.page +=1;
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.leavMessgeId withmodelId:@"6" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [self.messgeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
//添加评论
-(void)addliuyan{
    __weak typeof (self) weakSelf = self;
    WeikePostCommentRequst *requst = [[WeikePostCommentRequst alloc]init];
    [requst WeikePostCommentRequstwithuserid:self.userID withmodelid:@"6" withclassid:self.leavMessgeId withuserip:@"127.0.0.1" withCommentinfo:self.MessgetextView.text :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]) {
            [weakSelf Getmessge];
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        }

    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.messgeArray.count == 0) {
        return 1;
    }
    return self.messgeArray.count;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.messgeArray.count == 0) {
        return 80;
    }
    GetCommentListModel *Model = self.messgeArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[LeaVmessgeTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.messgeArray.count == 0) {
        ReplaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replacecell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LeaVmessgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetCommentListModel *Model = self.messgeArray[indexPath.row];
        cell.model = Model;
        return cell;
    }
    return nil;
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 160)];
    self.MessgetextView = [[FSTextView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame-40, 120)];
    self.MessgetextView.layer.borderWidth = 0.5;
    self.MessgetextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.MessgetextView.layer.cornerRadius = 6;
    self.MessgetextView.layer.masksToBounds = YES;
    self.MessgetextView.placeholder = @"请输入内容";
    [view addSubview:self.MessgetextView];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt setTitle:@"添加" forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    bt.layer.cornerRadius = 4;
    bt.layer.masksToBounds = YES;
    bt.frame = CGRectMake(WidthFrame-80-20, CGRectGetMaxY(self.MessgetextView.frame)+5, 80, 25);
    [bt addTarget:self action:@selector(addliuyan) forControlEvents:UIControlEventTouchUpInside];
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
    GO_BACK;
}
-(void)goBackNV{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
