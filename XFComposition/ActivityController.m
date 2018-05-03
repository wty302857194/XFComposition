//
//  ActivityController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActivityController.h"
#import "VolunteerActiviCell.h"
#import "VolunteerModel.h"
#import "VolunteerRequst.h"

#import "RecruiteacherController.h"
#import "SubmissionController.h"
#import "ApplyViewController.h"
#import "BookwritingController.h"
@interface ActivityController ()<UICollectionViewDelegate,UICollectionViewDataSource,VolunterrApplyteacherDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)NSMutableArray *ActivityArray;

@end

@implementation ActivityController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        [_collectionView registerClass:[VolunteerActiviCell class] forCellWithReuseIdentifier:@"activityCell"];
    }
    return _collectionView;
}
-(NSMutableArray *)ActivityArray{
    if (!_ActivityArray) {
        _ActivityArray = [[NSMutableArray alloc]init];
    }
    return _ActivityArray;
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
    self.navigationItem.title = self.titleStr;
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:@"backArrowMask.png"];
    
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"left-arrow_s"];
    self.page = 1;
    [self.view addSubview:self.collectionView];
    NSString *type;
    if ([self.titleStr isEqualToString:@"当前活动"]) {
        type = @"2";
    }else if ([self.titleStr isEqualToString:@"志愿教师招募"]){
        type = @"2";
        
    }else if ([self.titleStr isEqualToString:@"学生投稿活动"]){
        type = @"0";
        
    }

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetActivityList:type];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
//        [self requstMore];
        [self requstMore:type];
        [self.collectionView.mj_footer endRefreshing];
    }];
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)GetActivityList :(NSString*)type{
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    [requset GetVolunteerRequstWithpagesize :1 :@"10" WithAcitivieTypeID:type :^(NSDictionary *josn) {
        //        NSLog(@"%@",josn);
        [weakSelf.ActivityArray removeAllObjects];
        for (NSDictionary *dic in josn[@"ret_data"][@"pageInfo"]) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
            [weakSelf.ActivityArray addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
    
}
-(void)requstMore :(NSString *)type{
    __weak typeof (self) weakSelf = self;
    self.page+=1;
    VolunteerRequst *requset = [[VolunteerRequst alloc]init];
    
    [requset GetVolunteerRequstWithpagesize :self.page :@"10" WithAcitivieTypeID:type :^(NSDictionary *josn) {
        
        for (NSDictionary *dic in josn[@"ret_data"][@"pageInfo"]) {
            VolunteerModel *model = [VolunteerModel loadWithJSOn:dic];
            [weakSelf.ActivityArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
        });
    }];
    
}

#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.ActivityArray.count;
}
#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VolunteerActiviCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"activityCell" forIndexPath:indexPath];
    cell.delegate = self;
    VolunteerModel *model = self.ActivityArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.activepic];
    
    cell.timeLabel.text = [NSString stringWithFormat:@"活动时间: %@~%@",[model.activestarttime substringToIndex:10],[model.activeendtime substringToIndex:10]];
    //            http://xf.vqune.com/LocalFiles/ActiveWriteImg/1501051362407.png
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date2 = [dateFormatter dateFromString:model.activeendtime];
    //----------将nsdate按formatter格式转成nsstring
    
    
    
    
    if ([model.activetype isEqualToString:@"2"]) {
        cell.tougaobt.hidden = YES;
        cell.teacherbt.hidden = NO;
        cell.workbt.hidden = NO;
        if ([self compareOneDay:date withAnotherDay:date2] == 1 ) {
            cell.workbt.backgroundColor = [UIColor lightGrayColor];
            [cell.workbt setTitle:@"已经结束" forState:UIControlStateNormal];
            [cell.workbt setEnabled:NO];
        }else{
            cell.workbt.backgroundColor = [UIColor colorWithHexString:@"2791cf"];
            [cell.workbt setTitle:@"申请工作" forState:UIControlStateNormal];
            [cell.workbt setEnabled:YES];
            
        }
    }else {
        cell.tougaobt.hidden = NO;
        cell.teacherbt.hidden = YES;
        cell.workbt.hidden = YES;
        if ([self compareOneDay:date withAnotherDay:date2] == 1 ) {
            cell.tougaobt.backgroundColor = [UIColor lightGrayColor];
            [cell.tougaobt setTitle:@"已经结束" forState:UIControlStateNormal];
            [cell.tougaobt setEnabled:NO];
        }else{
            cell.tougaobt.backgroundColor = [UIColor colorWithHexString:@"2791cf"];
            [cell.tougaobt setTitle:@"开始投稿" forState:UIControlStateNormal];
            [cell.tougaobt setEnabled:YES];
        
        }
        
    }
    
    
    cell.detailBt.tag = 1000+indexPath.row;
    cell.titleLabel.text = model.activename;
    
    NSString * str1 = [model.activeinfo stringByRemovingPercentEncoding];
    
    //1.将字符串转化为标准HTML字符串
    str1 = [self htmlEntityDecode:str1];
    //2.将HTML字符串转换为attributeString
//    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    
    //3.使用label加载html字符串
//    cell.textView.attributedText = attributeStr;
    
    NSAttributedString *att = [[NSAttributedString alloc] initWithData:[[str1 stringByRemovingPercentEncoding] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    cell.textView.attributedText = att;//html转富文本
    
    
    return cell;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthFrame, 130);
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
    
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)gotodetail :(UIButton *)btn{
    //获取活动的type
    
    if ([self.titleStr isEqualToString:@"学生投稿活动"]) {
        
        SubmissionController *vc = [[SubmissionController alloc]init];
        VolunteerModel *model = self.ActivityArray[btn.tag-1000];
        vc.SubActiveID = model.activeid;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        RecruiteacherController *vc = [[RecruiteacherController alloc]init];
        VolunteerModel *model = self.ActivityArray[btn.tag-1000];
        vc.RecruitActiveID = model.activeid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
-(void)Applyteacher{
    ApplyViewController *vc = [[ApplyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)Applywork{

}
-(void)Submission{
    BookwritingController *vc = [[BookwritingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

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
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
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
