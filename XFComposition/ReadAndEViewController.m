//
//  ReadAndEViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadAndEViewController.h"
#import "RingFristCell.h"//重用 第一行
#import "ReadSecondCell.h"//第2 3行
#import "HomePaSixCell.h"//第4 5行
#import "ReadSixCell.h"
#import "ReadSenvenCell.h"
#import "ReadeightCell.h"
#import "ReadTenCell.h"
#import "HomePaFristheadView.h"
#import "MicReplaceCell.h"

#import "HomeBookRequst.h"//图书列表
#import "BookModel.h"
#import "GetBookBjRequst.h"//读书笔记
#import "GetBookBjModel.h"
#import "GetBookPaiHangRequst.h"//获取图书排行
#import "GetBookPaihangModel.h"
#import "GetReadStartRequst.h"//获取阅读排行
#import "GetReadStartModel.h"
#import "ReadBoBaoRequst.h"//阅读播报

#import "BookRecViewController.h"
#import "ReadinotesViewController.h"
#import "BookRankViewController.h"
#import "BookDetailViewController.h"

@interface TYCollectionHeaderView : UICollectionReusableView
@end

@implementation TYCollectionHeaderView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = hexColor(e9f4fc);
        [self setUI];
    }
    return self;
}
- (void)setUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 30)];
    view.backgroundColor = hexColor(3b9891);
    [self addSubview:view];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"南京市中小学生数学图书馆";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:16];
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UIImage *img = [UIImage imageNamed:@"ic_read_pic_fly_right"];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = img;
    [view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lab.mas_left);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(imgView.mas_height).multipliedBy(119/25.f);
    }];
    
    UIImageView *imgView_right = [[UIImageView alloc] init];
    imgView_right.image = [UIImage imageNamed:@"ic_read_pic_fly_left"];//ic_read_pic_fly_left
    [view addSubview:imgView_right];
    [imgView_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(imgView.mas_height).multipliedBy(119/25.f);
    }];
    
    
}

@end


typedef void(^MoreMessageBlock)();
@interface TYCollectionImgHeaderView : UICollectionReusableView
@property (nonatomic,copy) MoreMessageBlock moreMessageBlock;
@property (nonatomic, strong) UIButton *bt;
@property (nonatomic, strong) UILabel *lab;

@end

@implementation TYCollectionImgHeaderView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}
- (void)setUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
    [self addSubview:view];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, view.height)];
    imgView.image = [UIImage imageNamed:@"bg_read_title"];
    [view addSubview:imgView];
    
    _lab = [[UILabel alloc] init];
    _lab.text = @"";
    _lab.textColor = [UIColor whiteColor];
    _lab.font = [UIFont systemFontOfSize:16];
    [view addSubview:_lab];
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_left).offset(10);
        make.centerY.mas_equalTo(imgView.mas_centerY);
    }];
    self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt setTitle:@" 更多 " forState:UIControlStateNormal];
    self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.bt setBackgroundColor:[UIColor colorWithHexString:@"3893CF"]];
    [self.bt addTarget:self action:@selector(doMore) forControlEvents:UIControlEventTouchUpInside];
    self.bt.layer.cornerRadius = 10;
    self.bt.clipsToBounds=YES;
    [view addSubview:self.bt];
    [self.bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgView.mas_right);
        make.centerY.mas_equalTo(imgView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
}
- (void)doMore {
    if (self.moreMessageBlock) {
        self.moreMessageBlock();
    }
}
@end
@interface ReadAndEViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UIView *alpha_view;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *tuijianbookArray;
@property (nonatomic,strong)NSMutableArray *xuexiaobookArray;
@property (nonatomic,strong)NSMutableArray *xianfengbookArray;
@property (nonatomic,strong)NSMutableArray *remenbookArray;
@property (nonatomic,strong)NSMutableArray *booBJArray;
@property (nonatomic,strong)NSMutableArray *weekArray;
@property (nonatomic,strong)NSMutableArray *monthArray;
@property (nonatomic,strong)NSMutableArray *readpaihangArray1;
@property (nonatomic,strong)NSMutableArray *readpaihangArray2;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation ReadAndEViewController
-(NSMutableArray *)tuijianbookArray{
    if (!_tuijianbookArray) {
        _tuijianbookArray  = [[NSMutableArray alloc]init];
    }
    return _tuijianbookArray;
}
-(NSMutableArray *)xuexiaobookArray{
    if (!_xuexiaobookArray) {
        _xuexiaobookArray = [[NSMutableArray alloc]init];
    }
    return _xuexiaobookArray;
}
-(NSMutableArray *)xianfengbookArray{
    if (!_xianfengbookArray) {
        _xianfengbookArray = [[NSMutableArray alloc]init];
    }
    return _xianfengbookArray;
}
-(NSMutableArray *)remenbookArray{
    if (!_remenbookArray) {
        _remenbookArray = [[NSMutableArray alloc]init];
    }
    return _remenbookArray;
}
-(NSMutableArray *)booBJArray{
    if (!_booBJArray) {
        _booBJArray = [[NSMutableArray alloc]init];
    }
    return _booBJArray;
}
-(NSMutableArray *)weekArray{
    if (!_weekArray) {
        _weekArray = [[NSMutableArray alloc]init];
    }
    return _weekArray;
}
-(NSMutableArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [[NSMutableArray alloc]init];
    }
    return _monthArray;
}
-(NSMutableArray *)readpaihangArray1{
    if (!_readpaihangArray1) {
        _readpaihangArray1 = [[NSMutableArray alloc]init];
    }
    return _readpaihangArray1;
}
-(NSMutableArray *)readpaihangArray2{
    if (!_readpaihangArray2) {
        _readpaihangArray2 = [[NSMutableArray alloc]init];
    }
    return _readpaihangArray2;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self bookRequst:self.tuijianbookArray :@"8" :@"0" :@"0" :@"0" :@"0" :@"1"];
        [self bookRequst:self.xianfengbookArray :@"4" :@"0" :@"0" :@"211440" :@"0" :@"0"];
        [self bookRequst:self.xuexiaobookArray :@"8" :@"0" :@"0" :@"0" :@"1" :@"0"];
        [self bookRequst:self.remenbookArray :@"2" :@"0" :@"1" :@"0" :@"0" :@"0"];

        [self readBJRequst];
        [self GetBookpaihangRequst:@"0" :self.weekArray];//周排行
        [self GetBookpaihangRequst:@"1" :self.monthArray];//月排行
        
        [self ReadStartRequst:@"0" :@"4" :self.readpaihangArray1];//阅读排行
//        [self ReadStartRequst:@"1" :@"4" :self.readpaihangArray2];
//        [self getReadBoBao:@"1"];//阅读播报
//        [self getReadBoBao:@"2"];//阅读播报
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
    titleLab.text = @"阅读与评测";
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
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[RingFristCell class] forCellWithReuseIdentifier:@"Read1"];
        [_collectionView registerClass:[ReadSecondCell class] forCellWithReuseIdentifier:@"Read23"];
        [_collectionView registerClass:[HomePaSixCell class] forCellWithReuseIdentifier:@"Read45"];
        [_collectionView registerClass:[ReadSixCell class] forCellWithReuseIdentifier:@"Read6"];
        [_collectionView registerClass:[ReadSenvenCell class] forCellWithReuseIdentifier:@"Read79"];
        [_collectionView registerClass:[ReadeightCell class] forCellWithReuseIdentifier:@"Read8"];
        [_collectionView registerClass:[ReadTenCell class] forCellWithReuseIdentifier:@"Read10"];
        [_collectionView registerClass:[MicReplaceCell class] forCellWithReuseIdentifier:@"MicReplaceCell"];
        
        [_collectionView registerClass:[HomePaFristheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];//注册cell的headview
        [_collectionView registerClass:[TYCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
        //TYCollectionImgHeaderView
        [_collectionView registerClass:[TYCollectionImgHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header3"];

    }
    return _collectionView;
}
/*
//图书列表
"Action:GetBookList
Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
PageIndex:1
PageSize:20
chaperid：0        //l类别
author:  “鲁迅”     //作者
keyword：”幻城”    //书名
booktype：-1     //默认
isdaodu: 0      //  是否导读
istuijian：0      // 是否推荐
ishost：0        //是否热门
quxian：0      //区县
xuexiao：0    //学校"
*/
-(void)bookRequst :(NSMutableArray *)array :(NSString *)pagesize :(NSString *)tuijian :(NSString *)isHost :(NSString *)quxian :(NSString *)student :(NSString *)teacher{
    HomeBookRequst *bookRequst = [[HomeBookRequst alloc]init];
    [bookRequst HomeGetBookListWithchaperid:tuijian :pagesize :isHost :quxian :student :teacher :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            BookModel *model = [BookModel loadWithJSOn:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    
}

//读书笔记
-(void)readBJRequst{
    GetBookBjRequst *requst = [[GetBookBjRequst alloc]init];
    [requst GetBookBjRequstWithPageIndex:@"1" withPageSize:@"8" withflag:@"1" withistuijian:@"0" :^(NSDictionary *json) {
        [self.booBJArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
            [self.booBJArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    

}
//获取图书排行
-(void)GetBookpaihangRequst :(NSString *)flag :(NSMutableArray *)array{
    GetBookPaiHangRequst *requst = [[GetBookPaiHangRequst alloc]init];
    [requst GetBookPaiHangRequstWithflag:flag :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetBookPaihangModel *model = [GetBookPaihangModel loadWithJSOn:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}
//获取阅读排行
-(void)ReadStartRequst :(NSString *)flag :(NSString *)num :(NSMutableArray *)array{
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:flag withnum:num :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [array addObject:model];
        }

            [self.collectionView reloadData];

        
    }];

}
//阅读播报
-(void)getReadBoBao :(NSString *)flag{
    ReadBoBaoRequst *requst = [[ReadBoBaoRequst alloc]init];
    [requst ReadBoBaoRequstWithPageIndex:@"1" withPageSize:@"4" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
        
    }];
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.xianfengbookArray.count == 0) {
            return 0;
        }
        return self.xianfengbookArray.count;
    }else if (section == 2){
        if (self.xuexiaobookArray.count == 0) {
            return 0;
        }
        return self.xuexiaobookArray.count;
    }else if (section == 3){
        if (self.tuijianbookArray.count == 0) {
            return 0;
        }
        return self.tuijianbookArray.count;
    }else if (section == 4){
        if (self.remenbookArray.count ==0) {
            return 0;
        }
        return self.remenbookArray.count;
    }else if (section == 5){
        return 0;//横幅
    }else if (section == 6){
        return self.booBJArray.count;//读书笔记
    }else if (section == 7){
        return 1;//10大排行
    }else if (section == 8){
        return self.readpaihangArray1.count;//读书排行
    }
    return 0;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 9;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RingFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read1" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"banner_yuedu"];
        
        return cell;
    }
    else if (indexPath.section == 1){
        if (self.tuijianbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read45" forIndexPath:indexPath];
        BookModel *model1 = self.xianfengbookArray[indexPath.row];
        cell.model = model1;
        return cell;
    }
    else if (indexPath.section == 2){
        if (self.xuexiaobookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        ReadSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read23" forIndexPath:indexPath];
        BookModel *model1 = self.xuexiaobookArray[indexPath.row];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model1.BookPic] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        return cell;
    }else if (indexPath.section == 3){
//        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read45" forIndexPath:indexPath];
//        BookModel *model1 = self.tuijianbookArray[indexPath.row];
//
//        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model1.BookPic] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
//        //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str]];
//        cell.label1.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
//        cell.label2.text = [NSString stringWithFormat:@"出版社:%@",model1.BookPublic];
//        cell.label3.text = [NSString stringWithFormat:@"添加时间:%@",model1.BookAddTime];
//        cell.label4.text = [NSString stringWithFormat:@"作者:%@",model1.BookAuthor];
//        cell.label5.text = model1.BookPublic;
//        cell.label6.text = [NSString stringWithFormat:@"阅读人数:%@",model1.BookIntroduction];
        if (self.tuijianbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        ReadSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read23" forIndexPath:indexPath];
        BookModel *model1 = self.tuijianbookArray[indexPath.row];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model1.BookPic] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        return cell;

        return cell;
    }else if (indexPath.section == 4){
        if (self.remenbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read45" forIndexPath:indexPath];
        BookModel *model1 = self.remenbookArray[indexPath.row];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model1.BookPic] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.label1.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        cell.label2.text = [NSString stringWithFormat:@"出版社:%@",model1.BookPublic];
        cell.label3.text = [NSString stringWithFormat:@"添加时间:%@",model1.BookAddTime];
        cell.label4.text = [NSString stringWithFormat:@"作者:%@",model1.BookAuthor];
        cell.label5.text = model1.BookPublic;
        cell.label6.text = [NSString stringWithFormat:@"阅读人数:%@",model1.BookIntroduction];
        return cell;
    }else if (indexPath.section == 5){
//        ReadSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read6" forIndexPath:indexPath];
//        return  cell;
    }else if (indexPath.section == 6){
        ReadSenvenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read79" forIndexPath:indexPath];
        GetBookBjModel *model = self.booBJArray[indexPath.row];
        cell.textLable.text = model.deptname;
        cell.schoolLabel.text = model.username;
        return  cell;
    }else if (indexPath.section == 7){
        ReadeightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read8" forIndexPath:indexPath];
        cell.Warray = self.weekArray;
        cell.Marray = self.monthArray;
        return cell;
    }else if (indexPath.section == 8){
        ReadTenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read10" forIndexPath:indexPath];
//        GetReadStartModel *model = self.readpaihangArray1[indexPath.row];
        cell.model = self.readpaihangArray1[indexPath.row];
        
        return  cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, HeightFrame/3);
        
    }else if (indexPath.section == 1){
//        return CGSizeMake((WidthFrame-20-30)/4, HeightFrame/6+20);
        return CGSizeMake(WidthFrame/2-15, 110);

        
    }else if (indexPath.section == 2){
        return CGSizeMake((WidthFrame-20-30)/4, HeightFrame/6+20);
        
    }
    else if (indexPath.section == 3){
//        return CGSizeMake(WidthFrame/2-15, 110);
        return CGSizeMake((WidthFrame-20-30)/4, HeightFrame/6+20);

        
    }else if (indexPath.section == 4){
        return CGSizeMake(WidthFrame/2-15, 110);
        
    }
    else if (indexPath.section == 5){
        return CGSizeMake(WidthFrame, 40);//横幅
        
    }else if (indexPath.section == 6){
        return CGSizeMake(WidthFrame-40, 30);
        
    }else if (indexPath.section == 7){
        return CGSizeMake(WidthFrame-40, 230);
        
    }else if (indexPath.section == 8){
//        return CGSizeMake(WidthFrame-40, 80);
        return CGSizeMake(WidthFrame-40, 30);

        
    }
    return CGSizeZero;
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else if (section == 1 || section == 2 ){
        
        return UIEdgeInsetsMake(5, 10, 5, 10);
    
    }else if (section == 3 || section == 4){
        return UIEdgeInsetsMake(5, 10, 5, 10);
    
    }else if (section == 7){
        return UIEdgeInsetsMake(5, 20, 5, 20);
    
    }
    else if (section == 6 || section == 8){
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
    
}

//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
// 竖向   设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }else if (section == 5) {
        return CGSizeMake(WidthFrame, 40);
    }
    else{
        return CGSizeMake(WidthFrame, 30);
    }
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0 ) {
            
            return nil;
        }else if (indexPath.section == 5) {
            TYCollectionHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
            return view;
        }
        else if(indexPath.section == 1||indexPath.section == 2||indexPath.section == 3||indexPath.section == 4){
            
            HomePaFristheadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button = view.bt;
            if (indexPath.section == 1){
                view.bt.hidden = NO;
                view.textLable.text = @"先锋推荐";
                button.tag  = 1000;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 2){
                 view.bt.hidden = NO;
                view.textLable.text = @"学生推荐";
                button.tag  = 1001;
            }else if (indexPath.section == 3){
                 view.bt.hidden = NO;
                view.textLable.text = @"老师推荐";
                button.tag  = 1002;
            }else if (indexPath.section == 4){
                 view.bt.hidden = NO;
                view.textLable.text = @"热门推荐";
                button.tag  = 1003;
            }
            return view;
            
        }else {
            TYCollectionImgHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header3" forIndexPath:indexPath];
            if (indexPath.section == 6){
                headerView.lab.text = @"读书笔记";
            }else if (indexPath.section == 7){
                headerView.lab.text = @"十大读书排行榜";
            }else if (indexPath.section == 8){
                headerView.lab.text = @"读书排行";
            }
            headerView.moreMessageBlock = ^{//更多
                
            };
            return headerView;
        }
    }
    return nil;
    
}
-(void)gotoMore :(UIButton *)bt{
    if (bt.tag == 1000 || bt.tag == 1001 || bt.tag == 1002 || bt.tag == 1003  ) {
        BookRecViewController *vc = [[BookRecViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (bt.tag ==1004){
        
        ReadinotesViewController *vc = [[ReadinotesViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (bt.tag ==1006){
        
        BookRankViewController *vc = [[BookRankViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else{
        if (self.xf.Loginid == NULL) {
            [SVProgressHUD showInfoWithStatus:@"您还未登录"];
            return;
        }
        BookDetailViewController *vc = [[BookDetailViewController alloc]init];
        
        if (indexPath.section == 1) {
            BookModel *model1 = self.tuijianbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 2){
            BookModel *model1 = self.xuexiaobookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 3){
            BookModel *model1 = self.xianfengbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 4){
            BookModel *model1 = self.remenbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
}
@end
