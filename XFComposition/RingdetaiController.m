//
//  RingdetaiController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingdetaiController.h"
#import "RingdetaiFristCell.h"
#import "RingdetaiSecondCell.h"
#import "RingdetailHeadView.h"

#import "JoinGroupRequst.h"
#import "GetGroupInfoRequst.h"
#import "GetGroupInfoModel.h"
#import "GetMyHtListRequst.h"
#import "GetMyHtListModel.h"

#import "RingdetailHeadView.h"

#import "PostViewController.h"
#import "FBHuatiViewController.h"
#import "MemberViewController.h"
@interface RingdetaiController ()<UICollectionViewDataSource,UICollectionViewDelegate,RingdetaiFristCellDelegate,RingdetaiotherDelegate,RingdetailHeadViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *groupListArray;

@property (nonatomic,strong)GetGroupInfoModel *groupModel;
@property (nonatomic,strong)NSMutableArray *btArray;
@property (nonatomic,strong)NSString *typeId;
@property (nonatomic,strong)XFUserInfo *xf;

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UITableView *reshTabelView;
@end

@implementation RingdetaiController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        [_collectionView registerClass:[RingdetaiFristCell class] forCellWithReuseIdentifier:@"Ringcell1"];
        [_collectionView registerClass:[RingdetaiSecondCell class] forCellWithReuseIdentifier:@"Ringcell2"];
        [_collectionView registerClass:[RingdetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
    }
    return _collectionView;
}

-(GetGroupInfoModel *)groupModel{
    if (!_groupModel) {
        _groupModel = [[GetGroupInfoModel alloc]init];
    }
    return _groupModel;
}
-(NSMutableArray *)groupListArray{
    if (!_groupListArray) {
        _groupListArray = [[NSMutableArray alloc]init];
    }
    return _groupListArray;
}
-(NSMutableArray *)btArray{
    if (!_btArray) {
        _btArray = [[NSMutableArray alloc]init];
    }
    return _btArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(UITableView *)reshTabelView{
    if (!_reshTabelView) {
        _reshTabelView = [[UITableView alloc]init];
    }
    return _reshTabelView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"圈子";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.page = 1;
    self.typeId = @"0";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetGroupInfo];

        [self GetMyHtList:self.typeId];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    
}

//获取圈子详细
-(void)GetGroupInfo{
    __weak typeof (self) weakSelf = self;
    
    
    if (self.xf.Loginid == NULL) {
        self.xf.Loginid =@"";
    }
    
    GetGroupInfoRequst *requst = [[GetGroupInfoRequst alloc]init];
    [requst GetGroupInfoRequstWithgruopID:self.ringId withuserid:self.xf.Loginid :^(NSDictionary *json) {
        
        weakSelf.groupModel = [[GetGroupInfoModel alloc]init];
        weakSelf.groupModel = [GetGroupInfoModel loadWithJSOn:json[@"ret_data"]];


            [weakSelf.collectionView reloadData];
        
    }];

}
//获取指定圈子的帖子列表
-(void)GetMyHtList :(NSString *)groupTypeId{
    __weak typeof (self) weakSelf = self;
    GetMyHtListRequst *requst = [[GetMyHtListRequst alloc]init];
    [requst GetMyHtListRequstWithtypeId:groupTypeId withgroupId:self.ringId withPageIndex:@"1" withPageSize:@"10" withflag:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        [weakSelf.groupListArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMyHtListModel *model = [GetMyHtListModel loadWithJSOn:dic];
            [weakSelf.groupListArray addObject:model];
        }
        
            [weakSelf.reshTabelView reloadData];
        
    }];

}
-(void)GetMoreMyHtList :(NSString *)groupTypeId{
    __weak typeof (self) weakSelf = self;
    self.page +=1;
    GetMyHtListRequst *requst = [[GetMyHtListRequst alloc]init];
    [requst GetMyHtListRequstWithtypeId:groupTypeId withgroupId:self.ringId withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"10" withflag:@"0" withkeyWord:@"" :^(NSDictionary *json) {

        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMyHtListModel *model = [GetMyHtListModel loadWithJSOn:dic];
            [weakSelf.groupListArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.reshTabelView reloadData];
            
        });
        
    }];


}
-(void)didselect:(NSIndexPath *)indexpath{
    GetMyHtListModel *model = self.groupListArray[indexpath.row];
    
    PostViewController *vc = [[PostViewController alloc]init];
    vc.strid = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 1;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        RingdetaiFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ringcell1" forIndexPath:indexPath];

        cell.delegate = self;
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.groupModel.groupIcon];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
        
        
        cell.titleLable.text = self.groupModel.groupName;
        
        cell.numLabel.text = [NSString stringWithFormat:@"用户：%@人",self.groupModel.groupUserNum];
        if ([self.groupModel.groupIsJoin isEqualToString:@"1"]) {
            [cell.bt setTitle:@"发表话题" forState:UIControlStateNormal];
            
        }else {
        
            [cell.bt setTitle:@"加入圈子" forState:UIControlStateNormal];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        RingdetaiSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ringcell2" forIndexPath:indexPath];
        cell.delegate = self;
        self.reshTabelView = cell.tableView;
        cell.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
            
            
            [self GetMoreMyHtList:self.typeId];
            [cell.tableView.mj_footer endRefreshing];
        }];

        cell.array = self.groupListArray;
        return cell;
        
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, 110);
        
    }else if (indexPath.section == 1){
        return CGSizeMake(WidthFrame,HeightFrame-110);
        
    }
    return CGSizeZero;
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    return UIEdgeInsetsMake(0, 0, 5, 0);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(WidthFrame, 40);
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 1){
            RingdetailHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            headView.delegate = self;
            self.btArray = headView.tabBtnArray;
            return headView;
        }
        return nil;
    }
    return nil;
}
//圈子成员
-(void)showmember{
    MemberViewController *vc = [[MemberViewController alloc]init];
    vc.Model = self.groupModel;
    vc.groupId = self.ringId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//加入圈子或者发表话题
-(void)joinRing :(UIButton *)bt{
    if ([bt.titleLabel.text isEqualToString:@"发表话题"]) {
        FBHuatiViewController *vc = [[FBHuatiViewController alloc]init];
        vc.groupId = self.ringId;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if ([bt.titleLabel.text isEqualToString:@"加入圈子"]){
        if (self.xf.Loginid == NULL || [self.xf.Loginid isEqualToString: @""]) {
            [SVProgressHUD showInfoWithStatus:@"您还未登录"];
            return;
        }
        JoinGroupRequst *requst = [[JoinGroupRequst alloc]init];
        
        [requst JoinGroupRequstWithgroupId:self.ringId withuserId:self.xf.Loginid :^(NSDictionary *json) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"ret_msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];

            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
    
    
}
-(void)scrollrRingView:(UIButton *)bt{
    self.page = 1;
    for (UIButton *button in self.btArray) {
        if (button.tag == bt.tag) {
            [button setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            
            if (bt.tag == 2000) {
                self.typeId = @"0";
            }else if (bt.tag == 2001){
                self.typeId = @"1";
            }else if (bt.tag == 2002){
                self.typeId = @"2";
            }else if (bt.tag == 2003){
                self.typeId = @"3";
            }else if (bt.tag == 2004){
                self.typeId = @"4";
            }else if (bt.tag == 2005){
                self.typeId = @"5";
            }else if (bt.tag == 2006){
                self.typeId = @"6";
            }
            [self GetMyHtList:self.typeId];
        }else{
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
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
