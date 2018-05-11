//
//  MicroClassViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroClassViewController.h"
#import "MicoFristCell.h"

#import "MicoThridCell.h"
#import "MicoFourCell.h"
#import "MircFiveCell.h"
#import "MicReplaceCell.h"

#import "SecondHeadView.h"

#import "MicoClassRequst.h"
#import "WriteListModel.h"
#import "GetDinaPinListRequst.h"
#import "DianPingModel.h"
#import "GetVoleTeacherRequst.h"
#import "GetVoletacherModel.h"
#import "CommwritelistModel.h"
#import "SynchroClassViewController.h"
#import "WritingxzViewController.h"

#import "MicrodetailController.h"
#import "NewMicrodetailController.h"

@interface SecondFooterView : UICollectionReusableView

@end
@implementation SecondFooterView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"e9f4fc"];
    [self addSubview:view];
}
@end

@interface MicroClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MircFiveCellDelegate,UIScrollViewDelegate> {
    UIImageView *barImageView;
    UIView *alpha_view;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *startArray;
@property (nonatomic,strong)NSMutableArray *jxArray;
@property (nonatomic,strong)NSMutableArray *endArray;


@property (nonatomic,strong)NSMutableArray *dianpingArray;
@property (nonatomic,strong)NSMutableArray *teacherArray;

@end

@implementation MicroClassViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:navigation_barColor(1)];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self setStatusBarBackgroundColor:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MicoFristCell class] forCellWithReuseIdentifier:@"MicCell1"];
        [_collectionView registerClass:[MicoThridCell class] forCellWithReuseIdentifier:@"MicCell3"];
        [_collectionView registerClass:[MicoFourCell class] forCellWithReuseIdentifier:@"MicCell4"];
        [_collectionView registerClass:[MircFiveCell class] forCellWithReuseIdentifier:@"MicCell5"];
        [_collectionView registerClass:[MicReplaceCell class] forCellWithReuseIdentifier:@"MicReplaceCell"];
        _collectionView.showsVerticalScrollIndicator =NO;
        [_collectionView registerClass:[SecondHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    }
    return _collectionView;

}
-(NSMutableArray *)startArray{
    if (!_startArray) {
        _startArray = [[NSMutableArray alloc]init];
    }
    return _startArray;
}

-(NSMutableArray *)jxArray{
    if (!_jxArray) {
        _jxArray = [[NSMutableArray alloc]init];
    }
    return _jxArray;
    
}
-(NSMutableArray *)endArray{
    if (!_endArray) {
        _endArray = [[NSMutableArray alloc]init];
    }
    return _endArray;
}

-(NSMutableArray *)dianpingArray{
    if (!_dianpingArray) {
        _dianpingArray = [[NSMutableArray alloc]init];
    }
    return _dianpingArray;
}
-(NSMutableArray *)teacherArray{
    if (!_teacherArray) {
        _teacherArray = [[NSMutableArray alloc]init];
    }
    return _teacherArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self MicClassRequstList:@"1"];
        [self MicClassRequstList:@"2"];
        [self MicClassRequstList:@"3"];
        [self DianpingRequst];
        [self GetTeacher];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];

    [self myNavigationBarView];
}
- (void)myNavigationBarView {
    UIView *nav_view = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavigationBarHeight)];
    nav_view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav_view];
    
    alpha_view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, nav_view.width, nav_view.height)];
    alpha_view.alpha = 0;
    alpha_view.backgroundColor = navigation_barColor(1);
    [nav_view addSubview:alpha_view];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"微课堂";
    [nav_view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(nav_view.mas_centerX);
        make.centerY.mas_equalTo(nav_view.mas_centerY);
    }];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(11, (kNavigationBarHeight-20)/2.f, 20, 20);
    bt.backgroundColor = [UIColor clearColor];
    [bt setBackgroundImage:[UIImage imageNamed:@"ty_jianTouLeft"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(goBacka) forControlEvents:UIControlEventTouchUpInside];
    [nav_view addSubview:bt];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minAlphaOffset = - kLayoutViewMarginTop;
    CGFloat maxAlphaOffset = WidthFrame*200/375.f;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);

    if (offset == -kStatusBarHeight) {
        alpha = 0;
    }
    alpha_view.alpha = alpha;
}
-(void)goBacka{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//微课
-(void)MicClassRequstList :(NSString *)timespan{
    __weak typeof (self) weakSelf = self;
    MicoClassRequst *requst = [[MicoClassRequst alloc]init];
    [requst requstGetmicListWithchangId:@"2" Withmasterid:@"0" Withsubjectid:@"0" Withindex:@"1" Withpagesize:@"3" Withrecommed:@"-1" Withprostatic:@"-1" Withtimespan:timespan :^(NSDictionary *json) {
        if ([timespan isEqualToString:@"1"]) {

            [weakSelf.startArray removeAllObjects];
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                WriteListModel *model = [WriteListModel loadWithJSOn:dic];
                [weakSelf.startArray addObject:model];
            }
        }else if ([timespan isEqualToString:@"2"]){

            [weakSelf.jxArray removeAllObjects];
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                WriteListModel *model = [WriteListModel loadWithJSOn:dic];
                [weakSelf.jxArray addObject:model];
            }
        }else if ([timespan isEqualToString:@"3"]){

            [weakSelf.endArray removeAllObjects];
            for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
                WriteListModel *model = [WriteListModel loadWithJSOn:dic];
                [weakSelf.endArray addObject:model];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
    
}
//点评
-(void)DianpingRequst{
    __weak typeof (self) weakSelf = self;
    GetDinaPinListRequst *dianpingRequst = [[GetDinaPinListRequst alloc]init];
    [dianpingRequst GetDinaPinListRequswithPageIndex:@"1" withPageSize:@"10" withclassId:@"0" withmodelId:@"5" withkeyWord:@"" :^(NSDictionary *json) {
        [weakSelf.dianpingArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [weakSelf.dianpingArray addObject:model];
        }
        
    }];
    
    
}
//获取老师列表
-(void)GetTeacher{
    __weak typeof (self) weakSelf = self;
    GetVoleTeacherRequst *requst = [[GetVoleTeacherRequst alloc]init];
    [requst GetVoleTeacherRequstWithistuijian:@"0" withtop:@"3" :^(NSDictionary *json) {
        [weakSelf.teacherArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetVoletacherModel *model = [GetVoletacherModel loadWithJSOn:dic];
            
            [weakSelf.teacherArray addObject:model];
        }
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
        if (self.startArray.count == 0) {
            return 1;
        }else
        return self.startArray.count;
    }else if (section ==2){
        if (self.jxArray.count == 0) {
            return 1;
        }
        return self.jxArray.count;
    }else if (section ==3){
        if (self.endArray.count == 1) {
            return 1;
        }
        return self.endArray.count;
    }else if (section ==4){
        return self.teacherArray.count;
    }else if (section ==5){
        return 1;
    }

    return 0;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MicoFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell1" forIndexPath:indexPath];
        
//        UIButton *button = cell.bt;
//        [button addTarget:self action:@selector(goBacka) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else if (indexPath.section==1 ){
        if (self.startArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
            
        }
        MicoThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell3" forIndexPath:indexPath];
        WriteListModel *model  = self.startArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.titleLabel.text = model.MicroclassInfoTitle;
        
        return cell;
        
    }else if (indexPath.section==2){
        if (self.jxArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        MicoThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell3" forIndexPath:indexPath];
        WriteListModel *model  = self.jxArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.titleLabel.text = model.MicroclassInfoTitle;
        return cell;
    
    }else if (indexPath.section==3){
        if (self.endArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        MicoThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell3" forIndexPath:indexPath];
        WriteListModel *model  = self.endArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
        cell.titleLabel.text = model.MicroclassInfoTitle;

        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
        return cell;
        
    }
    
    else if (indexPath.section == 4){
        MicoFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell4" forIndexPath:indexPath];
        GetVoletacherModel *model = self.teacherArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.teacherPic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = model.teacherName;
        cell.jsLabel.text = [NSString stringWithFormat:@"%@  高级教师",model.teacherschool];;
        cell.gyLabel.text = [NSString stringWithFormat:@"公益值:%@",model.teacherGyNum];
        cell.djLabel.text = [NSString stringWithFormat:@"暂无星级"];
        cell.a = [model.teacherStartNum intValue];
        
        return cell;
    }else if (indexPath.section == 5){
        MircFiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell5" forIndexPath:indexPath];
        cell.delegate = self;
        cell.array = self.dianpingArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.tableView reloadData];
        });

        return cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, WidthFrame*200/375.f);
        
    }
    else if (indexPath.section == 1){
        if (self.startArray.count == 0) {
            return CGSizeMake(WidthFrame-40,40);
        }
        return CGSizeMake((WidthFrame-40-40)/3,HeightFrame/8+20);
        
    }
    else if (indexPath.section == 2){
        if (self.jxArray.count == 0) {
            return CGSizeMake(WidthFrame,40);
        }
        return CGSizeMake((WidthFrame-40-40)/3,HeightFrame/8+20);
    }
    else if (indexPath.section == 3){

        if (self.endArray.count == 0) {
            return CGSizeMake(WidthFrame,40);
        }
        return CGSizeMake((WidthFrame-40-40)/3,HeightFrame/8+20);
    }
    
    else if (indexPath.section == 4){
        
        return CGSizeMake((WidthFrame-20-20)/2, 90);
    }else if (indexPath.section == 5){
        return CGSizeMake(WidthFrame-30, 80);
    }
    return CGSizeZero;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0){
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(WidthFrame, 40);
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        SecondHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [view.Titlebt setTitle:@"即将开始" forState:UIControlStateNormal];
            view.moreBt.hidden = NO;
            button =view.moreBt;
            button.tag = 2001;
        }else if (indexPath.section == 2) {
            [view.Titlebt setTitle:@"正在进行" forState:UIControlStateNormal];
            view.moreBt.hidden = NO;
            button =view.moreBt;
            button.tag = 2002;
        }else if (indexPath.section == 3) {
            [view.Titlebt setTitle:@"已经结束" forState:UIControlStateNormal];
            view.moreBt.hidden = NO;
            button =view.moreBt;
            button.tag = 2003;
        }else if (indexPath.section == 4){
            [view.Titlebt setTitle:@"名师榜单" forState:UIControlStateNormal];
            button =view.moreBt;
            view.moreBt.hidden = YES;
            button.tag = 2004;
        }else if (indexPath.section == 5){
            [view.Titlebt setTitle:@"最新批改作业" forState:UIControlStateNormal];
             view.moreBt.hidden = YES;
            button =view.moreBt;
            button.tag = 2005;
        }
        [button addTarget:self action:@selector(doMore :) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
        
    } else {
        SecondFooterView *footerView = [[SecondFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        return footerView;
    }
    return nil;
    
}
-(void)doMore :(UIButton *)bt{
    if (bt.tag == 2001 || bt.tag == 2002 || bt.tag == 2003) {
        SynchroClassViewController *synchroVc = [[SynchroClassViewController alloc]init];
        [self.navigationController pushViewController:synchroVc animated:NO];
    }
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1 || section == 2 || section ==3) {
        return UIEdgeInsetsMake(2, 20, 2, 20);
    }else if (section == 4){
        
        return UIEdgeInsetsMake(2, 10, 2, 10);
    }else if (section == 5){
        
        return UIEdgeInsetsMake(2, 15, 2, 15);
    }
        return UIEdgeInsetsZero;
    
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    MicrodetailController *vc = [[MicrodetailController alloc]init];
    NewMicrodetailController *vc = [[NewMicrodetailController alloc] init];
    
    if (indexPath.section == 1) {
        
        WriteListModel *model = self.startArray[indexPath.item];
        
        vc.classId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2){
        WriteListModel *model = self.jxArray[indexPath.item];
        vc.classId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3){
        
        WriteListModel *model = self.endArray[indexPath.item];
        vc.classId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


-(void)gotoMircFiveCell :(NSIndexPath *)index
{
    WritingxzViewController *vc = [[WritingxzViewController alloc]init];
    DianPingModel *model = self.dianpingArray[index.row];
    vc.workId = model.DPid;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
