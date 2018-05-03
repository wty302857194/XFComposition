//
//  GrouplistView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GrouplistView.h"
#import "MytestGroupCell.h"
#import "GetMyGroupListRequst.h"
#import "GetMygroupListModel.h"
#import "PublicTextTitleRequst.h"
@interface GrouplistView()<UITableViewDelegate,UITableViewDataSource,MytestGroupCellDelegate>
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSMutableArray *listArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *xuanzhongArray;
@end
@implementation GrouplistView

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(20, HeightFrame/2-140, WidthFrame-40, 280)];
        self.backView.layer.cornerRadius = 4;
        self.backView.layer.masksToBounds = YES;
        self.backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame-40, 280) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MytestGroupCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = [UIColor whiteColor];
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
-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}
-(NSMutableArray *)xuanzhongArray{
    if (!_xuanzhongArray) {
        _xuanzhongArray = [NSMutableArray array];
    }
    return _xuanzhongArray;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.listArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MytestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.bt.tag = 1000 + indexPath.row;
    GetMygroupListModel *model = self.listArray[indexPath.row];
    cell.titleLabel.text = model.GroupName;
    return cell;
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 40;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame-40, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor lightGrayColor];
    bt.frame = CGRectMake(WidthFrame-40-40, 5, 25, 25);
    [bt addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bt];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame-40, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor lightGrayColor];
    [bt setTitle:@"发布到我的圈子" forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:15];
    bt.frame = CGRectMake((WidthFrame-40)/3, 5, (WidthFrame-40)/3, 30);
    [bt addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bt];
    return view;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        self.page = 1;
        [self.backView addSubview:self.tableView];
        [self addSubview:self.backView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self groupList];
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
    return self;
}
//发布
-(void)fabu{
//    NSLog(@"----%@",[self.xuanzhongArray componentsJoinedByString:@","]);
    PublicTextTitleRequst *requst = [[PublicTextTitleRequst alloc]init];
    [requst PublicTextTitleRequstwithGroupId:[self.xuanzhongArray componentsJoinedByString:@","] withPageId:@"37" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            [self dissMiss];
        }
    }];
    
}
//点击按钮选中
-(void)xuanzhong:(UIButton *)bt{
    GetMygroupListModel *model = self.listArray[bt.tag - 1000];
    if ([self.xuanzhongArray containsObject:[NSString stringWithFormat:@"%@",model.Id]]) {
        [self.xuanzhongArray removeObject:[NSString stringWithFormat:@"%@",model.Id]];
    }else{
        [self.xuanzhongArray addObject:[NSString stringWithFormat:@"%@",model.Id]];
        
    }
    
}
-(void)groupList{
    GetMyGroupListRequst *requst = [[GetMyGroupListRequst alloc]init];
    [requst GetMyGroupListRequstwithuserId:self.xf.Loginid withtypeId:@"0" withflag:@"0" withPageIndex:@"1" withPageSize:@"20" withisTuijian:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        [self.listArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMygroupListModel *model = [GetMygroupListModel loadWithJSOn:dic];
            [self.listArray addObject:model];

        }
        [self.tableView reloadData];
        
    }];
    
}
-(void)requstMore{
    self.page +=1;
    GetMyGroupListRequst *requst = [[GetMyGroupListRequst alloc]init];
    [requst GetMyGroupListRequstwithuserId:self.xf.Loginid withtypeId:@"0" withflag:@"0" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withisTuijian:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMygroupListModel *model = [GetMygroupListModel loadWithJSOn:dic];
            [self.listArray addObject:model];
            
        }
        [self.tableView reloadData];
        
    }];
    
}
-(void)showView{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dissMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}
@end
