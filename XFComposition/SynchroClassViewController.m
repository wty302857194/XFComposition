//
//  SynchroClassViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SynchroClassViewController.h"
//#import "SynchroHeadView.h"
#import "MicroClassTypeRquset.h"
#import "MicroClassTypeModel.h"
#import "MicroClassGradeModel.h"
#import "MicroClassLists.h"
#import "WriteListModel.h"
#import "MicoThridCell.h"
#import "MicrodetailController.h"
#import "TopMenuView.h"
#import "NewMicrodetailController.h"

@interface SynchroClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    UIButton *_oneBtn,*_twoBtn;
    BOOL _isFresh;
    NSInteger _page;
}
@property (nonatomic,strong) UIView *topBackView;
@property (nonatomic,strong)UICollectionView *collectionView;
//@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)TopMenuView *menuView;
@property (nonatomic,strong)NSString *Fristparameter;
@property (nonatomic,strong)NSString *Secondeparameter;
@property (nonatomic,strong)NSString *Thridparameter;
@property (nonatomic,strong)NSArray *classArray;
@property (nonatomic,strong)NSMutableArray *tizaiArray;//体载
@property (nonatomic,strong)NSMutableArray *gradeArray;//年级
@property (nonatomic,strong)NSMutableDictionary *gradeDic;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)NSMutableArray *array3;
@property (nonatomic,strong)NSMutableArray *allMicArray;//数据

@property (nonatomic,strong)NSMutableArray *btnArray1;
@property (nonatomic,strong)NSMutableArray *btnArray2;
@property (nonatomic,strong)NSMutableArray *btnArray3;

@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UIButton *threeBtn;
@end

@implementation SynchroClassViewController
-(NSArray *)classArray{
    if (!_classArray) {
        _classArray = @[@"所有课程",@"即将进行",@"正在进行",@"已经结束"];
    }
    return _classArray;
}
-(NSMutableArray *)array3{
    if (!_array3) {
        _array3 = [[NSMutableArray alloc]init];
    }
    return _array3;
}
- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, 40)];
        _topBackView.backgroundColor = [UIColor whiteColor];
        
        
        
        NSArray *arr = @[@"所有课程",@"所有分类",@"所有年级"];
        for (int i = 0; i<arr.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake((kScreenWidth/3.f)*i, 0, kScreenWidth/3.f, _topBackView.height);
            bt.tag = 1000+i;
            bt.backgroundColor = [UIColor whiteColor];
            [bt setTitle:arr[i] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor colorWithHexString:@"323232"] forState:UIControlStateNormal];
            [bt setImage:[UIImage imageNamed:@"bottomJianTou"] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(topMenuClick:) forControlEvents:UIControlEventTouchUpInside];
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
            [_topBackView addSubview:bt];
            
            [bt setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:2];

            if (i == 0) {
                _oneBtn = bt;
            }else if(i == 1) {
                _twoBtn = bt;
            }else {
                _threeBtn = bt;
            }
        }
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
        lab.backgroundColor= [UIColor colorWithHexString:@"f4f5f6"];
        [_topBackView addSubview:lab];
    }
    return _topBackView;
}
- (TopMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[[NSBundle mainBundle] loadNibNamed:@"TopMenuView" owner:nil options:nil] lastObject];
        _menuView.frame = CGRectMake(0, kLayoutViewMarginTop+40, WidthFrame, HeightFrame-kLayoutViewMarginTop-40);
        _menuView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _menuView.selectTypeBlock = ^(NSString *data_name,NSString *data_id,NSString *indexValue,NSInteger index) {
            weakSelf.menuView.hidden = YES;
            [weakSelf.selectBtn setTitle:data_name forState:UIControlStateNormal];
            
            
            if ([indexValue isEqualToString:@"1000"]) {
                weakSelf.Fristparameter = data_id;
            }else if ([indexValue isEqualToString:@"1001"]) {
                
                weakSelf.Secondeparameter = data_id;
                MicroClassTypeModel *model = weakSelf.tizaiArray[index];
                
                for (ChildgradeModel *model2 in model.childgrade) {
                    [weakSelf.array3 addObject:model2];
                }
                
                ChildgradeModel *model2 = model.childgrade[0];
                weakSelf.Thridparameter = model2.gid;
                [weakSelf.threeBtn setTitle:model2.gradename?:@"" forState:UIControlStateNormal];
            }else {
                weakSelf.Thridparameter = data_id;
            }
            
            _isFresh = NO;
            _page = 1;
            [weakSelf GetMicroClass];
        };
        [self.view addSubview:_menuView];
    }
    return _menuView;
}
- (void)topMenuClick:(UIButton *)btn
{
    if (!self.menuView.isHidden) {
        self.menuView.hidden = YES;
        return;
    }
    _page = 1;
    self.menuView.hidden = NO;
    self.menuView.data_index = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    switch (btn.tag) {
        case 1000:
        {
            self.menuView.dataArr = [NSArray arrayWithArray:self.classArray];
        }
            break;
        case 1001:
        {
            //            MicroClassTypeModel *model = self.tizaiArray[i];
            self.menuView.dataArr = [NSArray arrayWithArray:self.tizaiArray];
        }
            break;
        case 1002:
        {
            self.menuView.dataArr = [NSArray arrayWithArray:self.array3];
        }
            break;
            
        default:
            break;
    }
    
    self.selectBtn = btn;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kLayoutViewMarginTop+40, WidthFrame, HeightFrame-kLayoutViewMarginTop-40) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MicoThridCell class] forCellWithReuseIdentifier:@"MicCell3"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
    
}
-(NSMutableArray *)tizaiArray {
    if (!_tizaiArray) {
        _tizaiArray = [[NSMutableArray alloc]init];
    }
    return _tizaiArray;
}
-(NSMutableArray *)gradeArray{
    if (!_gradeArray) {
        _gradeArray = [[NSMutableArray alloc]init];
    }
    return _gradeArray;
}
-(NSMutableDictionary *)gradeDic{
    if (!_gradeDic) {
        _gradeDic = [[NSMutableDictionary alloc]init];
    }
    return _gradeDic;
}
-(NSString *)Fristparameter{
    if (!_Fristparameter) {
        _Fristparameter = @"";
    }
    return _Fristparameter;
}
-(NSString *)Secondeparameter{
    if (!_Secondeparameter) {
        _Secondeparameter = @"";
    }
    return _Secondeparameter;
}
-(NSString *)Thridparameter{
    if (!_Thridparameter) {
        _Thridparameter = @"";
    }
    return _Thridparameter;
}

-(NSMutableArray *)allMicArray{
    if (!_allMicArray) {
        _allMicArray = [[NSMutableArray alloc]init];
    }
    return _allMicArray;
}
-(NSMutableArray *)btnArray1{
    if (!_btnArray1) {
        _btnArray1 = [[NSMutableArray alloc]init];
    }
    return _btnArray1;
}
-(NSMutableArray *)btnArray2{
    if (!_btnArray2) {
        _btnArray2 = [[NSMutableArray alloc]init];
    }
    return _btnArray2;
}
-(NSMutableArray *)btnArray3{
    if (!_btnArray3) {
        _btnArray3 = [[NSMutableArray alloc]init];
    }
    return _btnArray3;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"同步课堂";
    self.navigationItem.hidesBackButton =NO;
    [self.view addSubview:self.topBackView];
    _page = 1;
    self.Fristparameter = @"0";//默认第一行选中
    [self.view addSubview:self.collectionView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self GetMicroType];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    [self.collectionView.mj_header beginRefreshing];
    
    
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        _isFresh = YES;
        _page++;
        
        [self GetMicroClass];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}

-(void)GetMicroType{
    __weak typeof (self) weakSelf = self;
    MicroClassTypeRquset *requst = [[MicroClassTypeRquset alloc]init];
    [requst GetmicrTypeWith:@"2" :^(NSDictionary *json) {
        NSLog(@"json === %@",json);
        [weakSelf.tizaiArray removeAllObjects];
        [weakSelf.gradeArray removeAllObjects];
        NSArray *arr = @[@{@"gid":@"",@"gradename":@"所有年级"}];
        NSDictionary *myDic = @{@"tizainame":@"所有分类",@"zaitiid":@"",@"childgrade":arr};
        
        NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:json[@"ret_data"]];
        [mutableArr addObject:myDic];
        
        for (NSDictionary *dic in mutableArr) {
            MicroClassTypeModel *model = [MicroClassTypeModel mj_objectWithKeyValues:dic];
            [weakSelf.tizaiArray addObject:model];            
        }
        
        MicroClassTypeModel *moren = weakSelf.tizaiArray[0];
        weakSelf.Secondeparameter = moren.zaitiid;//默认第2行一开始选中
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic2 in moren.childgrade) {
            ChildgradeModel *model2 = [ChildgradeModel mj_objectWithKeyValues:dic2];
            [array addObject:model2];
        }
        [weakSelf.array3 addObjectsFromArray:array];
        
        [self GetMicroClass];
    }];
    
}
-(void)GetMicroClass{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetMicroClassList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"changeId":self.Fristparameter,
                          @"masterId":self.Secondeparameter,
                          @"subjectId":self.Thridparameter,
                          @"PageIndex":@(_page),
                          @"PageSize":@"20",
                          @"prostatic":@"-1",
                          @"recommed":@"-1",
                          @"timeSpan":@"0"
                          };
    
    NSLog(@"dic === %@",dic);
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        NSLog(@"ForecastUrl === %@",succeedResult);
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *arr = succeedResult[@"ret_data"][@"pageInfo"];
        if (_isFresh) {
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    WriteListModel *model = [WriteListModel loadWithJSOn:dic];
                    [self.allMicArray addObject:model];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"没有更多了" inView:self.view];
            }
        }else {
            [self.allMicArray removeAllObjects];
            
            if (arr&&arr.count>0) {
                for (NSDictionary *dic in arr) {
                    WriteListModel *model = [WriteListModel loadWithJSOn:dic];
                    [self.allMicArray addObject:model];
                }
            }else {
                NSLog(@"没有更多了");
                [Global promptMessage:@"暂无数据" inView:self.view];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
    
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allMicArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MicoThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell3" forIndexPath:indexPath];
    WriteListModel *model  = self.allMicArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"Mic01"] options:SDWebImageRefreshCached];
    cell.titleLabel.text = model.MicroclassInfoTitle;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthFrame/3-30,HeightFrame/8+20);
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 20, 2, 20);
    
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WriteListModel *model  = self.allMicArray[indexPath.row];
    
//    MicrodetailController *vc = [[MicrodetailController alloc]init];
    NewMicrodetailController *vc = [[NewMicrodetailController alloc]init];

    vc.classId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"选择%ld",indexPath.item);
}
-(void)leftBarButton{
//    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//    bt.frame = CGRectMake(0, 0, 20, 20);
//    [bt setBackgroundImage:[UIImage imageNamed:@"ty_jianTouLeft"] forState:UIControlStateNormal];
//    [bt addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
//
////    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ty_jianTouLeft"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
//    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:bt];
//    self.navigationItem.leftBarButtonItem=item;

    GO_BACK;
}
-(void)goBackNV{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
