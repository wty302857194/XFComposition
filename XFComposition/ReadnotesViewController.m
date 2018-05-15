
//
//  ReadnotesViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadnotesViewController.h"

#import "ReadnotesCell.h"
#import "GetBookBJListRequst.h"
#import "GetBookBjListModel.h"
#import "MenuView.h"
#import "DelBookBJRequst.h"

#import "MarkprogressViewController.h"
@interface ReadnotesViewController ()<UITableViewDelegate,UITableViewDataSource,ReadnotesCellDelegate>
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,strong)NSMutableArray *bjArray;
@property (nonatomic,strong)   UIImageView * imgView;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,copy)NSString *str1;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UIButton *bt;


@end

@implementation ReadnotesViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(void)creatHeadView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 10+SafeAreaTopHeight, WidthFrame-160, 30)];
    self.textfield.placeholder = @"关键词";
    self.textfield.layer.cornerRadius = 6;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.borderWidth = .5;
    self.textfield.layer.borderColor = [[UIColor colorWithHexString:@"D4D5D4"] CGColor];
    self.textfield.clearButtonMode=YES;
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    self.textfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.textfield];
    
    UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbt.frame = CGRectMake(CGRectGetMaxX(self.textfield.frame)+10, 10+SafeAreaTopHeight, 50, 30);
    [selectbt setTitle:@"查询" forState:UIControlStateNormal];
    selectbt.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectbt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    selectbt.layer.cornerRadius =6;
    selectbt.layer.masksToBounds = YES;
    [self.view addSubview:selectbt];
    UIButton *delecttbt = [UIButton buttonWithType:UIButtonTypeCustom];
    delecttbt.frame = CGRectMake(CGRectGetMaxX(selectbt.frame)+10, 10+SafeAreaTopHeight, 50, 30);
    [delecttbt setTitle:@"删除" forState:UIControlStateNormal];
    delecttbt.titleLabel.font = [UIFont systemFontOfSize:14];
    [delecttbt setBackgroundColor:[UIColor colorWithHexString:@"E93E33"]];
    delecttbt.layer.cornerRadius =6;
    delecttbt.layer.masksToBounds = YES;
    [self.view addSubview:delecttbt];
     _bt = [UIButton buttonWithType:UIButtonTypeCustom];

    _bt.frame = CGRectMake(0, SafeAreaTopHeight + 51, WidthFrame, 40);
    [_bt setTitle:@"全部状态" forState:UIControlStateNormal];
    [_bt setTitleColor:hexColor(333333) forState:UIControlStateNormal];
    _bt.titleLabel.font = [UIFont systemFontOfSize:14];
    _bt.backgroundColor = [UIColor whiteColor];
    [_bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bt];
    
    _imgView  = [[UIImageView alloc] initWithFrame:CGRectMake(WidthFrame/2+ 30, SafeAreaTopHeight + 50 + (40 -16)/2, 16, 16)];
    _imgView.image = [UIImage imageNamed:@"ic_open_down2"];
    
    [self.view addSubview:_imgView];

    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+91, WidthFrame, HeightFrame-64-80) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ReadnotesCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)bjArray{
    if (!_bjArray) {
        _bjArray = [[NSMutableArray alloc]init];
    }
    return _bjArray;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部状态",@"推荐",@"不推荐"];
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+92, WidthFrame, 60*array.count)cellarray:array block:^(NSInteger i) {
            weakSelf.isShow1 = NO;
            weakSelf.page = 1;
            if (i == 0) {
                weakSelf.str1 = @"-1";
            }else if (i == 1){
                weakSelf.str1 = @"0";
            }else if (i == 2){
                weakSelf.str1 = @"1";
            }
            _imgView.image = [UIImage imageNamed:@"ic_open_down2"];
            [_bt setTitle:array [i] forState:UIControlStateNormal];
            [weakSelf GetBookBJList:weakSelf.str1];

        }];
        [self.view addSubview:_menuView1];
    }
    return _menuView1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"读书笔记";
    self.view.backgroundColor = hexColor(e5e5e5);
    [self creatHeadView];

    [self.view addSubview:self.tableView];
    self.page = 1;
    self.str1 = @"-1";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetBookBJList :self.str1];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore:self.str1];
        [self.tableView.mj_footer endRefreshing];
    }];

}
//获取笔记列表
-(void)GetBookBJList :(NSString *)istuijian{
    GetBookBJListRequst *requst = [[GetBookBJListRequst alloc]init];
    [requst GetBookBJListRequstWithbookid:@"0" withremarktype:@"1" withistuijian:istuijian withremarkStatic:@"-1" withkeyword:self.textfield.text withPageIndex:@"1" withPageSize:@"20" withuserid:self.readnotesUserid :^(NSDictionary *json) {
        [self.bjArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjListModel *model = [GetBookBjListModel loadWithJSOn:dic];
            [self.bjArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}

-(void)requstMore :(NSString *)istuijian{
    self.page +=1;
    GetBookBJListRequst *requst = [[GetBookBJListRequst alloc]init];
    [requst GetBookBJListRequstWithbookid:@"0" withremarktype:@"1" withistuijian:istuijian withremarkStatic:@"-1" withkeyword:self.textfield.text withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withuserid:self.readnotesUserid :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjListModel *model = [GetBookBjListModel loadWithJSOn:dic];
            [self.bjArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)click{
    
    
    _isShow1 = !_isShow1;
    
    if (_isShow1) {
        _imgView.image = [UIImage imageNamed:@"ic_colse_down2"];
        [self.menuView1 showView];
    }else{
        _imgView.image = [UIImage imageNamed:@"ic_open_down2"];
        [self.menuView1 dismissView];
    }
    
    
    
}
//删除笔记
-(void)delectBj:(UIButton *)bt{
    
    __weak typeof (self) weakSelf = self;

    GetBookBjListModel *Model = self.bjArray[bt.tag - 2000];
    DelBookBJRequst *requst = [[DelBookBJRequst alloc]init];
    [requst DelBookBJRequstWithids:Model.bookId withFlag:@"3" withuserid:self.readnotesUserid :^(NSDictionary *json) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"ret_msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if ([json[@"ret_code"] isEqualToString:@"0"]){
                [weakSelf GetBookBJList :self.str1];
            }
            
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    }];

}
//修改笔记
-(void)xiugaiBJ:(UIButton *)bt{
    GetBookBjListModel *Model = self.bjArray[bt.tag - 1000];
    
    MarkprogressViewController *vc = [[MarkprogressViewController alloc]init];
    vc.bookID = Model.bookid;
    vc.bjID = Model.bookId;
    vc.userId = self.readnotesUserid;
    vc.PageStr = Model.pages;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    

}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.bjArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GetBookBjListModel *Model = self.bjArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[ReadnotesCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ReadnotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.bt1.tag = 1000+indexPath.row;
    cell.bt2.tag = 2000+indexPath.row;
    GetBookBjListModel *Model = self.bjArray[indexPath.row];
    cell.model = Model;
    return  cell;
    
    
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
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
