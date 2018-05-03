//
//  CommentViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CommentViewController.h"
#import "LeaVmessgeTableViewCell.h"
#import "ReplaceCell.h"
#import "CommentFrsitCell.h"
#import "GetCommentListRequst.h"
#import "WeikePostCommentRequst.h"
#import "GetBookBjInfoRequst.h"
#import "GetBookBjInfoModel.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *MessgetextView;
@property (nonatomic,strong)NSMutableArray *messgeArray;
@property (nonatomic,strong)GetBookBjInfoModel *bookbjModel;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,assign)NSInteger page;
@end

@implementation CommentViewController
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CommentFrsitCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[LeaVmessgeTableViewCell class] forCellReuseIdentifier:@"cell2"];
        
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
-(GetBookBjInfoModel *)bookbjModel{
    if (!_bookbjModel) {
        _bookbjModel = [[GetBookBjInfoModel alloc]init];
    }
    return _bookbjModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    [self.view addSubview:self.tableView];
    self.xf = [XFUserInfo getUserInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self Getmessge];
        [self GetBookbjfo];
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

//图书信息
-(void)GetBookbjfo{
    
    GetBookBjInfoRequst *requst = [[GetBookBjInfoRequst alloc]init];
    [requst GetBookBjInfoRequstWithbjid:self.commentId :^(NSDictionary *json) {
        
        self.bookbjModel = [[GetBookBjInfoModel alloc]init];
        
        self.bookbjModel = [GetBookBjInfoModel loadWithJSOn:json[@"ret_data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}
-(void)requstMore{
    self.page +=1;
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.commentId withmodelId:@"8" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [self.messgeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];


}
//获取评论
-(void)Getmessge{
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.commentId withmodelId:@"8" withPageIndex:@"1" withPageSize:@"20" :^(NSDictionary *json) {
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
//添加
-(void)addpinglun{
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        return;
    }
    __weak typeof (self) weakSelf = self;
    WeikePostCommentRequst *requst = [[WeikePostCommentRequst alloc]init];
    [requst WeikePostCommentRequstwithuserid:self.xf.Loginid withmodelid:@"8" withclassid:self.commentId withuserip:@"127.0.0.1" withCommentinfo:self.MessgetextView.text :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]) {
            [weakSelf Getmessge];
            [SVProgressHUD showInfoWithStatus:json[@"ret_data"]];
        }
        
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self.tableView cellHeightForIndexPath:indexPath model:self.bookbjModel keyPath:@"model" cellClass:[CommentFrsitCell class] contentViewWidth:[self cellContentViewWith]];
    }
    
    
    GetCommentListModel *Model = self.messgeArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[LeaVmessgeTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CommentFrsitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        cell.model = self.bookbjModel;
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
