//
//  ExerciseViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ExerciseViewController.h"
#import "DanxuanCell.h"
#import "DuoXuanCell.h"
#import "PanduanCell.h"
#import "TiankongCell.h"
#import "WendaCell.h"
#import "GetPageSubjectResultRequst.h"
#import "getBookSubjectResultRequst.h"
@interface ExerciseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSMutableArray *Array1;
@property (nonatomic,strong)NSMutableArray *Array2;
@property (nonatomic,strong)NSMutableArray *Array3;
@property (nonatomic,strong)NSMutableArray *Array4;
@property (nonatomic,strong)NSMutableArray *Array5;
@property (nonatomic,strong)NSMutableArray *tixingArray;
@property (nonatomic,strong)NSMutableArray *titleArray;

@property (nonatomic,strong)NSMutableArray *testArray;
@end

@implementation ExerciseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DanxuanCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[DuoXuanCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[PanduanCell class] forCellReuseIdentifier:@"cell3"];
        [_tableView registerClass:[TiankongCell class] forCellReuseIdentifier:@"cell4"];
        [_tableView registerClass:[WendaCell class] forCellReuseIdentifier:@"cell5"];
        
    }
    return _tableView;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(NSMutableArray *)Array1{
    if (!_Array1) {
        _Array1 = [[NSMutableArray alloc]init];
    }
    return _Array1;
}
-(NSMutableArray *)Array2{
    if (!_Array2) {
        _Array2 = [[NSMutableArray alloc]init];
    }
    return _Array2;
}
-(NSMutableArray *)Array3{
    if (!_Array3) {
        _Array3 = [[NSMutableArray alloc]init];
    }
    return _Array3;
}
-(NSMutableArray *)Array4{
    if (!_Array4) {
        _Array4 = [[NSMutableArray alloc]init];
    }
    return _Array4;
}
-(NSMutableArray *)Array5{
    if (!_Array5) {
        _Array5 = [[NSMutableArray alloc]init];
    }
    return _Array5;
}
-(NSMutableArray *)tixingArray{
    
    if (!_tixingArray) {
        _tixingArray = [[NSMutableArray alloc]init];
    }
    return _tixingArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        
    }
    return _titleArray;
}
-(NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]init];
    }
    return _testArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"做题记录";
    [self.view addSubview:self.tableView];
    if ([self.strType isEqualToString:@"10"]) {
        [self getBookSubjectResult];
    }else if([self.strType isEqualToString:@"20"]){
        [self GetPageSubjectResult];
    }
    
}
//习题记录
-(void)getBookSubjectResult{
    
    getBookSubjectResultRequst *requst = [[getBookSubjectResultRequst alloc]init];
    [requst getBookSubjectResultRequstwithbookid:self.exerciseId withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [self gettestArray:json];
        [self.tableView reloadData];
    }];
    
}
//试题记录
-(void)GetPageSubjectResult{
    
    GetPageSubjectResultRequst *requst = [[GetPageSubjectResultRequst alloc]init];
    [requst GetPageSubjectResultRequstwithpageid:self.exerciseId withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [self gettestArray:json];
        [self.tableView reloadData];
    }];
    
}
-(void)gettestArray :(NSDictionary *)json{
    [self.Array1 removeAllObjects];
    [self.Array2 removeAllObjects];
    [self.Array3 removeAllObjects];
    [self.Array4 removeAllObjects];
    [self.Array5 removeAllObjects];
    [self.tixingArray removeAllObjects];
    
    
    for (NSDictionary *dic in json[@"ret_data"][@"SinCSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array1 addObject:model];
    }
    
    
    for (NSDictionary *dic in json[@"ret_data"][@"MuiCSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array2 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"PDSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array3 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"TKSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array4 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"WDSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array5 addObject:model];
    }
    if (self.Array1.count>0) {
        [self.tixingArray addObject:self.Array1];
        [self.titleArray addObject:@"单选题"];
        //             _titleArray = @[@"单选题",@"多选题",@"判断题",@"问答题",@"填空题"];
    }
    if (self.Array2.count>0) {
        [self.tixingArray addObject:self.Array2];
        [self.titleArray addObject:@"多选题"];
    }
    if (self.Array3.count>0) {
        [self.tixingArray addObject:self.Array3];
        [self.titleArray addObject:@"判断题"];
    }
    if (self.Array4.count>0) {
        [self.tixingArray addObject:self.Array4];
        [self.titleArray addObject:@"问答题"];
    }
    if (self.Array5.count>0) {
        [self.tixingArray addObject:self.Array5];
        [self.titleArray addObject:@"填空题"];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.tixingArray.count;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tixingArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DanxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    return cell;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ([self.tixingArray[section] count] > 0) {
        return 40;
//    }
//    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [backView addSubview:titleLabel];
    if ([self.tixingArray[section] count] > 0) {
        titleLabel.text = self.titleArray[section];
    }
    
    return backView;
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
