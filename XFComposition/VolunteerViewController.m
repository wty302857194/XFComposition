//
//  VolunteerViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerViewController.h"

#import "VolunteerFristCell.h"
#import "VolunteerThridCell.h"
#import "VolunteerFourCell.h"
#import "MicoFourCell.h"
#import "VolunteerActiviCell.h"
#import "VolunteerFrsitHeadView.h"
#import "VolunterrFristFootView.h"
#import "SecondHeadView.h" //和前面的一样
#import "VolunteerRequst.h"
#import "VolunteerModel.h"
#import "MicoClassRequst.h"
#import "WriteListModel.h"
#import "GetVoleTeacherRequst.h"
#import "GetVoletacherModel.h"
#import "IsVoleTeacherRequst.h"

#import "MicReplaceCell.h"
#import "ActivityController.h"
#import "RecruiteacherController.h"
#import "SubmissionController.h"
#import "ApplyViewController.h"
#import "BookwritingController.h"
#import "ApplyActiveViewController.h"
#import "MicrodetailController.h"

#import "TYVolunteerCollectionViewCell.h"
#import "VolunteerWebViewController.h"
#import "TYAllListViewController.h"

@interface VolunteerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,VolunterrApplyteacherDelegate,VolunteerDelegate,VolunteerFootDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *activityArray;//活动数据
@property (nonatomic,strong)NSMutableArray *newsArr;
@property (nonatomic,strong)NSMutableArray *microArray;
@property (nonatomic,strong)NSMutableArray *teacherArray;

@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)NSString *activityStr;
@property (nonatomic,strong)NSString *typestr;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation VolunteerViewController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator =NO;
        [_collectionView registerClass:[VolunteerFristCell class] forCellWithReuseIdentifier:@"FristCell"];
        [_collectionView registerClass:[TYVolunteerCollectionViewCell class] forCellWithReuseIdentifier:@"SecondCell"];
        [_collectionView registerClass:[VolunteerThridCell class] forCellWithReuseIdentifier:@"ThridCell"];

        [_collectionView registerClass:[MicoFourCell class] forCellWithReuseIdentifier:@"MicCell4"];
        [_collectionView registerClass:[MicReplaceCell class] forCellWithReuseIdentifier:@"MicReplaceCell"];
        [_collectionView registerClass:[VolunteerFrsitHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];
        [_collectionView registerClass:[VolunterrFristFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot1"];
        [_collectionView registerClass:[SecondHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    }
    return _collectionView;
}
-(NSArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [[NSMutableArray alloc]init];
    }
    return _activityArray;
}

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
-(NSMutableArray *)microArray{
    if (!_microArray) {
        _microArray = [[NSMutableArray alloc]init];
    }
    return _microArray;
}
-(NSMutableArray *)teacherArray{
    if (!_teacherArray) {
        _teacherArray = [[NSMutableArray alloc]init];
    }
    return _teacherArray;
}

-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        
    }
    return _xf;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.xf = [XFUserInfo getUserInfo];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"志愿者活动";
    _newsArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self.view addSubview:self.collectionView];
    self.activityStr = @"当前活动";
    self.typestr = @"2";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetReadAcitive:self.typestr];
        [self GetMicro];
        [self GetTeacher];
        [self getNewsListRequestData];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;

    [self.collectionView.mj_header beginRefreshing];
    
}



#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.activityArray.count==0) {
        return 1;
    }
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.activityArray.count==0) {
            return 1;
        }
        return 1;
    }else if (section == 2){
        return self.teacherArray.count;
    }else if (section == 3){
        return self.teacherArray.count;
    }
    return 0;
    
}
#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.activityArray.count==0) {
        return 1;
    }
    return 3;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.activityArray.count==0) {
        MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 0) {
        VolunteerFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FristCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        if (self.activityArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
            
        }
        TYVolunteerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecondCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.activeArr = self.activityArray;
        cell.newsArr = self.newsArr;
         __weak typeof(self) weakSelf = self;
        cell.moreMessageBlock = ^(NSInteger tag) {
            [weakSelf gotomoreActivity:tag];
        };
        cell.tableSelectBlock = ^(id model) {
            if ([model isKindOfClass:[VolunteerModel class]]) {
                VolunteerModel *volunteerModel = model;
                RecruiteacherController *vc = [[RecruiteacherController alloc]init];
                vc.RecruitActiveID = volunteerModel.activeid;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                VolunteerNewsListModel *newsModel = model;
                VolunteerWebViewController *vc = [[VolunteerWebViewController alloc] init];
                vc.urlStr = [self htmlEntityDecode:newsModel.NewContent?:@""];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return cell;
    }else if (indexPath.section == 3){
        if (self.microArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
            
        }
        VolunteerThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThridCell" forIndexPath:indexPath];

        WriteListModel *model1 = self.microArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.MicroclassInfoAttr1];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"glide_loading"] options:SDWebImageRefreshCached];
        return cell;
    }else if (indexPath.section == 2){
        MicoFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell4" forIndexPath:indexPath];
        GetVoletacherModel *model = self.teacherArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.teacherPic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"glide_loading"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = model.teacherName;
        cell.jsLabel.text = [NSString stringWithFormat:@"%@  高级教师",model.teacherschool];;
        cell.gyLabel.text = [NSString stringWithFormat:@"公益值:%@",model.teacherGyNum];
        
        cell.a = [model.teacherStartNum intValue];
        return cell;
    }


    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2){
//        WriteListModel *model1 = self.microArray[indexPath.item];
//
//        MicrodetailController *vc = [[MicrodetailController alloc]init];
//        vc.classId = model1.ID;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.activityArray.count==0) {
        return CGSizeMake(WidthFrame,HeightFrame);
    }
    if (indexPath.section == 0) {
        return CGSizeMake(WidthFrame, HeightFrame/3-44);
    }else if (indexPath.section == 1){
        if (self.activityArray.count == 0) {
            return CGSizeMake(WidthFrame,40);
        }
        return CGSizeMake(WidthFrame, 300);
        
    }else if (indexPath.section == 3){
        if (self.microArray.count == 0) {
            return CGSizeMake(WidthFrame-20,40);
        }
        return CGSizeMake((WidthFrame-20-20)/3, 80);//在这里能救第2行
    }
    return CGSizeMake((WidthFrame-20-20)/2, 90);
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }else if (section == 1){
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }else if (section == 2){
        return UIEdgeInsetsMake(2, 10, 2, 10);
        
    }
    return UIEdgeInsetsMake(2, 5, 2, 5);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 2||section == 3) {
        return CGSizeMake(WidthFrame, 40);
    }
    return CGSizeZero;
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 3){
            SecondHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
            headView.moreBt.hidden = YES;
            [headView.Titlebt setTitle:@"微课堂" forState:UIControlStateNormal];
            UIButton *button =headView.moreBt;
            button.tag=1003;
            [button addTarget:self action:@selector(gotobook) forControlEvents:UIControlEventTouchUpInside];
            return headView;
        }if (indexPath.section == 2){
            SecondHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
            headView.moreBt.hidden = YES;
            [headView.Titlebt setTitle:@"值班老师" forState:UIControlStateNormal];
            UIButton *button =headView.moreBt;
            button.tag=1004;
            [button addTarget:self action:@selector(gototeacher) forControlEvents:UIControlEventTouchUpInside];
            return headView;
        }
    }
    return nil;
    
}

-(void)GetReadAcitive :(NSString *)type{
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    
    [requset GetVolunteerRequstWithpagesize:1 :@"2" WithAcitivieTypeID:type :^(NSDictionary *josn) {

        [weakSelf.activityArray removeAllObjects];
        for (NSDictionary *dic in josn[@"ret_data"][@"pageInfo"]) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
            [weakSelf.activityArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });

    }];

}
- (void)getNewsListRequestData
{
    
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"GetNewsList",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"PageIndex":@"1",
                          @"PageSize":@"3"
                          };
    
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [self.newsArr removeAllObjects];
        NSLog(@"ForecastUrl === %@",succeedResult);
        NSArray *arr = succeedResult[@"ret_data"][@"pageInfo"];
        for (NSDictionary *dic in arr) {
            VolunteerNewsListModel *model = [VolunteerNewsListModel mj_objectWithKeyValues:dic];
            [self.newsArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
    }];
    
}
//微课堂
-(void)GetMicro{
    __weak typeof (self) weakSelf = self;
    MicoClassRequst *requst = [[MicoClassRequst alloc]init];
    [requst requstGetmicListWithchangId:@"2" Withmasterid:@"0" Withsubjectid:@"0" Withindex:@"1" Withpagesize:@"3" Withrecommed:@"-1" Withprostatic:@"-1" Withtimespan:@"0" :^(NSDictionary *json) {
        
        
        [weakSelf.microArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            WriteListModel *model = [WriteListModel loadWithJSOn:dic];
            [weakSelf.microArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
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


//更多活动按钮
-(void)gotomoreActivity:(NSInteger )intex{
    
    TYAllListViewController *vc = [[TYAllListViewController alloc]init];
    if (intex == 10) {
        vc.cellString = @"VolunteerActiveiTableViewCell";
    }else {
        vc.cellString = @"VolunteerNewsTableViewCell";
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
//头部按钮
-(void)VolunteerSrollView :(UIButton *)btn{
    for (UIButton *bt in self.btnArray){
        if (bt.tag == btn.tag) {
            [bt setTitleColor:UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
        }else
        {
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    if (btn.tag == 1000) {
        self.activityStr = @"志愿教师招募";
        self.typestr = @"2";
        [self GetReadAcitive:@"2"];
        
    }else if (btn.tag == 1001) {
        self.activityStr = @"新闻公告";
        self.typestr = @"0";
        [self getNewsListRequestData];
        
    }
    
}
-(void)gotodetail :(UIButton *)btn{
    //获取活动的type
    
    if ([self.activityStr isEqualToString:@"学生投稿活动"]) {
        
        SubmissionController *vc = [[SubmissionController alloc]init];
        VolunteerModel *model = self.activityArray[btn.tag-1000];
        vc.SubActiveID = model.activeid;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        RecruiteacherController *vc = [[RecruiteacherController alloc]init];
        VolunteerModel *model = self.activityArray[btn.tag-1000];
        vc.RecruitActiveID = model.activeid;
        [self.navigationController pushViewController:vc animated:YES];
    }


}

//申请成为志愿者教师
-(void)Applyteacher{
    //判断学生老师
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"请先登录"];
        return;
    }
    
    if ([self.xf.dutyId isEqualToString:@"1"]) {
        
        [SVProgressHUD showInfoWithStatus:@"您不是老师"];
        
        return;
    }
    
    ApplyViewController *vc = [[ApplyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
//申请工作
-(void)Applywork :(UIButton *)bt{
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"请先登录"];
        return;
    }
    if ([self.xf.dutyId isEqualToString:@"1"]) {
        [SVProgressHUD showInfoWithStatus:@"您不是老师"];
        return;
    }

    __weak typeof (self) weakSelf = self;
    IsVoleTeacherRequst *requst = [[IsVoleTeacherRequst alloc]init];
    [requst IsVoleTeacherRequstWithuserid:self.xf.Loginid :^(NSDictionary *json) {
        if ([json[@"ret_data"] integerValue] == 1) {
            
            if ([self.activityStr isEqualToString:@"当前活动"]) {
                ApplyActiveViewController *vc = [[ApplyActiveViewController alloc]init];
                
                VolunteerModel *model = self.activityArray[bt.tag - 2000];
                vc.applyActiveID = model.activeid;
                vc.applyTitle = model.activename;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else if ([self.activityStr isEqualToString:@"志愿教师招募"]){
                ApplyActiveViewController *vc = [[ApplyActiveViewController alloc]init];
                
                VolunteerModel *model = self.activityArray[bt.tag - 2000];
                vc.applyActiveID = model.activeid;
                vc.applyTitle = model.activename;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }

        }else{
            [SVProgressHUD showInfoWithStatus:@"您还不是志愿者老师"];
            return ;
        
        }
        
        
    }];

    

}
-(void)Submission{
    
    if (self.xf.Loginid == NULL) {
        [SVProgressHUD showInfoWithStatus:@"请先登录"];
        return;
    }
    BookwritingController *vc = [[BookwritingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)gotobook{


}
-(void)gototeacher{


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
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
//    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}
@end
