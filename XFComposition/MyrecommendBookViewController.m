//
//  MyrecommendBookViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyrecommendBookViewController.h"
#import "ReadnotesCell.h"
#import "MyrecommenbookfristCell.h"
#import "GetMybookListRequst.h"
#import "GetMybookListModel.h"
#import "GetMyTongjiRequst.h"
#import "GetMytongjiModel.h"
#import "DeleteBookRequst.h"

#import "BookEditViewController.h"
@interface MyrecommendBookViewController ()<UITableViewDelegate,UITableViewDataSource,ReadnotesCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *bookArray;
@property (nonatomic,strong)GetMytongjiModel *model;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MyrecommendBookViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ReadnotesCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[MyrecommenbookfristCell class] forCellReuseIdentifier:@"cell1"];
        
    }
    return _tableView;
}
-(NSMutableArray *)bookArray{
    if (!_bookArray) {
        _bookArray = [[NSMutableArray alloc]init];
    }
    return _bookArray;
}
-(GetMytongjiModel *)model{
    if (!_model) {
        _model = [[GetMytongjiModel alloc]init];
    }
    return _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐图书";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.page = 1;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetMyTongji];
        [self GetMybookList];
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
//统计
-(void)GetMyTongji{
    GetMyTongjiRequst *requst = [[GetMyTongjiRequst alloc]init];
    [requst GetMyTongjiRequstwithuserid:self.MyrecommenuserId :^(NSDictionary *json) {
        self.model = [[GetMytongjiModel alloc]init];
        self.model = [GetMytongjiModel loadWithJSOn:json[@"ret_data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    

}

//获取我的图书
-(void)GetMybookList{
    GetMybookListRequst *requst = [[GetMybookListRequst alloc]init];
    [requst GetMybookListRequstWithchaperid:@"0" withbooktype:@"0" withbookgrade:@"0" withkeyword:@"" withPageIndex:@"1" withPageSize:@"20" withuserid:self.MyrecommenuserId :^(NSDictionary *json) {
        [self.bookArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMybookListModel *model = [GetMybookListModel loadWithJSOn:dic];
            [self.bookArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)requstMore{
    self.page +=1;
    GetMybookListRequst *requst = [[GetMybookListRequst alloc]init];
    [requst GetMybookListRequstWithchaperid:@"0" withbooktype:@"0" withbookgrade:@"0" withkeyword:@"" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withuserid:self.MyrecommenuserId :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMybookListModel *model = [GetMybookListModel loadWithJSOn:dic];
            [self.bookArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
//修改
-(void)xiugaiBJ:(UIButton *)bt{
    BookEditViewController *vc = [[BookEditViewController alloc]init];
    vc.bookFlag = @"1";
    GetMybookListModel *model = self.bookArray[bt.tag - 1000];
    vc.bookId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
//删除
-(void)delectBj:(UIButton *)bt{
    __weak typeof (self) weakSelf = self;
    GetMybookListModel *model = self.bookArray[bt.tag -2000];
    DeleteBookRequst *requst = [[DeleteBookRequst alloc]init];
    [requst DeleteBookRequstWithbookids:model.ID :^(NSDictionary *json) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"ret_msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if ([json[@"ret_code"] isEqualToString:@"0"]){
                [weakSelf GetMybookList];
            }
            
        }]];
        
        [weakSelf presentViewController:alert animated:YES completion:nil];
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
        return 3;
    }
    return self.bookArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if(indexPath.section == 1){
        GetMybookListModel *Model = self.bookArray[indexPath.row];
        return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"bookModel" cellClass:[ReadnotesCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyrecommenbookfristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"今日推荐";
            cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.todaynum];
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"成功推荐";
            cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.successnum];
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"审核中";
            cell.numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.model.checknum];
        }
        return cell;
    }else{
        ReadnotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.bt1.tag = 1000+indexPath.row;
        cell.bt2.tag = 2000+indexPath.row;
        GetMybookListModel *Model = self.bookArray[indexPath.row];
        cell.bookModel = Model;
        return  cell;
    }
    
    return nil;
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 80;
    }
    return 0.01;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 80)];
        view.backgroundColor = [UIColor colorWithHexString:@"E8F2FA"];
        UILabel *tuijianLabel = [[UILabel alloc]init];
        UILabel *label1 = [[UILabel alloc]init];
        
        [view addSubview:tuijianLabel];
        [view addSubview:label1];
        
        tuijianLabel.sd_layout.leftSpaceToView(view, 20).topSpaceToView(view, 10).heightIs(30).widthIs(0);
        [tuijianLabel setSingleLineAutoResizeWithMaxWidth:0];
        tuijianLabel.font = [UIFont systemFontOfSize:12];
        tuijianLabel.text = @"推荐规则：";
        label1.sd_layout.leftSpaceToView(tuijianLabel, 0).topSpaceToView(view, 10).rightSpaceToView(view, 20).autoHeightRatio(0);
        label1.font = [UIFont systemFontOfSize:11];
        label1.text = @"推荐图书填写图书信息，上传图片文件 推荐图书可以设置图书的购买地址或者在线阅读地址";
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"推荐图书" forState:UIControlStateNormal];
        bt.frame = CGRectMake(WidthFrame/2-50, 50, 100, 30);
        [bt setBackgroundColor:[UIColor colorWithHexString:@"F19733"]];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(tuijianbook) forControlEvents:UIControlEventTouchUpInside];
        bt.layer.cornerRadius = 6;
        bt.layer.masksToBounds = YES;
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [view addSubview:bt];
        return view;

    }
    return nil;
}
-(void)tuijianbook{
    BookEditViewController *vc = [[BookEditViewController alloc]init];
//    vc.userId = self.MyrecommenuserId;
    vc.bookFlag = @"0";
    [self.navigationController pushViewController:vc animated:YES];
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
