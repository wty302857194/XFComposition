//
//  AddTestViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "AddTestViewController.h"
#import "AddTestCell.h"
#import "GetMyPageSubjectListRequst.h"
#import "GetMyPageSubjectListModel.h"
//#import "GetActiveSubectByGuiZeRequst.h"
#import "GetActiveSubectByGuiZeModel.h"

#import "SaveMypageRequst.h"
#import "MarkTestView.h"
#import "MarkSDView.h"
#import "PreviewTestViewController.h"
#import "MenuView.h"
@interface AddTestViewController ()<UITableViewDelegate,UITableViewDataSource,AddTestCellDelegate,MarkTestViewDelegate,MarkSDViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UILabel *scoreLabel;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *testArray;
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic, strong) NSString * typeid;
@property (nonatomic,strong)NSMutableArray *tabBtnArray;

@property (nonatomic,strong)NSArray *btArray;
@property (nonatomic,strong)NSArray *numArray;
@property (nonatomic,strong)XFUserInfo *xf;

@property (nonatomic,strong)MarkTestView *testView;
@property (nonatomic,strong)MarkSDView *SDView;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,strong)NSArray *menuarray1;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)GetActiveSubectByGuiZeModel *guizeModel;
@property (nonatomic,strong)NSString *allCount;
@property (nonatomic,assign)NSInteger allScore;
@property (nonatomic,strong)NSArray *xinArray;

@property (nonatomic,strong)NSMutableArray *idsArray;

@property (nonatomic,assign)NSInteger danxuanNub;
@property (nonatomic,assign)NSInteger duoxuanNub;
@property (nonatomic,assign)NSInteger panduanNub;
@property (nonatomic,assign)NSInteger wendaNub;
@property (nonatomic,assign)NSInteger tiankongNub;
@property (nonatomic,strong)NSString *typestr;

@end

@implementation AddTestViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self leftBarButton];
}

-(NSArray *)menuarray1{
    if (!_menuarray1) {
        _menuarray1 = [NSArray array];
        _menuarray1 = @[@"私人题库",@"公共题库"];
    }
    return _menuarray1;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+52, kScreenWidth, 60*self.menuarray1.count) cellarray:self.menuarray1 block:^(NSInteger index) {
            weakSelf.isShow1 = NO;
            self.page = 1;
            if (index == 0) {
                [self.bt2 setTitle:@"私人题库" forState: UIControlStateNormal];
                self.typeid = @"0";
            }else if (index == 1){
                self.typeid = @"1";
                [self.bt2 setTitle:@"公共题库" forState: UIControlStateNormal];
            }
            [weakSelf.tableView.mj_header beginRefreshing];
            
        }];
        [self.view addSubview:_menuView1];
    }
    return _menuView1;
}
-(void)creatHeadView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bt1.frame = CGRectMake(0, 10+SafeAreaTopHeight, 80, 30);
    [self.bt1 setTitle:@"全部题库" forState:UIControlStateNormal];
    self.bt1.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self.bt1 setTitleColor:hexColor(333333) forState:UIControlStateNormal];
    [self.bt1 addTarget:self action:@selector(showtype :) forControlEvents:UIControlEventTouchUpInside];
    
    self.bt1.layer.cornerRadius = 2;
    [self.view addSubview:self.bt1];
    
    
    UIImageView * imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(90, 10, 0.5, 20)];
    imgeView.backgroundColor = hexColor(e5e5e5);
    [view addSubview:imgeView];
    
    self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bt2.layer.cornerRadius = 2;
    self.bt2.frame = CGRectMake(100, 10+SafeAreaTopHeight, 80, 30);
    [self.bt2 setTitle:@"私人题库" forState:UIControlStateNormal];
    self.bt2.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.bt2 setTitleColor:hexColor(333333) forState:UIControlStateNormal];
    [self.bt2 addTarget:self action:@selector(ggshiti) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bt2];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(200, 10+SafeAreaTopHeight, WidthFrame-290, 30)];
    self.textfield.placeholder = @"关键词";
    self.textfield.layer.cornerRadius = 6;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.borderWidth = 0.5;
    self.textfield.font = [UIFont systemFontOfSize:14];
    self.textfield.layer.borderColor = [[UIColor colorWithHexString:@"D4D5D4"] CGColor];
    self.textfield.clearButtonMode=YES;
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.textfield];
    
    UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbt.frame = CGRectMake(CGRectGetMaxX(self.textfield.frame)+8, 10+SafeAreaTopHeight, 50, 30);
    [selectbt setTitle:@"搜索" forState:UIControlStateNormal];
    [selectbt addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    selectbt.titleLabel.font = [UIFont systemFontOfSize:14];
    [selectbt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    selectbt.layer.cornerRadius =6;
    selectbt.layer.masksToBounds = YES;
    [self.view addSubview:selectbt];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bt1.frame)+10, WidthFrame , 40)];
    scrollView.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
    self.tabBtnArray = [[NSMutableArray alloc]init];
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat z= 0.0;
    for (int i = 0; i<self.btArray.count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor redColor];
        label.layer.cornerRadius = 8;
        label.layer.masksToBounds = YES;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 3000+i;
        if (self.numArray.count>0) {
            if ([self.numArray[i] integerValue] == 0) {
                label.hidden = YES;
            }else{

                label.hidden = NO;
            }
            label.text = self.numArray[i];
        }else{
            label.hidden = YES;

        }
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.btArray[i] forState:UIControlStateNormal];
        bt.tag = 5000+i;
        bt.layer.cornerRadius = 2;
        bt.layer.masksToBounds = YES;
        [bt setBackgroundColor:[UIColor colorWithHexString:@"7DCDF3"]];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:13.0];
        CGSize titleSize = [self.btArray[i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:bt.titleLabel.font.fontName size:bt.titleLabel.font.pointSize]}];
        
        titleSize.width +=20;
        CGFloat flo = titleSize.width;
        
        bt.frame = CGRectMake(20+z, 10, titleSize.width, 20);
        label.frame = CGRectMake(17+z+flo, 5, 16, 16);
        
        z= flo +z+15;
        
        scrollView.contentSize = CGSizeMake((titleSize.width+30)*(self.btArray.count), 20);
        [scrollView addSubview:bt];
        [scrollView addSubview:label];
        [self.tabBtnArray addObject:bt];
        
    }
    [self.view addSubview:scrollView];
    
}
-(void)creatFooterView{
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame-60-SafeAreaBottomHeight, WidthFrame/3, 30)];
    self.numLabel.text = [NSString stringWithFormat:@"已选择试题（%@）",self
                          .allCount];
    self.numLabel.font = [UIFont systemFontOfSize:14];
    self.numLabel.backgroundColor = [UIColor whiteColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numLabel];
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightFrame-30-SafeAreaBottomHeight, WidthFrame/3, 30)];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"总分（%ld）",(long)self.allScore];
    self.scoreLabel.backgroundColor = [UIColor whiteColor];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.scoreLabel];
    UIButton *messagebt = [UIButton buttonWithType:UIButtonTypeCustom];
    messagebt.frame = CGRectMake(WidthFrame/3, HeightFrame-60- SafeAreaBottomHeight, WidthFrame/3, 60);
    [messagebt setTitle:@"预览试卷" forState:UIControlStateNormal];
    [messagebt setBackgroundColor:[UIColor colorWithHexString:@"F3A832"]];
    [messagebt addTarget:self action:@selector(yulan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messagebt];
    
    UIButton *tjbt = [UIButton buttonWithType:UIButtonTypeCustom];
    tjbt.frame = CGRectMake(WidthFrame/3*2, HeightFrame-60- SafeAreaBottomHeight, WidthFrame/3, 60);
    [tjbt setTitle:@"保存试卷" forState:UIControlStateNormal];
    [tjbt setBackgroundColor:[UIColor colorWithHexString:@"3690CE"]];
    [tjbt addTarget:self action:@selector(baocunshijuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tjbt];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight+90, WidthFrame, HeightFrame-SafeAreaTopHeight-90-60-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
        [_tableView registerClass:[AddTestCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(MarkTestView *)testView{
    if (!_testView) {
        _testView = [[MarkTestView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _testView.delegate = self;
    }
    return _testView;
}
-(MarkSDView *)SDView{
    
    if (!_SDView) {
        _SDView = [[MarkSDView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _SDView.delegate = self;
        [self.view addSubview:_SDView];
    }
    return _SDView;
}
-(NSArray *)btArray{
    if (!_btArray) {
        _btArray = @[@"单选题",@"多选题",@"判断题",@"问答题",@"填空题"];
    }
    return _btArray;
}

-(NSArray *)numArray{
    if (!_numArray) {
        _numArray = [NSArray array];
    }
    return _numArray;
}
-(NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]init];
    }
    return _testArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
-(GetActiveSubectByGuiZeModel *)guizeModel{
    
    if (!_guizeModel) {
        _guizeModel = [[GetActiveSubectByGuiZeModel alloc]init];
    }
    return _guizeModel;
}
-(NSArray *)xinArray{
    if (!_xinArray) {
        _xinArray = [NSArray array];
    }
    return _xinArray;
}
-(NSMutableArray *)idsArray{
    if (!_idsArray) {
        _idsArray = [[NSMutableArray alloc]init];
    }
    return _idsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeadView];
    self.typestr = @"0";
    self.typeid = @"0";
    self.allCount = @"0";
    self.allScore = 0;
    self.danxuanNub = 0;
    self.duoxuanNub = 0;
    self.panduanNub = 0;
    self.wendaNub = 0;
    self.tiankongNub = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.testView];
    [self creatFooterView];
    self.xf = [XFUserInfo getUserInfo];
    self.navigationItem.title = @"添加试卷";
    self.view.backgroundColor = hexColor(e8f2fa);
    self.page = 1;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetMyPageSubjectList :self.typestr];
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
-(void)GetMyPageSubjectList :(NSString *)chaperid{
    __weak typeof (self) weakSelf = self;
    GetMyPageSubjectListRequst *requst = [[GetMyPageSubjectListRequst alloc]init];
    [requst GetMyPageSubjectListRequstwithPageIndex:@"1" withPageSize:@"20" withchaperid:chaperid withkeyword:self.textfield.text withscheckype:weakSelf.typeid withActiveid:@"0" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [weakSelf.testArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMyPageSubjectListModel *model = [GetMyPageSubjectListModel loadWithJSOn:dic];
            [weakSelf.testArray addObject:model];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:0];    //刷新第3段
            [weakSelf.tableView reloadSections:indexSetA withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    }];
    
}
-(void)requstMore{
    self.page +=1;
    __weak typeof (self) weakSelf = self;
    GetMyPageSubjectListRequst *requst = [[GetMyPageSubjectListRequst alloc]init];
    [requst GetMyPageSubjectListRequstwithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withchaperid:self.typestr withkeyword:self.textfield.text withscheckype:weakSelf.typeid withActiveid:@"0" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMyPageSubjectListModel *model = [GetMyPageSubjectListModel loadWithJSOn:dic];
            [weakSelf.testArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
         
            [weakSelf.tableView reloadData];
        });
    }];
    
}
-(void)showtype :(UIButton *)bt{
    
    for (UIButton *btn in self.tabBtnArray) {
        if (btn.tag == bt.tag) {
            [btn setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }
    _typestr = @"0";
    [_tableView.mj_header beginRefreshing];

}
-(void)ggshiti{
    _isShow1 = !_isShow1;
    if (_isShow1) {
        [self.menuView1 showView];
    }else{
        [self.menuView1 dismissView];
    }
    
}
-(void)sousuo{

}
-(void)gengxinnimabi:(UIButton *)bt{

    GetMyPageSubjectListModel *Model = self.testArray[bt.tag - 1000];
    if ([self.idsArray containsObject:[NSString stringWithFormat:@"%@",Model.SubjectID]]){
        if (Model.SubjectType  == 1) {
            self.danxuanNub -=1;
        }else if (Model.SubjectType  == 2){
            self.duoxuanNub -=1;
            
        }else if (Model.SubjectType  == 3){
            self.panduanNub -=1;
            
        }else if (Model.SubjectType  == 4){
            self.wendaNub -=1;
            
        }else if (Model.SubjectType  == 5){
            self.tiankongNub -=1;
            
        }
        [self.idsArray removeObject:[NSString stringWithFormat:@"%@",Model.SubjectID]];
        self.allScore = self.allScore -[Model.SubjectSocre integerValue];
    }else{
        
        
        if (Model.SubjectType  == 1) {
            self.danxuanNub +=1;
        }else if (Model.SubjectType  == 2){
            self.duoxuanNub +=1;
            
        }else if (Model.SubjectType  == 3){
            self.panduanNub +=1;
            
        }else if (Model.SubjectType  == 4){
            self.wendaNub +=1;
            
        }else if (Model.SubjectType  == 5){
            self.tiankongNub +=1;
            
        }

        [self.idsArray addObject:[NSString stringWithFormat:@"%@",Model.SubjectID]];
        self.allScore = self.allScore +[Model.SubjectSocre integerValue];
    }
    self.allCount = [NSString stringWithFormat:@"%lu",(unsigned long)self.idsArray.count];


    
    self.numArray = @[[NSString stringWithFormat:@"%ld",(long)self.danxuanNub],[NSString stringWithFormat:@"%ld",(long)self.duoxuanNub],[NSString stringWithFormat:@"%ld",(long)self.panduanNub],[NSString stringWithFormat:@"%ld",(long)self.wendaNub],[NSString stringWithFormat:@"%ld",(long)self.tiankongNub]];
    
    if (self.numArray.count>0) {
        for (int i = 0; i< self.numArray.count; i++) {
            
            UILabel * label = [self.view viewWithTag:3000+i];
            
            if ([self.numArray[i] integerValue] == 0) {
                label.hidden = YES;
            }else{
                
                label.hidden = NO;
            }
            label.text = self.numArray[i];
        }
    }else{
        
        
    }
   
    [_tableView reloadData];
    
    self.numLabel.text = [NSString stringWithFormat:@"已选择试题（%@）",self
                          .allCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"总分（%ld）",(long)self.allScore];

    

}
//刷新界面
-(void)sureMake:(GetActiveSubectByGuiZeModel *)model :(NSString *)str{

    self.guizeModel = model;
    self.allCount = [NSString stringWithFormat:@"%ld",(long)model.allCount];
    self.allScore =  model.allSocre;
    
    
    self.danxuanNub = model.danxuanNum;
    self.duoxuanNub = model.duoxuanNum;
    self.panduanNub = model.panduanNum;
    self.wendaNub = model.wendaNum;
    self.tiankongNub = model.tiankongNum;
    self.numArray = @[[NSString stringWithFormat:@"%ld",(long)model.danxuanNum],[NSString stringWithFormat:@"%ld",(long)model.duoxuanNum],[NSString stringWithFormat:@"%ld",(long)model.panduanNum],[NSString stringWithFormat:@"%ld",(long)model.wendaNum],[NSString stringWithFormat:@"%ld",(long)model.tiankongNum]];
    
    self.idsArray = [str componentsSeparatedByString:@","];
    [self.tableView reloadData];
}
//自动保存生成试卷
-(void)SaveTest:(NSString *)str1 :(NSString *)str2 :(NSString *)str3 :(NSString *)str4 :(NSString *)str5 :(NSString *)str6 :(NSString *)str7 :(NSString *)str8{
    __weak typeof (self) weakSelf = self;
    SaveMypageRequst *requst = [[SaveMypageRequst alloc]init];
    [requst SaveMypageRequstwithpagename:str1 withpagesocre:str2 withpageinfo:str3 withactiveid:str4 withpagetime:str5 withsubjectids:str6 withpageoksocer:str7 withuserid:str8 :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue] == 0) {
            [MBProgressHUD showError:@"添加成功"];
            [weakSelf.testView dissMiss];
            PreviewTestViewController *vc = [[PreviewTestViewController alloc]init];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                vc.ids = str6;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            });
            
        }
    }];
    
}
//手动设置保存试卷
-(void)baocunshijuan{
    [self.SDView showView];
    
}
-(void)shoudongbaocun:(NSString *)str1 :(NSString *)str2 :(NSString *)str3 :(NSString *)str4 :(NSString *)str5{
    __weak typeof (self) weakSelf = self;
    SaveMypageRequst *requst = [[SaveMypageRequst alloc]init];
    
    [requst SaveMypageRequstwithpagename:str1 withpagesocre:[NSString stringWithFormat:@"%ld",(long)self.allScore] withpageinfo:str2 withactiveid:@"0" withpagetime:str3 withsubjectids:[self.idsArray componentsJoinedByString:@","] withpageoksocer:str4 withuserid:self.xf.Loginid :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [weakSelf.SDView dissMiss];
            PreviewTestViewController *vc = [[PreviewTestViewController alloc]init];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                vc.ids = [self.idsArray componentsJoinedByString:@","];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            });
            
        }
    }];
    
}
-(void)yulan{
    PreviewTestViewController *vc = [[PreviewTestViewController alloc]init];
    vc.ids = [self.idsArray componentsJoinedByString:@","];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//点击各种题型筛选
-(void)click:(UIButton *)bt{
    self.page = 1;
    for (UIButton *btn in self.tabBtnArray) {
        if (btn.tag == bt.tag) {
            [btn setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        }
        
    }
    if (bt.tag == 5000) {
        self.typestr = @"1";
        [self GetMyPageSubjectList :@"1"];
        
    }else if (bt.tag == 5001){
        self.typestr = @"2";
        [self GetMyPageSubjectList :@"2"];
    
    }else if (bt.tag == 5002){
        self.typestr = @"3";
        [self GetMyPageSubjectList :@"3"];
        
    }else if (bt.tag == 5003){
        self.typestr = @"4";
        [self GetMyPageSubjectList :@"4"];
        
    }else if (bt.tag == 5004){
        self.typestr = @"5";
        [self GetMyPageSubjectList :@"5"];
        
    }
}
-(void)chakan:(UIButton *)bt{
    GetMyPageSubjectListModel *Model = self.testArray[bt.tag - 2000];
    PreviewTestViewController *vc = [[PreviewTestViewController alloc]init];
    vc.ids = [NSString stringWithFormat:@"%@",Model.SubjectID];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   
    return self.testArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    GetMyPageSubjectListModel *Model = self.testArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[AddTestCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AddTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GetMyPageSubjectListModel *Model = self.testArray[indexPath.row];
    cell.model = Model;
    cell.bt1.tag = 1000+indexPath.row;
    cell.bt2.tag = 2000 +indexPath.row;
    cell.delegate = self;

    if ([self.idsArray containsObject:[NSString stringWithFormat:@"%@",Model.SubjectID]]) {
        [cell.bt1 setImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateNormal];
        cell.joinbt.text = @"移除试卷";
    }else{
        [cell.bt1 setImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
        cell.joinbt.text = @"加入试卷";
    }

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
