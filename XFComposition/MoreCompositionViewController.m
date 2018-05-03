//
//  MoreCompositionViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MoreCompositionViewController.h"
#import "FristCollectionViewCell.h"
#import "CommwritelistModel.h"
#import "CommWriteListRequst.h"
@interface MoreCompositionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *compositionArray;
@property (nonatomic,assign)NSInteger page;
@end

@implementation MoreCompositionViewController

-(NSMutableArray *)compositionArray{
    if (!_compositionArray) {
        _compositionArray = [[NSMutableArray alloc]init];
    }
    return _compositionArray;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"e8f3fa"];
        _collectionView.showsVerticalScrollIndicator =NO;
        [_collectionView registerClass:[FristCollectionViewCell class] forCellWithReuseIdentifier:@"cellFrist"];//注册cell
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.navigationItem.title = self.str;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.collectionView];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self leftBarButton];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        
        if ([self.str isEqualToString:@"全部习作"]) {
            [self requst:@"0"];
        }else if ([self.str isEqualToString:@"微课习作"]){
            [self requst:@"5"];
            
        }else if ([self.str isEqualToString:@"活动习作"]){
            
            [self requst:@"7"];
        }else if ([self.str isEqualToString:@"独立习作"]){
            [self requst:@"4"];
            
        }
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
//        [self requstMore];
        if ([self.str isEqualToString:@"全部习作"]) {
            [self requstMore:@"0"];
        }else if ([self.str isEqualToString:@"微课习作"]){
            [self requstMore:@"5"];
            
        }else if ([self.str isEqualToString:@"活动习作"]){
            
            [self requstMore:@"7"];
        }else if ([self.str isEqualToString:@"独立习作"]){
            [self requstMore:@"4"];
            
        }

        [self.collectionView.mj_footer endRefreshing];
    }];

}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//刷新数据
-(void)requst :(NSString *)gardeId{
    __weak typeof (self) weakSelf = self;
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:@"1" withpagesiz:@"20" withgradid:gardeId withtypeid:@"0" withishot:@"-1" withtuijian:@"-1"  withlabelid:@"0"  withkeword:@""  BlogStatic:@"1" :^(NSDictionary *json) {
        [weakSelf.compositionArray removeAllObjects];
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
            [weakSelf.compositionArray addObject:model];
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
    
    
}
//加载更多
-(void)requstMore :(NSString *)gardeId{
    __weak typeof (self) weakSelf = self;
    self.page+=1;
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:[NSString stringWithFormat:@"%ld",(long)self.page] withpagesiz:@"10" withgradid:gardeId withtypeid:@"0" withishot:@"0" withtuijian:@"0"  withlabelid:@"0"  withkeword:@"" BlogStatic:@"1"  :^(NSDictionary *json) {
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
            [weakSelf.compositionArray addObject:model];
            
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];

    
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.compositionArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 竖向   设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if (indexPath.section == 0) {
    FristCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFrist" forIndexPath:indexPath];
    CommwritelistModel *model = self.compositionArray[indexPath.row];
    //        cell.imageView =
    cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.BlogTitle];
    cell.rightLabel.text = @"》";
    cell.nameLabel.text = [NSString stringWithFormat:@"作者：%@",model.UserName];
    cell.numberLabel.text = [NSString stringWithFormat:@"点评人数：%@",model.PyNum];
    if ([model.labels isEqualToString:@""]) {
        model.labels = @"暂无";
    }
    cell.bqLabel.text = [NSString stringWithFormat:@"标签：%@",model.labels];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.UserPic];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    
    
    
    
    return cell;
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(WidthFrame/2-7, HeightFrame/8);
    
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    return UIEdgeInsetsMake(10, 5, 2, 2);
    
}
//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
