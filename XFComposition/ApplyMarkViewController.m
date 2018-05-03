//
//  ApplyMarkViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyMarkViewController.h"
#import "ApplyMarkCell.h"
#import "GetMyActiveWorkListRequst.h"
#import "GetMyActiveWorkListModel.h"
#import "DaxieTeacherRequst.h"
#import "MenuView.h"
@interface ApplyMarkViewController ()<UITableViewDelegate,UITableViewDataSource,ApplyMarkCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)NSMutableArray *xizuoArray;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,strong)MenuView *menuView2;
@property (nonatomic,strong)MenuView *menuView3;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,assign)BOOL isShow2;
@property (nonatomic,assign)BOOL isShow3;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)NSString *str2;
@property (nonatomic,strong)NSString *str3;
@property (nonatomic,assign)NSInteger page;
@end

@implementation ApplyMarkViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(void)creatHeadView{
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 5+64, WidthFrame-100, 30)];
    self.textfield.placeholder = @"作品名称";
    self.textfield.layer.cornerRadius = 6;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.borderWidth = 2;
    self.textfield.layer.borderColor = [[UIColor colorWithHexString:@"D4D5D4"] CGColor];
    self.textfield.clearButtonMode=YES;
    self.textfield.font = [UIFont systemFontOfSize:14];
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.textfield];
    
    UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbt.frame = CGRectMake(CGRectGetMaxX(self.textfield.frame)+10, 5+64, 50, 30);
    [selectbt setTitle:@"搜索" forState:UIControlStateNormal];
    selectbt.titleLabel.font = [UIFont systemFontOfSize:16];
    [selectbt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    selectbt.layer.cornerRadius =6;
    selectbt.layer.masksToBounds = YES;
    [self.view addSubview:selectbt];
    NSArray *array = [[NSArray alloc]init];
    array = @[@"请选择活动",@"作品类别",@"作品状态"];
    
    for (int i = 0; i<3; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(WidthFrame/3*i, CGRectGetMaxY(self.textfield.frame)+10, WidthFrame/3, 40);
        bt.tag = 1000+i;
        [bt setTitle:array[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+80, WidthFrame, HeightFrame-64-80) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ApplyMarkCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(NSMutableArray *)xizuoArray{
    if (!_xizuoArray) {
        _xizuoArray = [[NSMutableArray alloc]init];
    }
    return _xizuoArray;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部活动",@"国庆节活动",@"中秋节活动",@"暑假征文活动"];
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(20, 64+80, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow3 = NO;
            NSLog(@"%ld",(long)i);
            if (i == 0) {
                self.str1 = @"0";
            }else if (i == 1){
                self.str1 = @"1";
            }else if (i == 2){
                self.str1 = @"2";
            }else if (i == 3){
                self.str1 = @"3";
            }
            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.view addSubview:_menuView1];
    }
    return _menuView1;
}
-(MenuView *)menuView2{
    if (!_menuView2) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部类别",@"征文",@"投稿"];
        _menuView2 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/3+10, 64+80, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow2 = NO;
            if (i == 0) {
                self.str2 = @"-1";
            }else if (i == 1){
                self.str2 = @"0";
            }else if (i == 2){
                self.str2 = @"1";
            }
            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.view addSubview:_menuView2];
    }
    return _menuView2;
}
-(MenuView *)menuView3{
    if (!_menuView3) {
        
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部",@"待审核",@"没有入库",@"入库"];
        _menuView3 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/3*2, 64+80, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow3 = NO;
            weakSelf.page = 1;
            if (i == 0) {
                self.str3 = @"-2";
            }else if (i == 1){
                self.str3 = @"0";
            }else if (i == 2){
                self.str3 = @"1";
            }else if (i == 3){
                self.str3 = @"2";
            }
            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.view addSubview:_menuView3];
    }
    return _menuView3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请批阅";
    //    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadView];
    [self.view addSubview:self.tableView];
    self.str1 = @"0";
    self.str2 = @"-1";
    self.str3 = @"-2";
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetMyActiveWorkList:self.textfield.text :self.str1 :self.str2 :self.str3];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self GetMore:self.textfield.text :self.str1 :self.str2 :self.str3];
        [self.tableView.mj_footer endRefreshing];
    }];

}
-(void)click:(UIButton *)bt{
    
    if (bt.tag == 1000) {
        
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.menuView1 showView];
        }else{
            [self.menuView1 dismissView];
        }
        
    }else if (bt.tag == 1001){

        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.menuView2 showView];
        }else{
            [self.menuView2 dismissView];
        }
        
        
    }else if (bt.tag == 1002){

        _isShow3 = !_isShow3;
        if (_isShow3) {
            [self.menuView3 showView];
        }else{
            [self.menuView3 dismissView];
        }
        
        
    }

}
//获取作文列表
-(void)GetMyActiveWorkList :(NSString *)text1 :(NSString *)str1 :(NSString *)str2 :(NSString *)str3{
    GetMyActiveWorkListRequst *requst = [[GetMyActiveWorkListRequst alloc]init];
    [requst GetMyActiveWorkListRequstWithuserId:self.applyMarkUserid withPageIndex:@"1" withPageSize:@"20" withworkName:self.textfield.text withactiveId:@"0" withactiveItemId:@"0" withwriteStatic:str3 withwriteTypeId:str2 :^(NSDictionary *json) {
        [self.xizuoArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            
            GetMyActiveWorkListModel *model = [GetMyActiveWorkListModel loadWithJSOn:dic];
            [self.xizuoArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)GetMore :(NSString *)text1 :(NSString *)str1 :(NSString *)str2 :(NSString *)str3{
    self.page +=1;
    GetMyActiveWorkListRequst *requst = [[GetMyActiveWorkListRequst alloc]init];
    [requst GetMyActiveWorkListRequstWithuserId:self.applyMarkUserid withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withworkName:self.textfield.text withactiveId:@"0" withactiveItemId:@"0" withwriteStatic:str3 withwriteTypeId:str2 :^(NSDictionary *json) {
//        [self.xizuoArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            
            GetMyActiveWorkListModel *model = [GetMyActiveWorkListModel loadWithJSOn:dic];
            [self.xizuoArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];


}
//答谢
-(void)Thanks:(UIButton *)bt{
    __weak typeof (self) weakSelf = self;
    GetMyActiveWorkListModel *Model = self.xizuoArray[bt.tag - 1000];
    NSLog(@"%@",Model.WorkID);
    DaxieTeacherRequst *requst = [[DaxieTeacherRequst alloc]init];
    [requst DaxieTeacherRequstWithuserId:self.applyMarkUserid withworkId:Model.WorkID :^(NSDictionary *json) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"ret_msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if ([json[@"ret_code"] isEqualToString:@"0"]){
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tableView reloadData];
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:(bt.tag-1000) inSection:0];
                    [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                });
                
            }
            
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
        

    }];
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (self.messgeArray.count == 0) {
//        return 1;
//    }
    return self.xizuoArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.messgeArray.count == 0) {
//        return 80;
//    }
    GetMyActiveWorkListModel *Model = self.xizuoArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[ApplyMarkCell class] contentViewWidth:[self cellContentViewWith]];
//    return 60;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ApplyMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    GetMyActiveWorkListModel *Model = self.xizuoArray[indexPath.row];
    cell.bt.tag = 1000+indexPath.row;
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
