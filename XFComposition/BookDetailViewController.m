//
//  BookDetailViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookDetailViewController.h"
#import "MarkprogressViewController.h"
#import "LeavmessageViewController.h"
#import "BookEditViewController.h"

#import "BookDetailFristCell.h"
#import "BookDetailSecondCell.h"
#import "BookDetailThirdCell.h"
#import "BookDetailFourCell.h"
#import "ReplaceCell.h"
#import "GetBookInfoRequst.h"//图书详细
#import "GetBookInfoModel.h"

#import "GetSubejectRequst.h"//获取图书下面的题目信息和参与人数的信息数据
#import "GetSubejectModel.h"

#import "GetBookDongTaiRequst.h"//获取学生教师读书分享
#import "GetBookDongTaiModel.h"

#import "AddReadStaticRequst.h"//标记图书的阅读状态

#import "GetPageSubjectRequst.h"
#import "canyuViewController.h"
@interface BookDetailViewController ()<UITableViewDelegate,UITableViewDataSource,BookDetailFristCellDelegate,BookDetailThirdCellDelegate>
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)GetBookInfoModel *bookinfoModel;
@property (nonatomic,strong)GetSubejectModel *subjectModel;
@property (nonatomic,strong)NSMutableArray *dongtaiArray1;
@property (nonatomic,strong)NSMutableArray *dongtaiArray2;

@end

@implementation BookDetailViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//
//}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BookDetailFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[BookDetailSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[BookDetailThirdCell class] forCellReuseIdentifier:@"cell3"];
        [_tableView registerClass:[BookDetailFourCell class] forCellReuseIdentifier:@"cell4"];
        [_tableView registerClass:[ReplaceCell class] forCellReuseIdentifier:@"replaceCell"];
        
    }
    return _tableView;
}
-(GetBookInfoModel *)bookinfoModel{
    if (!_bookinfoModel) {
        _bookinfoModel = [[GetBookInfoModel alloc]init];
    }
    return _bookinfoModel;
}

-(NSMutableArray *)dongtaiArray1{
    if (!_dongtaiArray1) {
        _dongtaiArray1 = [[NSMutableArray alloc]init];
    }
    return _dongtaiArray1;
}
-(NSMutableArray *)dongtaiArray2{
    if (!_dongtaiArray2) {
        _dongtaiArray2 = [[NSMutableArray alloc]init];
    }
    return _dongtaiArray2;
}
-(void)creatView{
    UIButton *messagebt = [UIButton buttonWithType:UIButtonTypeCustom];
    messagebt.frame = CGRectMake(0, HeightFrame-60, WidthFrame/2, 60);
    [messagebt setTitle:@"留言" forState:UIControlStateNormal];
    [messagebt setBackgroundColor:[UIColor colorWithHexString:@"F3A832"]];
    [messagebt addTarget:self action:@selector(leaVmessge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messagebt];
    
    UIButton *tjbt = [UIButton buttonWithType:UIButtonTypeCustom];
    tjbt.frame = CGRectMake(WidthFrame/2, HeightFrame-60, WidthFrame/2, 60);
    [tjbt setTitle:@"图书推荐" forState:UIControlStateNormal];
    [tjbt setBackgroundColor:[UIColor colorWithHexString:@"3690CE"]];
    [tjbt addTarget:self action:@selector(Recommend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tjbt];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图书详情";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    
    self.xf = [XFUserInfo getUserInfo];
    [self.view addSubview:self.tableView];
    [self creatView];
    
    [self GetBookInfo];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
       
        [self GetSubeject];
        [self GetBookongTai:@"1" :self.dongtaiArray2];//学生读书动态
        [self GetBookongTai:@"2" :self.dongtaiArray1];//老师读书动态
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    GO_BACK;
}
- (void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
//图书信息
-(void)GetBookInfo{
    GetBookInfoRequst *requst = [[GetBookInfoRequst alloc]init];
    [requst GetBookInfoRequstWithbookid:self.bookid withuserid:self.xf.Loginid :^(NSDictionary *josn) {
        self.bookinfoModel = [[GetBookInfoModel alloc]init];
        self.bookinfoModel = [GetBookInfoModel loadWithJSOn:josn[@"ret_data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
//获取图书下面的题目信息和参与人数的信息数据
-(void)GetSubeject{
    GetSubejectRequst *requst = [[GetSubejectRequst alloc]init];
    [requst GetSubejectRequstwithbookid:self.bookid :^(NSDictionary *json) {
        self.subjectModel = [[GetSubejectModel alloc]init];
        self.subjectModel = [GetSubejectModel loadWithJSOn:json[@"ret_data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
//获取动态
-(void)GetBookongTai : (NSString *)flag :(NSMutableArray *)array{
    GetBookDongTaiRequst *requst = [[GetBookDongTaiRequst alloc]init];
    [requst GetBookDongTaiRequst:self.bookid withflag:flag withPageIndex:@"1" withPageSize:@"4" :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookDongTaiModel *model = [GetBookDongTaiModel loadWithJSOn:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}


-(void)wantRead{
    __weak typeof (self) weakSelf = self;
    AddReadStaticRequst *requst = [[AddReadStaticRequst alloc]init];
    [requst AddReadStaticRequstwithbookid:self.bookid withflag:@"0" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [weakSelf GetBookInfo];
        
       [SVProgressHUD showSuccessWithStatus:@"已标记想读"];
        
    }];
}
-(void)NowRead{
    __weak typeof (self) weakSelf = self;
    AddReadStaticRequst *requst = [[AddReadStaticRequst alloc]init];
    [requst AddReadStaticRequstwithbookid:self.bookid withflag:@"1" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [weakSelf GetBookInfo];
           [SVProgressHUD showSuccessWithStatus:@"已标记在读"];
    }];
}
-(void)PastRead{
    __weak typeof (self) weakSelf = self;
    AddReadStaticRequst *requst = [[AddReadStaticRequst alloc]init];
    [requst AddReadStaticRequstwithbookid:self.bookid withflag:@"2" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [weakSelf GetBookInfo];
           [SVProgressHUD showSuccessWithStatus:@"已标记已读"];
    }];

}

- (void)canyu{
    
    __weak typeof (self) weakSelf = self;

    GetPageSubjectRequst *requst = [[GetPageSubjectRequst alloc]init];
    [requst GetBookSubjectRequstwithpageid:self.bookid  :^(NSDictionary *json) {
        
        canyuViewController *vc = [[canyuViewController alloc]init];
        vc.dic = json;
        vc.liulantype = @"1000";
        vc.bookid = self.bookid;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
}
//标记进度
-(void)biaojijindu{
    MarkprogressViewController *vc = [[MarkprogressViewController alloc]init];
    vc.PageStr = self.bookinfoModel.bookpages;
    vc.bookID = self.bookid;
    vc.userId = self.xf.Loginid;
    vc.bjID = @"";
     __weak typeof(self) weakSelf = self;
    vc.markprogressBlock = ^{
        [weakSelf GetBookInfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

//留言
-(void)leaVmessge{
    LeavmessageViewController *vc = [[LeavmessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.leavMessgeId = self.bookid;
    vc.userID = self.xf.Loginid;

}
//图书推荐
-(void)Recommend{
    BookEditViewController *vc = [[BookEditViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    vc.bookFlag = @"0";
}

- (void)moreMessage:(UIButton *)btn {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2) {
        return 1;
    }else if (section == 3){
        if (self.dongtaiArray1.count == 0) {
            return 1;
        }
        return self.dongtaiArray1.count;
    }else if (section == 4){
        if (self.dongtaiArray2.count == 0) {
            return 1;
        }
        return self.dongtaiArray2.count;
    }
    return 0;
    
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self.tableView cellHeightForIndexPath:indexPath model:self.bookinfoModel keyPath:@"model" cellClass:[BookDetailFristCell class] contentViewWidth:[self cellContentViewWith]];
    }else if (indexPath.section == 2){
        return [self.tableView cellHeightForIndexPath:indexPath model:self.subjectModel keyPath:@"model" cellClass:[BookDetailThirdCell class] contentViewWidth:[self cellContentViewWith]];
        
    }else if (indexPath.section == 3 ){
        if (self.dongtaiArray1.count == 0 ) {
            return 62;
        }
        return 30;
    }else if (indexPath.section == 4 ){
        if (self.dongtaiArray2.count == 0 ) {
            return 62;
        }
        return 30;
    
    }
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BookDetailFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = self.bookinfoModel;
        
        return cell;
    }else if (indexPath.section == 1){
        BookDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = self.bookinfoModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.section == 2){
        BookDetailThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = [NSString stringWithFormat:@"%@测试",self.bookinfoModel.bookname];
          cell.delegate = self;
        
        NSString *str = [NSString stringWithFormat:@"%@",self.bookinfoModel.bookpic];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.model = self.subjectModel;
        return cell;
    }else if (indexPath.section == 3){
        if (self.dongtaiArray1.count == 0) {
            ReplaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replaceCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            BookDetailFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            GetBookDongTaiModel *dongtaimodel = self.dongtaiArray1[indexPath.row];
            cell.model = dongtaimodel;
            return cell;
        }
    }else if (indexPath.section == 4){
        if (self.dongtaiArray2.count == 0) {
            ReplaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replaceCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else {
            BookDetailFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            GetBookDongTaiModel *dongtaimodel = self.dongtaiArray2[indexPath.row];
            cell.model = dongtaimodel;
            return cell;
            
        }
        
    }
    return nil;
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    backView.backgroundColor = hexColor(f4f5f6);
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WidthFrame, 25)];
    view.backgroundColor = [UIColor whiteColor];
    [backView addSubview:view];
    
    UILabel *leftLable = [[UILabel alloc]init];
    leftLable.frame = CGRectMake(20, 2, 5, 20);
    leftLable.backgroundColor = [UIColor colorWithHexString:@"3893CF"];
    [view addSubview:leftLable];
    UILabel *titleLabel = [[UILabel alloc]init];
    
    [view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.sd_layout.leftSpaceToView(leftLable, 10).topSpaceToView(view, 5).heightIs(20).widthIs(0);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:0];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(WidthFrame-60, 2, 40, 20);
    bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [bt addTarget:self action:@selector(moreMessage:) forControlEvents:UIControlEventTouchUpInside];
    bt.tag = section;
    bt.layer.cornerRadius = 10;
    bt.layer.masksToBounds = YES;
    [bt setTitle:@"更多" forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    if (section == 0) {
        return nil;
    }else if (section == 1){
        titleLabel.text = @"我的读书笔记";
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:bt];
        bt.sd_layout.rightSpaceToView(view, 20).topSpaceToView(view, 2).heightIs(23).widthIs(60);
        [bt setTitle:@"标记进度" forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor colorWithHexString:@"F1AF49"]];
        [bt setTintColor:[UIColor whiteColor]];
        [bt addTarget:self action:@selector(biaojijindu) forControlEvents:UIControlEventTouchUpInside];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = 6;
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        return backView;
    }else if (section == 2){
        titleLabel.text = @"阅读测试";
        
        return backView;
    }else if (section == 3){
        titleLabel.text = @"教师读书分享";
        
        [view addSubview:bt];
        return backView;
    }else if (section == 4){
        titleLabel.text = @"学生阅读分享";
        [view addSubview:bt];
        return backView;
    }
    return nil;
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
