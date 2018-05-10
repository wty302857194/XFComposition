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
#import "TopMenuView.h"

static NSInteger const topViewHeight = 155;
typedef void(^TYMessageBlock)(NSString *contentStr);
@interface TYChooseView : UIView
@property (nonatomic, copy) TYMessageBlock messageBlock;
@property (nonatomic, copy) UILabel *namelab;
@end

@implementation TYChooseView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    
    _namelab = [[UILabel alloc] init];
    _namelab.text = @"书名：";
    _namelab.font = [UIFont systemFontOfSize:15];

    [self addSubview:_namelab];
    [_namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.mas_equalTo(10);
    }];
    [_namelab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.mas_equalTo(_namelab.mas_right).offset(10);
        make.right.mas_equalTo(-10);
    }];
}
- (void)textChange:(UITextField *)textField {
    if (self.messageBlock) {
        self.messageBlock(textField.text);
    }
}
@end

#import "BookDetailViewController.h"
@interface BookRecViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *_keyWard;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) TopMenuView *menuView;
@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,copy) NSString *bookStr;
@property (nonatomic,copy) NSString *messageStr;
@property (nonatomic,copy) NSString *isDaoDu;
//@property (nonatomic,strong)MenuView *menuView;
//@property (nonatomic,strong)MenuView *menuView2;
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
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, topViewHeight)];
        
        TYChooseView *leftView = [[TYChooseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2.f, 50)];
        leftView.namelab.text = @"书名：";
         __weak typeof(self) weakSelf = self;
        leftView.messageBlock = ^(NSString *contentStr) {
            weakSelf.bookStr = contentStr;
        };
        [_topView addSubview:leftView];
        
        TYChooseView *rightView = [[TYChooseView alloc] initWithFrame:CGRectMake(kScreenWidth/2.f, 0, kScreenWidth/2.f, 50)];
        rightView.namelab.text = @"作者：";
        rightView.messageBlock = ^(NSString *contentStr) {
            weakSelf.messageStr = contentStr;
        };
        [_topView addSubview:rightView];
        
        UILabel *daDuLab = [[UILabel alloc] init];
        daDuLab.text = @"有导读视频";
        daDuLab.font = [UIFont systemFontOfSize:15];

        [_topView addSubview:daDuLab];
        [daDuLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftView.mas_bottom).offset(10);
            make.left.mas_equalTo(20);
        }];
        
        UIButton *tag_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tag_btn setBackgroundImage:[UIImage imageNamed:@"ic_first_icon"] forState:UIControlStateNormal];
        [tag_btn setBackgroundImage:[UIImage imageNamed:@"ic_first_icon_"] forState:UIControlStateSelected];
        [tag_btn addTarget:self action:@selector(isVedio:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:tag_btn];
        [tag_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(daDuLab.mas_centerY);
            make.left.mas_equalTo(daDuLab.mas_right).offset(5);
            make.width.height.mas_equalTo(20);
        }];
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        searchBtn.layer.cornerRadius = 5;
        searchBtn.layer.masksToBounds = YES;
        searchBtn.backgroundColor = navigation_barColor(1);
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];

        [searchBtn addTarget:self action:@selector(secrchClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(daDuLab.mas_centerY);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(120);
        }];
        
        [_topView layoutIfNeeded];
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBtn.frame)+10, kScreenWidth, 1)];
        lineLab.backgroundColor = hexColor(f4f5f6);
        [_topView addSubview:lineLab];
        
        for (int i = 0; i<2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*kScreenWidth/2.f, CGRectGetMaxY(lineLab.frame), kScreenWidth/2.f, 50);
            [btn setTitleColor:hexColor(323232) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            if (i == 0) {
                [btn setTitle:@"先锋推荐" forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"全部年级" forState:UIControlStateNormal];
            }
            [btn setImage:[UIImage imageNamed:@"bottomJianTou"] forState:UIControlStateNormal];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(menuSelect:) forControlEvents:UIControlEventTouchUpInside];
            [_topView addSubview:btn];
            [btn setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:5];
            
        }
        
        UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLab.frame)+50, kScreenWidth, 1)];
        lineLab1.backgroundColor = hexColor(f4f5f6);
        [_topView addSubview:lineLab1];
    }
    return _topView;
}
- (void)isVedio:(UIButton *)btn {
    btn.selected=!btn.selected;
    if(btn.isSelected) {
        self.isDaoDu = @"1";
    }else {
        self.isDaoDu = @"0";
    }
}
- (void)secrchClick {
    
    [self GetBookList:self.quxianStr :self.gradeStr];

}
- (void)menuSelect:(UIButton *)btn {
    if (!self.menuView.isHidden) {
        self.menuView.hidden = YES;
        return;
    }
    _page = 1;
    self.menuView.hidden = NO;
    self.menuView.data_index = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    if(btn.tag == 100) {
        self.menuView.dataArr = [NSArray arrayWithArray:self.menuarray];
    }else {
        self.menuView.dataArr = [NSArray arrayWithArray:self.menuarray2];

    }
    _selectBtn = btn;
}
- (TopMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[[NSBundle mainBundle] loadNibNamed:@"TopMenuView" owner:nil options:nil] lastObject];
        _menuView.frame = CGRectMake(0, self.topView.bottom, WidthFrame, HeightFrame-kLayoutViewMarginTop-40);
        _menuView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _menuView.selectTypeBlock = ^(NSString *data_name,NSString *data_id,NSString *indexValue,NSInteger index) {
            weakSelf.menuView.hidden = YES;
            if([data_id isEqualToString:@"100"]) {
                weakSelf.quxianStr = weakSelf.strArray1[index];
            }else {
                weakSelf.gradeStr = weakSelf.strArray2[index];
            }
            [weakSelf GetBookList:weakSelf.quxianStr :weakSelf.gradeStr];
            [weakSelf.selectBtn setTitle:data_name forState:UIControlStateNormal];
        };
        [self.view addSubview:_menuView];
    }
    return _menuView;
}
-(XFUserInfo *)xf {
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topViewHeight+kLayoutViewMarginTop, WidthFrame, HeightFrame-kLayoutViewMarginTop - topViewHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BookRecCell class] forCellWithReuseIdentifier:@"bookreccell"];
        [_collectionView registerClass:[BookRecHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];//注册cell的headview
    }
    return _collectionView;
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
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    
    self.isDaoDu = @"0";
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
    GO_BACK;
}
- (void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}
//市区列表
-(void)getdepschoollsit{
//    GetDeptSchoolListRequst *requst = [[GetDeptSchoolListRequst alloc]init];
//    [requst GetDeptSchoolListRequstWithblock:^(NSDictionary *json) {
//        [self.ShiArray removeAllObjects];
//        [self.menuarray removeAllObjects];
//        [self.strArray1 removeAllObjects];
//        for (NSDictionary *dic in json[@"ret_data"]) {
//            GetDeptSchoolListModel *model = [GetDeptSchoolListModel loadWithJSOn:dic];
//            [self.ShiArray addObject:model];
//            [self.menuarray addObject:model.deptname];
//            [self.strArray1 addObject:model.deptid];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData];
//        });
//    }];
    
    NSArray *arr = @[
                     @{@"deptid":@"211440",@"deptname":@"先锋推荐"},
                     @{@"deptid":@"211441",@"deptname":@"全部市"},
                     @{@"deptid":@"211442",@"deptname":@"直属"},
                     @{@"deptid":@"211472",@"deptname":@"玄武区"},
                     @{@"deptid":@"211573",@"deptname":@"秦淮区"},
                     @{@"deptid":@"211721",@"deptname":@"建业区"},
                     @{@"deptid":@"211813",@"deptname":@"鼓楼区"},
                     @{@"deptid":@"211989",@"deptname":@"浦口区"},
                     @{@"deptid":@"211160",@"deptname":@"栖霞区"},
                     @{@"deptid":@"211296",@"deptname":@"雨花台区"},
                     @{@"deptid":@"211379",@"deptname":@"江宁区"},
                     @{@"deptid":@"211667",@"deptname":@"化工园区"},
                     @{@"deptid":@"211714",@"deptname":@"溧水区"},
                     @{@"deptid":@"211789",@"deptname":@"高淳县"}
                     ];
    for (NSDictionary *dic in arr) {
        GetDeptSchoolListModel *model = [GetDeptSchoolListModel loadWithJSOn:dic];
        [self.ShiArray addObject:model];
        [self.menuarray addObject:model.deptname];
        [self.strArray1 addObject:model.deptid];
    }
    [self.collectionView reloadData];

}
//全部年级
-(void)GetGradeList{
    GetBookTypeRequst *requst = [[GetBookTypeRequst alloc]init];
    [requst GetBookTypeRequst:^(NSDictionary *json) {
        [self.gradeArray removeAllObjects];
        [self.menuarray2 removeAllObjects];
        [self.strArray2 removeAllObjects];
        NSMutableArray *arr = [json[@"ret_data"] mutableCopy];
        NSDictionary *dataDic = @{@"BookTypeName":@"全部年级",@"Itemlist":@[],@"id":@"0"};
        [arr insertObject:dataDic atIndex:0];
        for (NSDictionary *dic in arr) {
            GetBookTypeModel *model = [GetBookTypeModel loadWithJSOn:dic];

            [self.gradeArray addObject:model];
            [self.menuarray2 addObject:model.BookTypeName];
            [self.strArray2 addObject:model.BookTypeid];
        }
    }];
}
//获取图书列表
-(void)GetBookList :(NSString *)quxian :(NSString *)grade{
    self.page = 1;
    GetBookListRequst *requst = [[GetBookListRequst alloc]init];
    [requst GetBookListRequstWithPageIndex:@"1" withPageSize:@"20" withchaperid:grade withauthor:self.messageStr?:@"" withkeyword:self.bookStr?:@"" withbooktype:@"0" withisdaodu:self.isDaoDu withistuijian:@"0" withishost:@"0" withquxian:quxian withxuexiao:@"" :^(NSDictionary *json) {
        
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
    NSString *str = [NSString stringWithFormat:@"%@",model.BookPic];
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
//// 设置section头视图的参考大小，与tableheaderview类似
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(WidthFrame, 30);
//
//}
//
//#pragma mark 头部显示的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionHeader){
//        BookRecHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//        view.backgroundColor = [UIColor whiteColor];
//        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bt setTitle:@"市" forState:UIControlStateNormal];
//        [bt addTarget:self action:@selector(showSHI) forControlEvents:UIControlEventTouchUpInside];
//        bt.frame = CGRectMake(WidthFrame/6, 5, WidthFrame/6, 20);
//        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [view addSubview:bt];
//
//        self.gradeBt = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.gradeBt setTitle:@"全部年级" forState:UIControlStateNormal];
//        [self.gradeBt addTarget:self action:@selector(showGrage) forControlEvents:UIControlEventTouchUpInside];
//        self.gradeBt.frame = CGRectMake(WidthFrame/8*5, 5, WidthFrame/4, 20);
//        [self.gradeBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 29, WidthFrame, 1)];
//        label.backgroundColor = [UIColor lightGrayColor];
//        [view addSubview:label];
//        [view addSubview:self.gradeBt];
//
//
//        return view;
//    }
//    return nil;
//}
//-(void)showSHI{
//    [self.menuView2 dismissView];
//    _isShow2 = NO;
//    _isShow1 = !_isShow1;
//    if (_isShow1) {
//        [self.menuView showView];
////        [self.menuView.tableView reloadData];
//    }else{
//        [self.menuView dismissView];
//    }
//
//
//}
//-(void)showGrage{
//    [self.menuView dismissView];
//    _isShow1 = NO;
//
//    _isShow2 = !_isShow2;
//    if (_isShow2) {
//        [self.menuView2 showView];
//        //        [self.menuView.tableView reloadData];
//    }else{
//        [self.menuView2 dismissView];
//    }
//}
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

@end
