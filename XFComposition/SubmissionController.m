//
//  SubmissionController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SubmissionController.h"
#import "RecruiteacherFristCell.h"
#import "SubmissonsecondCell.h"
//#import "SubmissionHeadView.h"
#import "ActivityDetailRequst.h"
#import "ActivityDetailModel.h"
#import "GetActiveWriteList.h"
#import "ActiveWriteListModel.h"
#import "MenuView.h"

#import "BookwritingController.h"
@interface SubmissionController ()<UICollectionViewDelegate,UICollectionViewDataSource,RecruiteacherFristCellDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)ActivityDetailModel *model;
@property (nonatomic,strong)NSMutableArray *writeArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UITableView *reshTableView;

@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,strong)MenuView *menuView2;
@property (nonatomic,strong)MenuView *menuView3;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,assign)BOOL isShow2;
@property (nonatomic,assign)BOOL isShow3;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)NSString *str2;
@property (nonatomic,strong)NSString *str3;
@end

@implementation SubmissionController
-(ActivityDetailModel *)model{
    if (!_model) {
        _model = [[ActivityDetailModel alloc]init];
    }
    return _model;
}
-(NSMutableArray *)writeArray{
    if (!_writeArray) {
        _writeArray = [[NSMutableArray alloc]init];
    }
    return _writeArray;
}
-(UITableView *)reshTableView{
    if (!_reshTableView) {
        _reshTableView = [[UITableView alloc]init];
    }
    return _reshTableView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];

        _collectionView.backgroundColor =  [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[RecruiteacherFristCell class] forCellWithReuseIdentifier:@"cell1"];
        [_collectionView registerClass:[SubmissonsecondCell class] forCellWithReuseIdentifier:@"cell2"];
//        [_collectionView registerClass:[SubmissionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
//        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
    
}
-(void)creatHeadView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,HeightFrame/4+200, WidthFrame, 40)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:backView];
    NSArray *array = [[NSArray alloc]init];
    array = @[@"请选择活动",@"作品类别",@"作品状态"];
    
    for (int i = 0; i<3; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(WidthFrame/3*i,0, WidthFrame/3, 40);
        bt.tag = 1000+i;
        [bt setTitle:array[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:bt];
    }
    
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部活动",@"国庆节活动",@"中秋节活动",@"暑假征文活动"];
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(20, HeightFrame/4+200+40, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow3 = NO;
            NSLog(@"%ld",(long)i);
            if (i == 0) {
                self.str1 = @"0";
            }else if (i == 1){
                self.str1 = @"1";
            }else if (i == 2){
                self.str1 = @"2";
            }else if (i == 3){
                self.str1 = @"3";
            }
//            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.collectionView addSubview:_menuView1];
    }
    return _menuView1;
}
-(MenuView *)menuView2{
    if (!_menuView2) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部类别",@"征文",@"投稿"];
        _menuView2 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/3+10, HeightFrame/4+200+40, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow2 = NO;
            if (i == 0) {
                self.str2 = @"-1";
            }else if (i == 1){
                self.str2 = @"0";
            }else if (i == 2){
                self.str2 = @"1";
            }
//            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.collectionView addSubview:_menuView2];
    }
    return _menuView2;
}
-(MenuView *)menuView3{
    if (!_menuView3) {
        
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部",@"待审核",@"没有入库",@"入库"];
        _menuView3 = [[MenuView alloc]initWithFrame:CGRectMake(WidthFrame/3*2, HeightFrame/4+200+40, WidthFrame/3-20, 30*array.count) cellarray:array block:^(NSInteger i) {
            weakSelf.isShow3 = NO;
            weakSelf.page = 1;
            if (i == 0) {
                self.str3 = @"-2";
            }else if (i == 1){
                self.str3 = @"0";
            }else if (i == 2){
                self.str3 = @"1";
            }else if (i == 3){
                self.str3 = @"2";
            }
//            [weakSelf GetMyActiveWorkList:weakSelf.textfield.text :weakSelf.str1 :weakSelf.str2 :weakSelf.str3];
        }];
        [self.collectionView addSubview:_menuView3];
    }
    return _menuView3;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.navigationItem.title =@"主题征文";
    [self.view addSubview:self.collectionView];
    [self creatHeadView];
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self detaiRequst];
//        [self writList];
//        [self.collectionView.mj_header endRefreshing];
//    }];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
//    self.collectionView.mj_header = header;
//
//    [self.collectionView.mj_header beginRefreshing];
    [self detaiRequst];
    [self writList];
//    SubmissonsecondCell *cell = [[SubmissonsecondCell alloc]init];
    

}
-(void)detaiRequst{
    ActivityDetailRequst *requst = [[ActivityDetailRequst alloc]init];
    self.model = [[ActivityDetailModel alloc]init];
    
    [requst ActivityDetailwithActiveID:self.SubActiveID :^(NSDictionary *josn) {
        
        self.model = [ActivityDetailModel loadWithJSOn:josn[@"ret_data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
    
}
-(void)writList{
    GetActiveWriteList *requst = [[GetActiveWriteList alloc]init];
    [self.writeArray removeAllObjects];
    [requst GetActiveWriteListWithActId:self.SubActiveID withProductionName:@"" withActiveItem:@"-1" withWriteStatic:@"2" withPageIndex:@"1" withPageSize:@"10" withWriteTypeID:@"-1" withGroupID:@"-2" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            ActiveWriteListModel *model = [ActiveWriteListModel loadWithJSOn:dic];
            [self.writeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        
    }];
    
}
-(void)requstMore{
    self.page+=1;
    
    GetActiveWriteList *requst = [[GetActiveWriteList alloc]init];
    
    [requst GetActiveWriteListWithActId:self.SubActiveID withProductionName:@"" withActiveItem:@"-1" withWriteStatic:@"2" withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"10" withWriteTypeID:@"-1" withGroupID:@"-2" :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            ActiveWriteListModel *model = [ActiveWriteListModel loadWithJSOn:dic];
            [self.writeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.reshTableView reloadData];
        });

    }];
    
    
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
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
        RecruiteacherFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.delegate = self;
        cell.titleLabel.text = self.model.activeName;
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.model.activePic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"mp321"] options:SDWebImageRefreshCached];
        cell.timeLabel.text = [NSString stringWithFormat:@"活动时间：%@~%@",[self.model.activeEndTime substringToIndex:9],[self.model.activeEndTime substringToIndex:9]];
        cell.xqlabel.text = @"活动详情：";
        cell.mingelabel.text = @"(限制10名额)";

        NSAttributedString *att = [[NSAttributedString alloc] initWithData:[[self.model.activeInfo stringByRemovingPercentEncoding] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        cell.textView.attributedText = att;//html转富文本
        
        return cell;
    }else if (indexPath.section == 1){
        SubmissonsecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        self.reshTableView = cell.tableView;
        cell.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{


            [self requstMore];
            [cell.tableView.mj_footer endRefreshing];
        }];
        cell.array = self.writeArray;
        return cell;

    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(WidthFrame, HeightFrame/4+200);
    }else
        return CGSizeMake(WidthFrame, 300);
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(2, 0, 2, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(WidthFrame, 40);
    
}
//#pragma mark 头部显示的内容
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionHeader){
//        if (indexPath.section == 1){
//            SubmissionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
//            headView.delegate = self;
//            
//            return headView;
//        }
//        return nil;
//    }
//    return nil;
//}
-(void)click:(UIButton *)bt{
    
    if (bt.tag == 1000) {
        
        _isShow1 = !_isShow1;
        if (_isShow1) {
            [self.menuView1 showView];
        }else{
            [self.menuView1 dismissView];
        }
        
    }else if (bt.tag == 1001){
        
        _isShow2 = !_isShow2;
        if (_isShow2) {
            [self.menuView2 showView];
        }else{
            [self.menuView2 dismissView];
        }
        
        
    }else if (bt.tag == 1002){
        
        _isShow3 = !_isShow3;
        if (_isShow3) {
            [self.menuView3 showView];
        }else{
            [self.menuView3 dismissView];
        }
        
        
    }
    
}

-(void)reshData:(NSString *)str :(NSString *)str2 :(NSString *)str3{
    
    NSLog(@"%@   %@   %@",str,str2,str3);
    //WriteTypeID:-1         //类别 -1全部0征文1投稿
    //WriteStatic:-2         / /习作状态 -2全部，0待审核2入围1没有入围
    //GroupID:-2                 //圈子标识 -2全部
    //ProductionName:  ""   //习作关键词
    if ([str isEqualToString:@"作品类别"]) {
        str = @"-1";
    }else if ([str isEqualToString:@"征文"]){
        str = @"0";
    
    }else if ([str isEqualToString:@"投稿"]){
        
        str = @"1";
    }
    if ([str2 isEqualToString:@"作品状态"]) {
        str2 = @"-2";
    }else if ([str2 isEqualToString:@"待审核"]) {
        str2 = @"0";
    }else if ([str2 isEqualToString:@"没有入库"]) {
        str2 = @"1";
    }else if ([str2 isEqualToString:@"入库"]) {
        str2 = @"2";
    }
    if ([str3 isEqualToString:@"请选择圈子"]) {
        str3 = @"-2";
    }else {
        str3 = @"0";
    }
//    else if ([str3 isEqualToString:@""]) {
//        
//    }else if ([str3 isEqualToString:@""]) {
//        
//    }
    NSLog(@"%@   %@   %@",str,str2,str3);
    
    GetActiveWriteList *requst = [[GetActiveWriteList alloc]init];
    [self.writeArray removeAllObjects];
    [requst GetActiveWriteListWithActId:self.SubActiveID withProductionName:@"" withActiveItem:@"-1" withWriteStatic:str2 withPageIndex:@"1" withPageSize:@"20" withWriteTypeID:str withGroupID:str3 :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            ActiveWriteListModel *model = [ActiveWriteListModel loadWithJSOn:dic];
            [self.writeArray addObject:model];
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSIndexSet *indexSetA = [[NSIndexSet alloc]initWithIndex:1];
//
//            [self.collectionView reloadSections:indexSetA];
            [self.collectionView reloadData];
//        });

        
        
    }];

}
-(void)Submission{
    
  
    BookwritingController *vc = [[BookwritingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}


- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}
//去掉 HTML 字符串中的标签
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
