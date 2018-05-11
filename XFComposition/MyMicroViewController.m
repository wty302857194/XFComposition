//
//  MyMicroViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyMicroViewController.h"
#import "MyMicroCell.h"
#import "MyMicroRequst.h"
#import "MymicroModel.h"
#import "OmitFavClassRequst.h"
#import "MicrodetailController.h"
#import "NewMicrodetailController.h"
@interface MyMicroViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MyMicroCellDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *mymicroArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MyMicroViewController
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
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MyMicroCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
-(NSMutableArray *)mymicroArray{
    if (!_mymicroArray) {
        _mymicroArray = [[NSMutableArray alloc]init];
    }
    return _mymicroArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的微课";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];

    self.page =1;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requst];
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
-(void)requst{


    MyMicroRequst *requst = [[MyMicroRequst alloc]init];
    [requst MyMicroRequstWithuserid:self.userID withPageIndex:@"1" withPageSize:@"20" :^(NSDictionary *json) {
        [self.mymicroArray removeAllObjects];
        MymicroData *myData = [MymicroData mj_objectWithKeyValues:json];
        self.mymicroArray = myData.ret_data.pageInfo;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

}

-(void)requstMore{
    self.page+=1;

    
    MyMicroRequst *requst = [[MyMicroRequst alloc]init];
    [requst MyMicroRequstWithuserid:self.userID withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" :^(NSDictionary *json) {
        MymicroData *myData = [MymicroData mj_objectWithKeyValues:json];
        self.mymicroArray = myData.ret_data.pageInfo;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            
        });
    }];
    
}
-(void)CancelCollect :(UIButton *)bt{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要取消收藏吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MymicroModel *model = self.mymicroArray[bt.tag - 1000];
        OmitFavClassRequst *requst = [[OmitFavClassRequst alloc]init];
        [requst OmitFavClassRequstWithclassID:model.ID withuserid:self.userID :^(NSDictionary *json) {
            NSLog(@"%@",json[@"ret_msg"]);
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                [self requst];
            }
            //如果成功刷新界面
        }];
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mymicroArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    MyMicroCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MymicroModel *model = self.mymicroArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.PicPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];

    cell.titleLable.text = model.Tiltle;
    cell.bt.tag = 1000+indexPath.row;
    cell.delegate = self;
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WidthFrame/3-30, 130);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 2, 15);;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MicrodetailController *vc = [[MicrodetailController alloc]init];
    NewMicrodetailController * vc = [[NewMicrodetailController alloc] init];
    MymicroModel *model = self.mymicroArray[indexPath.item];
    
    vc.classId = model.MicroclassInfoId;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)leftBarButton{
    GO_BACK;
}
-(void)goBackNV{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
