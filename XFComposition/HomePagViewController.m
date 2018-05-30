//
//  HomePagViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePagViewController.h"
#import "HomepaFristCell.h"
#import "HomepaSecondCell.h"
#import "HomePaThridCell.h"
#import "HomePaFourCell.h"
#import "HomePaFiveCell.h"
#import "HomePaSixCell.h"
#import "RingSecondCell.h"
#import "MircFiveCell.h"
#import "HomePaFristheadView.h"


#import "AppDelegate.h"
#import "MicroClassViewController.h"
#import "RingViewController.h"

#import "ActiveViewController.h"
#import "MicrodetailController.h"
#import "ReadAndEViewController.h"
#import "BookDetailViewController.h"
#import "RingdetaiController.h"
#import "WedpViewController.h"
#import "WeyuwenViewController.h"
#import "SubmissionController.h"

#import "HomeActivityRequst.h"
#import "HomeBookRequst.h"
#import "HomeGroupRequst.h"
//#import "HomeDianPingRequst.h"
#import "GetDinaPinListRequst.h"
#import "MicoClassRequst.h"


#import "ActiveInfoModel.h"
#import "BookModel.h"
#import "GroupModel.h"
#import "DianPingModel.h"
#import "WriteListModel.h"

#import "GetLabelTypeTreelistAllRequst.h"
#import "JGInfiniteScrollView.h"//轮播
#import "DPdetailViewController.h"
#import "NewMicrodetailController.h"
@interface HomePagViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HomePaSecondDelegate,HomePaThridCellDelegate,JGInfiniteScrollViewDelegate,MircFiveCellDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *compostitionArray;
@property (nonatomic,strong)NSMutableArray *bookArray;
@property (nonatomic,strong)NSMutableArray *GroupArray;
@property (nonatomic,strong)NSMutableArray *activeArray;
@property (nonatomic,strong)NSMutableArray *dianpingArray;
@property (nonatomic,strong)NSMutableArray *jxArray;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation HomePagViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
        
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
            [self ActiveRequst];
            [self bookRequst];
            [self RingRequst];
            [self DianpingRequst];
            [self MicClassRequstList:@"2"];
            [self.collectionView.mj_header endRefreshing];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.collectionView.mj_header = header;
        
        [self.collectionView.mj_header beginRefreshing];

    [self.view addSubview:self.collectionView];
    
    
    self.navigationController.navigationBar.translucent = NO;
    
}
-(NSMutableArray *)bookArray{
    if (!_bookArray) {
        _bookArray = [[NSMutableArray alloc]init];
    }
    return _bookArray;
}
-(NSMutableArray *)GroupArray{
    if (!_GroupArray) {
        _GroupArray = [[NSMutableArray alloc]init];
    }
    return _GroupArray;
}
-(NSMutableArray *)activeArray{
    if (!_activeArray) {
        _activeArray = [[NSMutableArray alloc]init];
    }
    return _activeArray;
}
-(NSMutableArray *)dianpingArray{
    if (!_dianpingArray) {
        _dianpingArray = [[NSMutableArray alloc]init];
    }
    return _dianpingArray;
}
-(NSMutableArray *)jxArray{
    if (!_jxArray) {
        _jxArray = [[NSMutableArray alloc]init];
    }
    return _jxArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        _collectionView.showsVerticalScrollIndicator =NO;
        [_collectionView registerClass:[HomepaFristCell class] forCellWithReuseIdentifier:@"cellFrist"];//注册cell
        [_collectionView registerClass:[HomepaSecondCell class] forCellWithReuseIdentifier:@"cellSecond"];
        [_collectionView registerClass:[HomePaThridCell class] forCellWithReuseIdentifier:@"cellThrid"];
        [_collectionView registerClass:[HomePaFourCell class] forCellWithReuseIdentifier:@"cellFour"];
        [_collectionView registerClass:[HomePaFiveCell class] forCellWithReuseIdentifier:@"cellFive"];
        [_collectionView registerClass:[HomePaSixCell class] forCellWithReuseIdentifier:@"cellSix"];
        [_collectionView registerClass:[RingSecondCell class] forCellWithReuseIdentifier:@"cellSeven"];
        [_collectionView registerClass:[MircFiveCell class] forCellWithReuseIdentifier:@"celleghit"];
        
        [_collectionView registerClass:[HomePaFristheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];//注册cell的headview
//
//        [_collectionView registerClass:[SecondHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
        
    }
    return _collectionView;
}
-(NSArray *)compostitionArray{
    if (!_compostitionArray) {
        _compostitionArray = @[@"pic_01",@"pic_02",@"pic_03"];
    }
    return _compostitionArray;
}
-(void)ActiveRequst{
    
    __weak typeof (self) weakSelf = self;
    HomeActivityRequst *ActivityRequst = [[HomeActivityRequst alloc]init];
    
    [ActivityRequst HomeGetActivityRequst:@"10": ^(NSDictionary *dic) {
        [weakSelf.activeArray removeAllObjects];
        
        NSArray *activeArray = dic[@"ret_data"][@"pageInfo"];
        for (NSDictionary *dic in activeArray) {
            ActiveInfoModel *model = [ActiveInfoModel loadWithJSOn:dic];
            [weakSelf.activeArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}

-(void)bookRequst{
//    __weak typeof (self) weakSelf = self;
//    HomeBookRequst *bookRequst = [[HomeBookRequst alloc]init];
//    [bookRequst HomeGetBookListWithchaperid :@"0" :@"0" :@"4" :^(NSDictionary *json) {
//
//        [weakSelf.bookArray removeAllObjects];
//        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
//            BookModel *model = [BookModel loadWithJSOn:dic];
//            [weakSelf.bookArray addObject:model];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.collectionView reloadData];
//        });
//    }];
    
}
-(void)RingRequst{
    __weak typeof (self) weakSelf = self;
    HomeGroupRequst *groupRequst = [[HomeGroupRequst alloc]init];
    [groupRequst HomeGetGroupInfo:^(NSMutableArray *array) {
        //        GroupModel *model = [GroupModel loadWithJSOn:dic[@"ret_data"]];
        weakSelf.GroupArray = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    }];
    
}
-(void)DianpingRequst{
    __weak typeof (self) weakSelf = self;
    GetDinaPinListRequst *dianpingRequst = [[GetDinaPinListRequst alloc]init];
    [dianpingRequst GetDinaPinListRequswithPageIndex:@"1" withPageSize:@"10" withclassId:@"0" withmodelId:@"0" withkeyWord:@"" :^(NSDictionary *json) {
        [weakSelf.dianpingArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [weakSelf.dianpingArray addObject:model];
        }
        
    }];
    
    
}
-(void)MicClassRequstList :(NSString *)timespan{
    __weak typeof (self) weakSelf = self;
    MicoClassRequst *requst = [[MicoClassRequst alloc]init];
    [requst requstGetmicListWithchangId:@"2" Withmasterid:@"0" Withsubjectid:@"0" Withindex:@"1" Withpagesize:@"3" Withrecommed:@"-1" Withprostatic:@"-1" Withtimespan:timespan :^(NSDictionary *json) {
        
        
        [weakSelf.jxArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            WriteListModel *model = [WriteListModel loadWithJSOn:dic];
            [weakSelf.jxArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
    
}
-(void)gotoVolunactive:(NSIndexPath *)index{
    
    SubmissionController *vc = [[SubmissionController alloc]init];
    ActiveInfoModel *model = self.activeArray[index.row];
//    NSLog(@"---%@",model.activetype);
    vc.SubActiveID = model.activeid;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    }else if (section == 1){
        
        return 1;
    }else if (section == 2){
        
        return 1;
    }else if (section == 3){
        
        return 3;
    }else if (section == 4){
        if (_jxArray.count > 3){
             return 3;
        }else{
             return _jxArray.count;
        }
       
    }else if (section == 5){
        
        return self.bookArray.count;
    }else if (section == 6){
        
//        return self.GroupArray.count;
        return 1;
    }else if (section == 7){
        
        return 1;
    }
    return 0;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 7;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HomepaFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFrist" forIndexPath:indexPath];
        
        
        JGInfiniteScrollView *scrollView = [[JGInfiniteScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, WidthFrame, HeightFrame/3);
        scrollView.images = @[
                              [UIImage imageNamed:@"baner"],
                              [UIImage imageNamed:@"banner_weiketang"],
                              [UIImage imageNamed:@"banner_yuedu"],
                              ];
        scrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        scrollView.delegate = self;
        [cell addSubview:scrollView];
        
//        cell.arry = self.compositionArray;
        return cell;
    }else if (indexPath.section == 1){
        HomepaSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSecond" forIndexPath:indexPath];
        cell.delegate = self;
//        WriteListModel *model = self.secondArray[indexPath.row];
//        NSString *str = [NSString stringWithFormat:@"http://xf.vqune.com%@",model.MicroclassInfoAttr1];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
//        //        http://xf.vqune.com/LocalFiles/Weike/videopic/1480175617755.jpg
//        cell.titleLabel.text = model.MicroclassInfoTitle;
        return cell;
    }else if (indexPath.section == 2){
        
        HomePaThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellThrid" forIndexPath:indexPath];
        cell.array = self.activeArray;
        cell.delegate = self;
        [cell.tableView reloadData];
        
        return cell;
    }else if (indexPath.section == 3){
        HomePaFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFour" forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.compostitionArray[indexPath.row]];
//        [cell.im setBackgroundImage:[UIImage imageNamed:self.compostitionArray[indexPath.row]] forState:UIControlStateNormal];

        return cell;
    }else if (indexPath.section == 4){
        HomePaFiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFive" forIndexPath:indexPath];
//        cell.lableArray = self.jxArray;
        
    
     
            WriteListModel *model  = self.jxArray[indexPath.row];
            NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
            [cell.image sd_setImageWithURL:[NSURL URLWithString:str]];
            cell.dipLabel.text = model.MicroclassInfoTitle;
       
        
    
        
        return cell;
    }else if (indexPath.section == 5){
        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSix" forIndexPath:indexPath];
        BookModel *model1 = self.bookArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.BookPic];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];

        cell.label1.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        cell.label2.text = [NSString stringWithFormat:@"出版社:%@",model1.BookPublic];
        cell.label3.text = [NSString stringWithFormat:@"添加时间:%@",model1.BookAddTime];
        cell.label4.text = [NSString stringWithFormat:@"作者:%@",model1.BookAuthor];
        cell.label5.text = model1.BookPublic;
        cell.label6.text = [NSString stringWithFormat:@"阅读人数:%@",model1.BookIntroduction];
        return cell;
    }else if (indexPath.section == 7){
        RingSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSeven" forIndexPath:indexPath];
        GroupModel *model = self.GroupArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.GroupIcon];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];

        cell.titleLabel.text = model.GroupName;
        cell.userNumLabel.text = [NSString stringWithFormat:@"用户：%@",model.JoinNum];
        cell.listLabel.text = [NSString stringWithFormat:@"类别：%@",model.TypeName];
        cell.textView.text = [NSString stringWithFormat:@"圈子简介：%@",model.GroupInfo];
        return cell;
    }else if (indexPath.section == 6){
        MircFiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celleghit" forIndexPath:indexPath];
        cell.array = self.dianpingArray;
        cell.delegate = self;
        [cell.tableView reloadData];
        
        return cell;
    }
    return nil;
}

- (void)gotoMircFiveCell:(NSIndexPath *)index{
    
//    SubmissionController *vc = [[SubmissionController alloc]init];
//    ActiveInfoModel *model = self.activeArray[index.row];
//    //    NSLog(@"---%@",model.activetype);
//    vc.SubActiveID = model.activeid;
//    [self.navigationController pushViewController:vc animated:YES];
    
//    DianPingModel *Model = self.dianpingArray[index.row];
//    DPdetailViewController *vc = [[DPdetailViewController alloc]init];
//    vc.dpID = Model.DPid;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    WedpViewController *vc = [[WedpViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, HeightFrame/3);
    }else if (indexPath.section == 1){
        return CGSizeMake(WidthFrame, (WidthFrame-20*5)/4*2+10+10+2);
        
    }
    else if (indexPath.section == 2){
        return CGSizeMake(WidthFrame-30, 120);
        
    }
    else if (indexPath.section == 3){
        return CGSizeMake((WidthFrame-30-20*2)/3, 80);
        
    }
    else if (indexPath.section == 4){
//        return CGSizeMake((WidthFrame-20*3)/5*2, 110);
        
          return CGSizeMake((WidthFrame-30-20*2)/3, 110);
        
    }
    else if (indexPath.section == 5){
        return CGSizeMake(WidthFrame/2-20, 110);
        
    }
    else if (indexPath.section == 6){
        return CGSizeMake(WidthFrame/2-20, 100);
        
    }
    else if (indexPath.section == 7){
        return CGSizeMake(WidthFrame-30, 80);
        
    }else
        return CGSizeZero;
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else if (section == 1){
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(2, 15, 2, 15);;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section ==1) {
        return CGSizeZero;
    }else
        return CGSizeMake(WidthFrame, 25);
    
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0 || indexPath.section == 1) {
            
            return nil;
        }else {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            HomePaFristheadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            if (indexPath.section == 2){
                view.textLable.text = @"志愿者活动";
                
                button = view.bt;
                button.tag = 1000;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
               
                
            }else if (indexPath.section == 3){
                
                view.textLable.text = @"作文习作";
                button = view.bt;
                button.tag = 1001;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 4){
                view.textLable.text = @"微课堂";
                button = view.bt;
                button.tag = 1002;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 5){
                view.textLable.text = @"阅读与评测";
                button = view.bt;
                button.tag = 1003;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 7){
                view.textLable.text = @"圈子";
                button = view.bt;
                button.tag = 1004;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 6){
                view.textLable.text = @"大家点评";
                button = view.bt;
                button.tag = 1005;
                [button addTarget:self action:@selector(goMore:) forControlEvents:UIControlEventTouchUpInside];
            }
            return view;
            
        }
    }
    return nil;
    
}



#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 3) {
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabbarVC = delegate.tabbarVc;
        tabbarVC.selectedIndex = 1;
        tabbarVC.selectedViewController = tabbarVC.viewControllers[1];
    }else if (indexPath.section == 4) {
        
//        MicrodetailController *vc = [[MicrodetailController alloc]init];
//
//
//        if (indexPath.section == 1) {
//
//            WriteListModel *model = self.startArray[indexPath.item];
//
//            vc.classId = model.ID;
//            [self.navigationController pushViewController:vc animated:YES];
        
        WriteListModel *model = self.jxArray[indexPath.item];
//        MicrodetailController *vc = [[MicrodetailController alloc]init];
        NewMicrodetailController *vc = [[NewMicrodetailController alloc]init];
        vc.classId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 5){
        BookDetailViewController *vc = [[BookDetailViewController alloc]init];
        BookModel *model = self.bookArray[indexPath.item];
        vc.bookid = model.ID;
        if (self.xf.Loginid == NULL) {
            [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        }else{
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 6){
        RingdetaiController *vc = [[RingdetaiController alloc]init];
        
        GroupModel *model = self.GroupArray[indexPath.item];
        vc.ringId = model.Id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)GetLabelTypeTreelistAll{
    GetLabelTypeTreelistAllRequst *requst = [[GetLabelTypeTreelistAllRequst alloc]init];
    [requst GetLabelTypeTreelistAllRequstwithID:@"0" withFlag:@"0" withmodelid:@"1" :^(NSDictionary *json) {
        RingViewController *ringVc = [[RingViewController alloc]init];
        ringVc.dic = json;
        [self.navigationController pushViewController:ringVc animated:NO];
    }];
    
}
-(void)Eightfunction:(UIButton *)bt{
    if (bt.tag == 1000) {
        //作文库
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabbarVC = delegate.tabbarVc;
        tabbarVC.selectedIndex = 1;
        tabbarVC.selectedViewController = tabbarVC.viewControllers[1];
    }else if (bt.tag ==1001) {
         //微课堂
        MicroClassViewController *microVC = [[MicroClassViewController alloc]init];
        
        
        [self.navigationController pushViewController:microVC animated:NO];
        
    }else if (bt.tag ==1002){
         //阅读与测评
        ReadAndEViewController *readVC = [[ReadAndEViewController alloc]init];
        [self.navigationController pushViewController:readVC animated:NO];
    }else if (bt.tag ==1003){
         //志愿者活动
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabbarVC = delegate.tabbarVc;
        tabbarVC.selectedIndex = 2;
        tabbarVC.selectedViewController = tabbarVC.viewControllers[2];
    }else if (bt.tag ==1006){
         //圈子
        [self GetLabelTypeTreelistAll];
    }else if (bt.tag ==1004){
         //活动
        
        ActiveViewController *activityVc = [[ActiveViewController alloc]init];
        
        [self.navigationController pushViewController:activityVc animated:NO];
        
    }else if (bt.tag ==1005){
         //大家点评
        WedpViewController *vc = [[WedpViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }else if (bt.tag ==1007){
        //语文
        WeyuwenViewController *vc = [[WeyuwenViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)goMore :(UIButton *)bt{
    if (bt.tag == 1000) {
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabbarVC = delegate.tabbarVc;
        tabbarVC.selectedIndex = 2;
        tabbarVC.selectedViewController = tabbarVC.viewControllers[2];
    }else if (bt.tag == 1001){
        
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UITabBarController *tabbarVC = delegate.tabbarVc;
        tabbarVC.selectedIndex = 1;
        tabbarVC.selectedViewController = tabbarVC.viewControllers[1];
    }else if (bt.tag == 1002){
        MicroClassViewController *vc = [[MicroClassViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (bt.tag == 1003){
        ReadAndEViewController *readVC = [[ReadAndEViewController alloc]init];
        [self.navigationController pushViewController:readVC animated:NO];
    
    }else if (bt.tag == 1004){
        RingViewController *vc = [[RingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (bt.tag == 1005){
        WedpViewController *vc = [[WedpViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    

}

#pragma mark 如果不想实现直接去掉此方法即可
- (void)ScrollViewDidClickAtAnyImageView:(UIImageView *)imageView {
    
    NSLog(@"%ld --  %@",imageView.tag, imageView.image);
    
}

@end
