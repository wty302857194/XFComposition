//
//  MyWritingsViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyWritingsViewController.h"

#import "MywritingCell.h"

#import "MenuView.h"
#import "ShowMywriting.h"
#import "ShowContentView.h"

#import "GetBlogContentInfoRequst.h"//习作内容
#import "GetWriteListRequst.h"

#import "MywritingModel.h"
#import "MicroAddcommentRequst.h"
#import "DeleteBlogRequst.h"
@interface MyWritingsViewController ()<UITableViewDelegate,UITableViewDataSource,MywritingCellDelegate,ShowMywritingDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *btTitleArray;
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,strong)MenuView *menuView2;
@property (nonatomic,strong)MenuView *menuView3;
@property (nonatomic,strong)MenuView *menuView4;
@property (nonatomic,strong)NSArray *menuarray1;
@property (nonatomic,strong)NSArray *menuarray2;
@property (nonatomic,strong)NSArray *menuarray3;
@property (nonatomic,strong)NSArray *menuarray4;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,assign)BOOL isShow2;
@property (nonatomic,assign)BOOL isShow3;
@property (nonatomic,assign)BOOL isShow4;

@property (nonatomic,strong)NSMutableArray *writingArray;
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NSString *typeid;
@property (nonatomic,strong)NSString *gardeid;
@property (nonatomic,strong)NSString *ishost;
@property (nonatomic,strong)NSString *istuijian;

@property (nonatomic,strong)ShowMywriting *showView;
@property (nonatomic,strong)ShowContentView *contentView;
@property (nonatomic,strong)NSString *saveId;

@property (nonatomic,strong)NSMutableArray *xuanzhongArray;
@end

@implementation MyWritingsViewController
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
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20, 5+64, WidthFrame-155, 30)];
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
    
    UIButton *shanchubt = [UIButton buttonWithType:UIButtonTypeCustom];
    shanchubt.frame = CGRectMake(CGRectGetMaxX(selectbt.frame)+5, 5+64, 50, 30);
    [shanchubt setTitle:@"删除" forState:UIControlStateNormal];
    shanchubt.titleLabel.font = [UIFont systemFontOfSize:16];

    [shanchubt addTarget:self action:@selector(duoxuanshanchu) forControlEvents:UIControlEventTouchUpInside];
    [shanchubt setBackgroundColor:[UIColor colorWithHexString:@"E63E32"]];
    shanchubt.layer.cornerRadius =6;
    shanchubt.layer.masksToBounds = YES;
    [self.view addSubview:shanchubt];
    NSArray *array = [[NSArray alloc]init];
    array = @[@"全部分类",@"习作状态",@"是否热点",@"是否推荐"];
    
    for (int i = 0; i<4; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(WidthFrame/4*i, CGRectGetMaxY(self.textfield.frame)+10, WidthFrame/4, 40);
        bt.tag = 1000+i;
        [bt setTitle:array[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bt];
    }
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+80, WidthFrame, HeightFrame-64-80) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MywritingCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(ShowMywriting *)showView{

    if (!_showView) {
        _showView = [[ShowMywriting alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _showView.delegate = self;
        [self.view addSubview:_showView];
    }
    return _showView;
}
-(ShowContentView *)contentView{
    if (!_contentView) {
        _contentView = [[ShowContentView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        [self.view addSubview:self.contentView];
    }
    return _contentView;
}
-(NSArray *)btTitleArray{
    if (!_btTitleArray) {
        _btTitleArray = [[NSArray alloc]init];
        _btTitleArray = @[@"全部分类",@"习作状态",@"是否热点",@"是否推荐"];
    }
    return _btTitleArray;
}
-(NSMutableArray *)writingArray{
    if (!_writingArray) {
        _writingArray = [[NSMutableArray alloc]init];
    }
    return _writingArray;
}
-(NSArray *)menuarray1{
    if (!_menuarray1) {
        _menuarray1 = [NSArray array];
        
    }
    return _menuarray1;
}
-(NSArray *)menuarray2{
    if (!_menuarray2) {
        _menuarray2 = [NSArray array];
        
    }
    return _menuarray2;
}
-(NSArray *)menuarray3{
    if (!_menuarray3) {
        _menuarray3 = [NSArray array];
        
    }
    return _menuarray3;
}
-(MenuView *)menuView1{
    if (_menuView1) {
        return _menuView1;
    }
    
    
    __weak typeof (self) weakSelf = self;
    _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(5,64+80,WidthFrame/4-10,30*self.menuarray1.count) cellarray:self.menuarray1 block:^(NSInteger index) {
        weakSelf.isShow1 = NO;
        self.page = 1;
        if (index == 0) {
            self.gardeid = @"0";
        }else if (index == 1){
            self.gardeid = @"5";
        }else if (index == 2){
            self.gardeid = @"7";
        }else if (index == 3){
            self.gardeid = @"4";
        }
        [weakSelf requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
        
    }];
    
    [self.view addSubview:_menuView1];
    return _menuView1;
}

-(MenuView *)menuView2{
    if (!_menuView2) {
        __weak typeof (self) weakSelf = self;
        _menuView2 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/4+5, 64+80, WidthFrame/4-10, 30*self.menuarray2.count) cellarray:self.menuarray2 block:^(NSInteger index) {
            weakSelf.isShow2 = NO;
            self.page = 1;
            if (index == 0) {
                self.typeid = @"-1";
            }else if (index == 1){
                self.typeid = @"0";
            }else if (index == 2){
                self.typeid = @"1";
            }
            [weakSelf requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
            
        }];
        [self.view addSubview:_menuView2];
    }
    return _menuView2;
}
-(MenuView *)menuView3{
    if (!_menuView3) {
        __weak typeof (self) weakSelf = self;
        _menuView3 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/2+5, 64+80, WidthFrame/4-10, 30*self.menuarray3.count) cellarray:self.menuarray3 block:^(NSInteger index) {
            weakSelf.isShow3 = NO;
            self.page = 1;
            if (index == 0) {
                self.ishost = @"-1";
            }else if (index == 1){
                self.ishost = @"0";
            }else if (index == 2){
                self.ishost = @"1";
            }
            [weakSelf requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
        }];
        [self.view addSubview:_menuView3];
    }
    return _menuView3;
}
-(MenuView *)menuView4{
    if (!_menuView4) {
        __weak typeof (self) weakSelf = self;
        _menuView4 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/4*3+5, 64+80, WidthFrame/4-10, 30*self.menuarray4.count) cellarray:self.menuarray4 block:^(NSInteger index) {
            weakSelf.isShow4 = NO;
            self.page = 1;
            if (index == 0) {
                self.istuijian = @"-1";
            }else if (index == 1){
                self.istuijian = @"0";
            }else if (index == 2){
                self.istuijian = @"1";
            }
            [weakSelf requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
        }];
        [self.view addSubview:_menuView4];
    }
    return _menuView4;
}
-(NSString *)saveId{
    if (!_saveId) {
        _saveId = [[NSString alloc]init];
    }
    return _saveId;
}
-(NSMutableArray *)xuanzhongArray{
    if (!_xuanzhongArray) {
        _xuanzhongArray = [NSMutableArray array];
    }
    return _xuanzhongArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的习作";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.typeid = @"-1";
    self.gardeid = @"0";
    self.ishost = @"-1";
    self.istuijian = @"-1";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requst :@"0" :@"0" :@"-1" :@"-1"];
        
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore:self.typeid :self.gardeid :self.ishost :self.istuijian];
        [self.tableView.mj_footer endRefreshing];
    }];

    
    
    [self creatHeadView];
    [self.view addSubview:self.tableView];

    
}

-(void)requst :(NSString *)typeid :(NSString *)gardeid :(NSString *)ishost :(NSString *)istuijian{
    __weak typeof (self) weakSelf = self;
    GetWriteListRequst *requst = [[GetWriteListRequst alloc]init];
    
    [requst GetWriteListRequstWithPageIndex:@"1" withPageSize:@"10" withuserid:self.myWritingUserid withtypeid:typeid withgardeId:gardeid withishost:ishost withistuijian:istuijian withlabelid:@"0" withkeyword:@"" BlogStatic:@"":^(NSDictionary *json) {

        
        [weakSelf.writingArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            MywritingModel *model = [MywritingModel loadWithJSOn:dic];
            [weakSelf.writingArray addObject:model];

        }
        [weakSelf.tableView reloadData];


    }];

}
-(void)requstMore :(NSString *)typeid :(NSString *)gardeid :(NSString *)ishost :(NSString *)istuijian{
    self.page+=1;
    GetWriteListRequst *requst = [[GetWriteListRequst alloc]init];
    
    [requst GetWriteListRequstWithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"10" withuserid:self.myWritingUserid withtypeid:typeid withgardeId:gardeid withishost:ishost withistuijian:istuijian withlabelid:@"0" withkeyword:@"" BlogStatic:@"" :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            MywritingModel *model = [MywritingModel loadWithJSOn:dic];
            [self.writingArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.writingArray.count;
    
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MywritingModel *Model = self.writingArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[MywritingCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MywritingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    MywritingModel *Model = self.writingArray[indexPath.row];
    cell.model = Model;
    cell.bt1.tag = 5000 + indexPath.row;
    cell.label1.tag = 1000+indexPath.row;
    cell.bt4.tag = 2000+indexPath.row;
    cell.bt5.tag = 3000+indexPath.row;
    
    if ([self.xuanzhongArray containsObject:[NSString stringWithFormat:@"%ld",(long)Model.ID]]) {
        [cell.bt1 setImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateNormal];
//        cell.joinbt.text = @"移除试卷";
    }else{
        [cell.bt1 setImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
//        cell.joinbt.text = @"加入试卷";
    }
    return cell;

}

-(void)showMenu :(UIButton *)bt{
    
    if (bt.tag == 1000) {
        self.menuarray1 = @[@"全部分类",@"微课习作",@"活动习作",@"独立习作"];
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.menuView1 showView];
        }else{
            [self.menuView1 dismissView];
        }
        
    }else if (bt.tag == 1001){
        self.menuarray2 = @[@"习作状态",@"可编辑",@"不可编辑"];
        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.menuView2 showView];
        }else{
            [self.menuView2 dismissView];
        }

        
    }else if (bt.tag == 1002){
        self.menuarray3 = @[@"是否热点",@"非热点",@"热点"];
        _isShow3 = !_isShow3;
        if (_isShow3) {
            [self.menuView3 showView];
        }else{
            [self.menuView3 dismissView];
        }
        
        
    }else if (bt.tag == 1003){
        self.menuarray4 = @[@"是否推荐",@"非推荐",@"推荐"];
        _isShow4 = !_isShow4;
        if (_isShow4) {
            [self.menuView4 showView];
        }else{
            [self.menuView4 dismissView];
        }
        
        
    }

}
//多删
-(void)duoxuanshanchu{
    DeleteBlogRequst *requst = [[DeleteBlogRequst alloc]init];
    [requst DeleteBlogRequstWithNoticeIds:[self.xuanzhongArray componentsJoinedByString:@","] withUserid:self.myWritingUserid withFlag:@"7" :^(NSDictionary *json) {
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //刷新数据
                [self requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
                [self.xuanzhongArray removeAllObjects];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}
-(void)xuanzhong:(UIButton *)bt{
    MywritingModel *model = self.writingArray[bt.tag - 5000];
    if ([self.xuanzhongArray containsObject:[NSString stringWithFormat:@"%ld",(long)model.ID]]) {
        [self.xuanzhongArray removeObject:[NSString stringWithFormat:@"%ld",(long)model.ID]];
    }else{
        [self.xuanzhongArray addObject:[NSString stringWithFormat:@"%ld",(long)model.ID]];
        
    }
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:bt.tag-5000 inSection:0]; //刷新第2段第N行
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA, nil] withRowAnimation:UITableViewRowAnimationNone];
}
//显示作文
-(void)showContent:(UIButton *)bt{
    MywritingModel *model = self.writingArray[bt.tag - 1000];
    GetBlogContentInfoRequst *requst = [[GetBlogContentInfoRequst alloc]init];
    
    [requst GetBlogContentInfoRequstWithNoticeID:[NSString stringWithFormat:@"%ld",(long)model.ID] :^(NSDictionary *json) {
        
        
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contentView showView];
            });
            
            NSString *str1 = [self htmlEntityDecode:json[@"ret_data"]];
            NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
            self.contentView.textview.attributedText = attributeStr;
            self.contentView.titletextfield.text = model.BlogTitle;
            
        }
    }];
    

}
//修改
-(void)modify:(UIButton *)bt{
    
    MywritingModel *model = self.writingArray[bt.tag - 2000];
    self.saveId = [NSString stringWithFormat:@"%ld",(long)model.ID];
    GetBlogContentInfoRequst *requst = [[GetBlogContentInfoRequst alloc]init];
    
    [requst GetBlogContentInfoRequstWithNoticeID:[NSString stringWithFormat:@"%ld",(long)model.ID] :^(NSDictionary *json) {
        
        
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.showView showView];
            });
            NSString *str1 = [self htmlEntityDecode:json[@"ret_data"]];
            NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
            self.showView.titletextfield.text = model.BlogTitle;
            self.showView.textview.attributedText = attributeStr;
            
        }
    }];

}

//删除
-(void)deleteCell:(UIButton *)bt{
    MywritingModel *model = self.writingArray[bt.tag - 3000];
    DeleteBlogRequst *requst = [[DeleteBlogRequst alloc]init];
    [requst DeleteBlogRequstWithNoticeIds:[NSString stringWithFormat:@"%ld",(long)model.ID] withUserid:self.myWritingUserid withFlag:@"7" :^(NSDictionary *json) {
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //刷新数据
                [self requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    

}
//保存
-(void)Savezuowen{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.showView.textview.text];
//    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.showView.textview.text];
//    NSLog(@"富文本%@",attributedString1);
    
    MicroAddcommentRequst *requst = [[MicroAddcommentRequst alloc]init];
    [requst GetMricoAddpianduanrequsWithNoticeName:self.showView.titletextfield.text withNoticeObject:@"" withNoticeContment:attributedString withNoticeId:self.saveId withUserId:self.myWritingUserid :^(NSDictionary *json) {
        
        
        
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //刷新数据
                [self.showView dismissView];
                [self requst:self.typeid :self.gardeid :self.ishost :self.istuijian];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        
        }
    }];

}
//
-(void)Upload :(UIButton *)bt{


}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    string = [string stringByReplacingOccurrencesOfString:@"{}" withString:@""];
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
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
