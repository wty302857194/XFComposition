//
//  MyringViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyringViewController.h"
#import "RingSecondCell.h"

#import "GetMyGroupListRequst.h"
#import "GetMygroupListModel.h"
#import "RingdetaiController.h"
#import "CreatecircleViewController.h"
@interface MyringViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *groupArray;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MyringViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        if ([self.xf.dutyId isEqualToString:@"1"]) {
            _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        }else{
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-80) collectionViewLayout:layout];

        }
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
//        [_collectionView registerClass:[RingFristCell class] forCellWithReuseIdentifier:@"Ringcell1"];
        [_collectionView registerClass:[RingSecondCell class] forCellWithReuseIdentifier:@"Ringcell2"];
    }
    return _collectionView;
}

-(NSMutableArray *)groupArray{
    if (!_groupArray) {
        _groupArray = [[NSMutableArray alloc]init];
    }
    return _groupArray;
}
-(void)creatView{
    if ([self.xf.dutyId isEqualToString:@"0"]) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"创建圈子" forState:UIControlStateNormal];
        bt.layer.cornerRadius = 4;
        bt.layer.masksToBounds = YES;
        bt.backgroundColor = [UIColor colorWithHexString:@"338ED0"];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt addTarget:self action:@selector(chuangjianquanzi) forControlEvents:UIControlEventTouchUpInside];
        bt.frame = CGRectMake(WidthFrame/3, HeightFrame-60, WidthFrame/3, 40);
        [self.view addSubview:bt];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的圈子";
    
    self.xf = [XFUserInfo getUserInfo];
    self.view.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
    [self.view addSubview:self.collectionView];
    [self creatView];
    self.page = 1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self Requst];
        [self getMyRingList];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore];
        [self.collectionView.mj_footer endRefreshing];
    }];

}
-(void)getMyRingList{
    __weak typeof (self) weakSelf = self;
    GetMyGroupListRequst *requst = [[GetMyGroupListRequst alloc]init];
    [requst GetMyGroupListRequstwithuserId:self.Myringuserid withtypeId:@"0" withflag:@"0" withPageIndex:@"1" withPageSize:@"20" withisTuijian:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        [self.groupArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMygroupListModel *model = [GetMygroupListModel loadWithJSOn:dic];
            [self.groupArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    }];
}
-(void)requstMore{
    __weak typeof (self) weakSelf = self;
    self.page+=1;
    
    GetMyGroupListRequst *requst = [[GetMyGroupListRequst alloc]init];
    [requst GetMyGroupListRequstwithuserId:self.Myringuserid withtypeId:@"0" withflag:@"0" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withisTuijian:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMygroupListModel *model = [GetMygroupListModel loadWithJSOn:dic];
            [self.groupArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    }];



}
//创建圈子
-(void)chuangjianquanzi{
    CreatecircleViewController *vc = [[CreatecircleViewController alloc]init];
    vc.userid = self.Myringuserid;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count;
}
#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        RingSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ringcell2" forIndexPath:indexPath];
        GetMygroupListModel *model = self.groupArray[indexPath.row];
        //        cell.model = self.groupArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.GroupIcon];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
        
        cell.titleLabel.text = model.GroupName;
        cell.userNumLabel.text = [NSString stringWithFormat:@"用户：%@",model.JoinNum];
        cell.listLabel.text = [NSString stringWithFormat:@"类别：%@",model.TypeName];
        cell.textView.text = [NSString stringWithFormat:@"圈子简介：%@",model.GroupInfo];
        return cell;
        
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthFrame/2-20, 100);
    
    
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    return UIEdgeInsetsMake(5, 10, 2, 10);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RingdetaiController *vc = [[RingdetaiController alloc]init];
    GetMygroupListModel *model = self.groupArray[indexPath.item];
    
    vc.ringId = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
