//
//  BookRankViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookRankViewController.h"
#import "BookRankTableViewCell.h"
#import "GetReadStartRequst.h"
#import "GetReadStartModel.h"
@interface BookRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *btArray;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *rankArray;
@property (nonatomic,strong)NSString *strFlag;
@property (nonatomic,assign)NSInteger pagesize;
@end

@implementation BookRankViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(NSArray *)btArray{
    if (!_btArray) {
        _btArray = @[@"阅读之星排行",@"区排行",@"校排行",@"班级排行"];
    }
    return _btArray;
}
-(NSMutableArray *)rankArray{
    if (!_rankArray) {
        _rankArray = [[NSMutableArray alloc]init];
    }
    return _rankArray;
}
-(void)creatHeadView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame , 40)];
    [self.view addSubview:scrollView];
    self.tabBtnArray = [[NSMutableArray alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat z= 0.0;
    for (int i = 0; i<self.btArray.count; i++) {
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
        bt.tag = 1000+i;
        
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        CGSize titleSize = [self.btArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:bt.titleLabel.font.fontName size:bt.titleLabel.font.pointSize]}];
        
        
        titleSize.width +=20;
        CGFloat flo = titleSize.width;
        
        
        
        bt.frame = CGRectMake(20+z, 0, titleSize.width, 40);
        z= flo +z+15;
        
        scrollView.contentSize = CGSizeMake((titleSize.width+30)*(self.btArray.count+1), 40);
        [scrollView addSubview:bt];
        [self.tabBtnArray addObject:bt];
        if (i == 0) {
            [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
        }
    }
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WidthFrame, HeightFrame-64-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BookRankTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"读书排行";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self creatHeadView];
    self.strFlag =@"0";
    self.pagesize = 15;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self ReadStartRequst:@"0"];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
//        
//        
//        [self requstMore];
//        [self.tableView.mj_footer endRefreshing];
//    }];

}
//获取阅读排行
-(void)ReadStartRequst :(NSString *)flag{
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:flag withnum:@"15" :^(NSDictionary *json) {
        [self.rankArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [self.rankArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    
}
-(void)requstMore {
    self.pagesize +=10;
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:self.strFlag withnum:[NSString stringWithFormat:@"%ld",(long)self.pagesize] :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [self.rankArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];

}
-(void)click:(UIButton *)bt{
    for (UIButton *button in self.tabBtnArray){
        if (button.tag == bt.tag){
            [button setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }
    if (bt.tag == 1000) {
        self.strFlag = @"0";
        self.pagesize = 15;
        [self ReadStartRequst:@"0"];
    }else if (bt.tag == 1001){
        self.strFlag = @"2";
        self.pagesize = 15;
        [self ReadStartRequst:@"2"];
    }else if (bt.tag == 1002){
        self.strFlag = @"1";
        self.pagesize = 15;
        [self ReadStartRequst:@"1"];
        
    }else if (bt.tag == 1003){
        self.strFlag = @"3";
        self.pagesize = 15;
        [self ReadStartRequst:@"3"];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.rankArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GetReadStartModel *Model = self.rankArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[BookRankTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    GetReadStartModel *Model = self.rankArray[indexPath.row];
    cell.model = Model;

    if (indexPath.row<3) {
        cell.imgView.backgroundColor = [UIColor lightGrayColor];
        cell.imgView.hidden = NO;
        cell.numLabel.hidden = YES;
    }else {
        cell.imgView.hidden = YES;
        cell.numLabel.hidden = NO;
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }
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
