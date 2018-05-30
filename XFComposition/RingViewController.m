//
//  RingViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "RingViewController.h"
#import "RingFristCell.h"
#import "RingSecondCell.h"
#import "Ringrequst.h"
#import "GroupModel.h"
#import "RingdetaiController.h"
@interface RingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *groupArray;
@end

@implementation RingViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        [_collectionView registerClass:[RingFristCell class] forCellWithReuseIdentifier:@"Ringcell1"];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.dic);
    self.page = 1;
    [self.view addSubview:self.collectionView];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //        [self Requst];
            [self Ringrequst];
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
-(void)goBacka{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)Ringrequst{
    __weak typeof (self) weakSelf = self;
    Ringrequst *requst = [[Ringrequst alloc]init];
    
    [requst GetRingList:1 :^(NSDictionary *json) {
        [weakSelf.groupArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GroupModel *model = [GroupModel loadWithJSOn:dic];
            [weakSelf.groupArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];

}
-(void)requstMore{
    __weak typeof (self) weakSelf = self;
    self.page+=1;
    
    Ringrequst *requst = [[Ringrequst alloc]init];
    [requst GetRingList:self.page :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GroupModel *model = [GroupModel loadWithJSOn:dic];
            [weakSelf.groupArray addObject:model];
        }
//        self.collectionView.mj_footer.hidden = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
        });
    }];


}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.groupArray.count;
    }
    return 0;
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
        RingFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ringcell1" forIndexPath:indexPath];

//        UIButton *button = cell.bt;
//        [button addTarget:self action:@selector(goBacka) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }else if (indexPath.section == 1){
        RingSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Ringcell2" forIndexPath:indexPath];
        GroupModel *model = self.groupArray[indexPath.row];
//        cell.model = self.groupArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.GroupIcon];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
        
        cell.titleLabel.text = model.GroupName;
        cell.userNumLabel.text = [NSString stringWithFormat:@"用户：%@",model.JoinNum];
        cell.listLabel.text = [NSString stringWithFormat:@"类别：%@",model.TypeName];
        cell.textView.text = [NSString stringWithFormat:@"圈子简介：%@",model.GroupInfo];
        return cell;
    
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, HeightFrame/3);
        
    }else if (indexPath.section == 1){
        return CGSizeMake(WidthFrame/2-20, 100);
        
    }
    return CGSizeZero;
        
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
        return UIEdgeInsetsMake(5, 10, 2, 10);
    
}

////横向
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 1;
//}
//// 竖向   设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 15;
//}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        RingdetaiController *vc = [[RingdetaiController alloc]init];
        
        GroupModel *model = self.groupArray[indexPath.row];
        vc.ringId = model.Id;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
