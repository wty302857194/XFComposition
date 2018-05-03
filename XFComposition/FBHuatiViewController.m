//
//  FBHuatiViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "FBHuatiViewController.h"
#import "FBHuatiFristCell.h"
#import "FBHuatiSecondCell.h"
#import "FBHuatiThridCell.h"
#import "MenuView.h"
#import "SaveTitleRequst.h"
@interface FBHuatiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)MenuView *menuView;
@property (nonatomic,strong)NSArray *menuarray;
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic,strong)NSString *TypeId;
@property (nonatomic,strong)NSArray *strArray;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation FBHuatiViewController
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
        [_tableView registerClass:[FBHuatiFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[FBHuatiSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[FBHuatiThridCell class] forCellReuseIdentifier:@"cell3"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _tableView;
}
-(MenuView *)menuView{
    if (!_menuView) {
        
        __weak typeof (self) weakSelf = self;
        _menuView = [[MenuView alloc]initWithFrame:CGRectMake(80, 127, WidthFrame-100, 30*self.menuarray.count) cellarray:self.menuarray block:^(NSInteger index) {
            weakSelf.isShow = NO;
            
            self.textField2.text = self.menuarray[index];
            self.TypeId = self.strArray[index];
        }];
        [self.tableView addSubview:_menuView];
    }
    return _menuView;
}
-(NSArray *)menuarray{
    if (!_menuarray) {
        _menuarray = [NSMutableArray array];
        _menuarray = @[@"新鲜事",@"教师作业",@"微课",@"阅读检测",@"教学",@"活动"];
    }
    return _menuarray;
}
-(NSArray *)strArray{
    if (!_strArray) {
        _strArray = [NSArray array];
        _strArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    }
    return _strArray;
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
    self.navigationItem.title = @"发布话题";
    [self.view addSubview:self.tableView];
}
//发布话题
-(void)fabu{
    SaveTitleRequst *requst = [[SaveTitleRequst alloc]init];
    [requst SaveTitleRequstwithtitleId:@"0" withgroupId:self.groupId withpostType:self.TypeId withtitleContent:self.textView.text withtitle:self.textField1.text withuserId:self.xf.Loginid :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue ] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功,等待审核"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 45;
    }else if (indexPath.row == 1){
        
        return 45;
        
    }else if (indexPath.row == 2){
        
        return HeightFrame/2+15;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FBHuatiFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.textField1 = [[UITextField alloc]init];
        self.textField1 = cell.textfield;
        return cell;
    }else if (indexPath.row == 1){
        FBHuatiSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        self.textField2 = [[UITextField alloc]init];
        self.textField2 = cell.textfield;
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(80, 5, WidthFrame-100, 35);
        [bt addTarget:self action:@selector(showmenu) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.menuarray.count>0) {
            self.textField2.text = self.menuarray[0];
            self.TypeId = self.strArray[0];
        }
        [cell addSubview:bt];
        return cell;
        
    }else if (indexPath.row == 2){
        FBHuatiThridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        self.textView = [[UITextView alloc]init];
        self.textView = cell.textView;
        return cell;
        
    }
    return nil;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 60;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 60)];
    backview.backgroundColor = [UIColor whiteColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(WidthFrame/4, 20, WidthFrame/2, 40);
    [bt setTitle:@"发布" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
    bt.layer.cornerRadius = 6;
    bt.layer.masksToBounds = YES;
    [bt setBackgroundColor:[UIColor colorWithHexString:@"F1AF49"]];
    [backview addSubview:bt];
    return backview;
}
-(void)showmenu{
    _isShow = !_isShow;
    if (_isShow) {
        [self.menuView showView];
        
    }else{
        [self.menuView dismissView];
        
    }
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
