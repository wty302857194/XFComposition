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
@interface GrouplistView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *topLabel;
@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSMutableArray *listArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *xuanzhongArray;
@end
@implementation GrouplistView

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(20, SafeAreaTopHeight + 50, WidthFrame-40, 350)];
        self.backView.layer.cornerRadius = 6;
        self.backView.layer.masksToBounds = YES;
        self.backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
-(UIView*)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.backView.frame) - 50, CGRectGetWidth(self.backView.frame), 50)];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(40, 10, (CGRectGetWidth(self.backView.frame)- 20)/2 -40, 30);
        
        [button setTitle:@"发布到选定的圈子" forState:UIControlStateNormal];
        button.backgroundColor = hexColor(009dff);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 2.0;
        button.layer.masksToBounds = YES;
        
        [button addTarget:self action:@selector(fabu) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
        
        UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cancleButton.frame = CGRectMake((CGRectGetWidth(self.backView.frame)- 20)/2 + 40, 10, (CGRectGetWidth(self.backView.frame)- 20)/2 -40 , 30);
        
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        cancleButton.backgroundColor = hexColor(EB6752);
        cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        cancleButton.layer.cornerRadius = 2.0;
        cancleButton.layer.masksToBounds = YES;
        
        [cancleButton addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancleButton];
        
    }
    return _bottomView;
    
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,40.5, WidthFrame-40, CGRectGetHeight(self.backView.frame) - 50 - 40.5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MytestGroupCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
-(UILabel*)topLabel{
    
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, CGRectGetWidth(self.backView.frame), 40 )];
        _topLabel.text = @"选择要发布的圈子";
        _topLabel.textColor = hexColor(333333);
        _topLabel.font = [UIFont systemFontOfSize:14];
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.backView.frame), .5)];
        imgView.backgroundColor = hexColor(e5e5e5);
        

        [self.backView addSubview:imgView];
        
    }
    return _topLabel;
    
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
    
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MytestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GetMygroupListModel *model = self.listArray[indexPath.row];
    cell.titleLabel.text = model.GroupName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MytestGroupCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
    cell.bt.selected = !cell.bt.selected;
    GetMygroupListModel *model = self.listArray[indexPath.row];
    if ([self.xuanzhongArray containsObject:[NSString stringWithFormat:@"%@",model.Id]]) {
        [self.xuanzhongArray removeObject:[NSString stringWithFormat:@"%@",model.Id]];
    }else{
        [self.xuanzhongArray addObject:[NSString stringWithFormat:@"%@",model.Id]];
        
    }
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        self.page = 1;
        [self.backView addSubview:self.tableView];
        [self addSubview:self.backView];
        [self.backView addSubview:self.topLabel];

        [self.backView addSubview:self.bottomView];

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
    
    if (self.xuanzhongArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择圈子"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在发布"];
    PublicTextTitleRequst *requst = [[PublicTextTitleRequst alloc]init];
    [requst PublicTextTitleRequstwithGroupId:[self.xuanzhongArray componentsJoinedByString:@","] withPageId:@"37" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        
        [SVProgressHUD dismiss];
        if ([json[@"ret_code"] integerValue] == 0) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            [self dissMiss];
        }else{
            [SVProgressHUD showErrorWithStatus:json[@"msg"]];


        }
    }];
    
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
