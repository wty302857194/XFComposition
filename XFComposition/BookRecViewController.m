//
//  BookRecViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookRecViewController.h"
#import "BookRecCell.h"
#import "BookRecHeaderView.h"
#import "MenuView.h"
#import "GetDeptSchoolListRequst.h"//市区
#import "GetDeptSchoolListModel.h"
#import "GetBookTypeRequst.h"//年级
#import "GetBookTypeModel.h"
#import "GetBookListRequst.h"//图书列表
#import "BookModel.h"

#import "BookDetailViewController.h"
@interface BookRecViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)MenuView *menuView;
@property (nonatomic,strong)MenuView *menuView2;
@property (nonatomic,strong)NSMutableArray *menuarray;
@property (nonatomic,strong)NSMutableArray *menuarray2;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,assign)BOOL isShow2;

@property (nonatomic,strong)NSMutableArray *ShiArray;
@property (nonatomic,strong)NSMutableArray *gradeArray;
@property (nonatomic,strong)NSMutableArray *bookArray;
@property (nonatomic,strong)NSString *quxianStr;
@property (nonatomic,strong)NSString *gradeStr;

@property (nonatomic,strong)NSMutableArray *strArray1;
@property (nonatomic,strong)NSMutableArray *strArray2;
@property (nonatomic,strong)UIButton *shiBt;
@property (nonatomic,strong)UIButton *gradeBt;
@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation BookRecViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BookRecCell class] forCellWithReuseIdentifier:@"bookreccell"];
        [_collectionView registerClass:[BookRecHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];//注册cell的headview
    }
    return _collectionView;
}
-(MenuView *)menuView{
    if (!_menuView) {
        
        __weak typeof (self) weakSelf = self;
        _menuView = [[MenuView alloc]initWithFrame:CGRectMake(0, 0+30, WidthFrame, 30*self.menuarray.count) cellarray:self.menuarray block:^(NSInteger index) {
            weakSelf.isShow1 = NO;
            weakSelf.quxianStr = weakSelf.strArray1[index];
//            [self.shiBt setTitle:nil forState:UIControlStateNormal];
//            [self.shiBt setTitle:self.menuarray[index] forState:UIControlStateNormal];
            [weakSelf GetBookList:weakSelf.quxianStr :weakSelf.gradeStr];
            
        }];
        [self.collectionView addSubview:_menuView];
    }
    return _menuView;
}
-(MenuView *)menuView2{
    if (!_menuView2) {
        
        __weak typeof (self) weakSelf = self;
        _menuView2 = [[MenuView alloc]initWithFrame:CGRectMake(0, 0+30, WidthFrame, 30*self.menuarray2.count) cellarray:self.menuarray2 block:^(NSInteger index) {
            weakSelf.isShow2 = NO;
            
            weakSelf.gradeStr = weakSelf.strArray2[index];
//            [self.gradeBt setTitle:nil forState:UIControlStateNormal];
//            [self.gradeBt setTitle:self.menuarray2[index] forState:UIControlStateNormal];

            [weakSelf GetBookList:weakSelf.quxianStr :weakSelf.gradeStr];
        }];
        [self.collectionView addSubview:_menuView2];
    }
    return _menuView2;
}


-(NSMutableArray *)menuarray{
    if (!_menuarray) {
        _menuarray = [[NSMutableArray alloc]init];
    }
    return _menuarray;
}
-(NSMutableArray *)menuarray2{
    if (!_menuarray2) {
        _menuarray2 = [[NSMutableArray alloc]init];
    }
    return _menuarray2;
}
-(NSMutableArray *)ShiArray{
    if (!_ShiArray) {
        _ShiArray = [[NSMutableArray alloc]init];
    }
    return _ShiArray;
}
-(NSMutableArray *)gradeArray{
    if (!_gradeArray) {
        _gradeArray = [[NSMutableArray alloc]init];
    }
    return _gradeArray;
}
-(NSString *)quxianStr{
    if (!_quxianStr) {
        _quxianStr = [[NSString alloc]init];
    }
    return _quxianStr;
}
-(NSString *)gradeStr{
    if (!_gradeStr) {
        _gradeStr = [[NSString alloc]init];
    }
    return _gradeStr;
}
-(NSMutableArray *)bookArray{
    if (!_bookArray) {
        _bookArray = [[NSMutableArray alloc]init];
    }
    return _bookArray;
}
-(NSMutableArray *)strArray1{
    if (!_strArray1) {
        _strArray1 = [[NSMutableArray alloc]init];
    }
    return _strArray1;
}
-(NSMutableArray *)strArray2{
    if (!_strArray2) {
        _strArray2 = [[NSMutableArray alloc]init];
    }
    return _strArray2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图书推荐";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    [self.view addSubview:self.collectionView];
    self.page = 1;
    self.quxianStr = @"";
    self.gradeStr = @"";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getdepschoollsit];
        [self GetGradeList];
        [self GetBookList:self.quxianStr :self.gradeStr];
        [self.collectionView.mj_header endRefreshing];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore:self.quxianStr :self.gradeStr];
        [self.collectionView.mj_footer endRefreshing];
    }];
    //触摸事件
//    UITapGestureRecognizer *tapG=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboadHide:)];
//    tapG.cancelsTouchesInView=NO;
//    [self.collectionView addGestureRecognizer:tapG];

}
//-(void)keyboadHide:(UITapGestureRecognizer *)tapG{
////    _isShow1 = NO;
////    [self.menuView dismissView];
//}
//市区列表
-(void)getdepschoollsit{
    GetDeptSchoolListRequst *requst = [[GetDeptSchoolListRequst alloc]init];
    [requst GetDeptSchoolListRequstWithblock:^(NSDictionary *json) {
        [self.ShiArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetDeptSchoolListModel *model = [GetDeptSchoolListModel loadWithJSOn:dic];
            [self.ShiArray addObject:model];
        }
        [self.menuarray removeAllObjects];
        [self.strArray1 removeAllObjects];
        for (GetDeptSchoolListModel *model in self.ShiArray) {
            [self.menuarray addObject:model.deptname];
            [self.strArray1 addObject:model.deptid];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

}
//全部年级
-(void)GetGradeList{
    GetBookTypeRequst *requst = [[GetBookTypeRequst alloc]init];
    [requst GetBookTypeRequst:^(NSDictionary *json) {
        [self.gradeArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetBookTypeModel *model = [GetBookTypeModel loadWithJSOn:dic];

            [self.gradeArray addObject:model];
            
        }
        [self.menuarray2 removeAllObjects];
        [self.strArray2 removeAllObjects];
        for (GetBookTypeModel *model in self.gradeArray) {
            [self.menuarray2 addObject:model.BookTypeName];
            [self.strArray2 addObject:model.BookTypeid];
        }
    }];
}
//获取图书列表
-(void)GetBookList :(NSString *)quxian :(NSString *)grade{
    
    GetBookListRequst *requst = [[GetBookListRequst alloc]init];
    [requst GetBookListRequstWithPageIndex:@"1" withPageSize:@"20" withchaperid:grade withauthor:@"" withkeyword:@"" withbooktype:@"0" withisdaodu:@"0" withistuijian:@"0" withishost:@"0" withquxian:quxian withxuexiao:@"" :^(NSDictionary *json) {
        
        [self.bookArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            BookModel *model = [BookModel loadWithJSOn:dic];
            [self.bookArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];

}
-(void)requstMore :(NSString *)quxian :(NSString *)grade{
    self.page +=1;
    GetBookListRequst *requst = [[GetBookListRequst alloc]init];
    [requst GetBookListRequstWithPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withchaperid:grade withauthor:@"" withkeyword:@"" withbooktype:@"0" withisdaodu:@"0" withistuijian:@"0" withishost:@"0" withquxian:quxian withxuexiao:@"" :^(NSDictionary *json) {
        
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            BookModel *model = [BookModel loadWithJSOn:dic];
            [self.bookArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookRecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bookreccell" forIndexPath:indexPath];
    BookModel *model = self.bookArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.BookPic];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.BookName];
    cell.timeLabel.text = [NSString stringWithFormat:@"推荐时间：%@",model.BookAddTime];
    cell.chubanLabel.text = [NSString stringWithFormat:@"出版社：%@",model.BookPublic];
    cell.authorLabel.text = [NSString stringWithFormat:@"作者：%@",model.BookAuthor];
    cell.gradeLabel.text = [NSString stringWithFormat:@"年级：%@",model.Booktypename];
    cell.numLabel.text = [NSString stringWithFormat:@"阅读次数：%@",model.BookAttirbute1];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WidthFrame/2-0.5, 140);
    
}
// 设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(WidthFrame, 30);
    
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader){
        BookRecHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"市" forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(showSHI) forControlEvents:UIControlEventTouchUpInside];
        bt.frame = CGRectMake(WidthFrame/6, 5, WidthFrame/6, 20);
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view addSubview:bt];
        
        self.gradeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.gradeBt setTitle:@"全部年级" forState:UIControlStateNormal];
        [self.gradeBt addTarget:self action:@selector(showGrage) forControlEvents:UIControlEventTouchUpInside];
        self.gradeBt.frame = CGRectMake(WidthFrame/8*5, 5, WidthFrame/4, 20);
        [self.gradeBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 29, WidthFrame, 1)];
        label.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:label];
        [view addSubview:self.gradeBt];
        
        
        return view;
    }
    return nil;
}
-(void)showSHI{
    [self.menuView2 dismissView];
    _isShow2 = NO;
    _isShow1 = !_isShow1;
    if (_isShow1) {
        [self.menuView showView];
//        [self.menuView.tableView reloadData];
    }else{
        [self.menuView dismissView];
    }


}
-(void)showGrage{
    [self.menuView dismissView];
    _isShow1 = NO;
    
    _isShow2 = !_isShow2;
    if (_isShow2) {
        [self.menuView2 showView];
        //        [self.menuView.tableView reloadData];
    }else{
        [self.menuView2 dismissView];
    }
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"您还未登录"];
        return;
    }
    BookDetailViewController *vc = [[BookDetailViewController alloc]init];
    BookModel *model = self.bookArray[indexPath.row];
    vc.bookid = model.ID;
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
