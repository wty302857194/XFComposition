//
//  MicrodetailController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailController.h"
#import "MicrodetailFrsitCell.h"
#import "MicrodetailsecondheadCell.h"
#import "MicrodetailsecondCell.h"
#import "MicrodetailThridCell.h"

#import "Microdetailrequst.h"
#import "MicrodetailModel.h"
#import "MicroVideoModel.h"
#import "MicroWriteModel.h"


#import "AddcommentsView.h"
#import "ShowtextView.h"
#import "MicoClassRequst.h"//微课堂
#import "WriteListModel.h"
#import "MicroAddcommentRequst.h"//添加段落
#import "MicroPianduanRequst.h"//获取片段
#import "MicHBWriterequst.h"//锁定合并段落
#import "GetGJListRequst.h"//获取作文列表
#import "AddBlogRequst.h"//新建作文
#import "SaveGJRequst.h"//保存
#import "GetBlogContentInfoRequst.h"//片段内容
#import "GetBlogInfoRequst.h"//稿件内容
#import "GetCommentListRequst.h"//获取指定的微课评论信息
#import "GetCommentListModel.h"
#import "WeikePostCommentRequst.h"//添加评论
#import "CommWriteListRequst.h"//本课习作
#import "CommwritelistModel.h"
#import "GetDinaPinListRequst.h"//公益点评
#import "DianPingModel.h"
#import "WeikeGoodcolActionRequst.h"//收藏
#import "SynchroClassViewController.h"//更多课程



#import "MicPianduanmodel.h"
#import "NavimainViewController.h"
#import "LoginViewController.h"
#import "HomePaFristheadView.h"
#import "AddwritingView.h"
@interface MicrodetailController ()<UICollectionViewDelegate,UICollectionViewDataSource,MicroHeadDelegate,AddcommentDelegate,ShowViewDelegate,Microbaocundelegate,AddwritingViewDelegate,showtextDelegate,MicrodetailFrsitCellDelegate,UIScrollViewDelegate,HomePaFristheadViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *microArray;

@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)NSMutableArray *detailArray;
@property (nonatomic,strong)NSMutableArray *videoArray;//课程大纲
@property (nonatomic,strong)NSMutableArray *writeArray;//本课习作
@property (nonatomic,strong)NSMutableArray *modelArray;


@property (nonatomic ,copy)NSString *urlstr;

@property (nonatomic,strong)MicPianduanmodel *tijiaolaoshimodel;

@property (nonatomic,strong)NSString *panduan;
@property (nonatomic,strong)MicrodetailModel *detailmodel;

@property (nonatomic,strong)AddcommentsView *commentsView;//评论视图
@property (nonatomic,strong)AddwritingView *writingView;//
@property (nonatomic,strong)ShowtextView *showtextView;
@property (nonatomic,strong)UITableView *reshTableView;
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation MicrodetailController
-(NSMutableArray *)microArray{
    if (!_microArray) {
        _microArray = [[NSMutableArray alloc]init];
    }
    return _microArray;
}
-(NSMutableArray *)detailArray{
    if (!_detailArray) {
        _detailArray = [[NSMutableArray alloc]init];
    }
    return _detailArray;
}
-(NSMutableArray *)videoArray{
    if (!_videoArray) {
        _videoArray = [[NSMutableArray alloc]init];
    }
    return _videoArray;
}
-(NSMutableArray *)writeArray{
    if (!_writeArray) {
        _writeArray = [[NSMutableArray alloc]init];
    }
    return _writeArray;
}
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
-(MicrodetailModel *)detailmodel{
    if (!_detailmodel) {
        _detailmodel = [[MicrodetailModel alloc]init];
    }
    return _detailmodel;
}
-(AddcommentsView *)commentsView{
    if (!_commentsView) {
        _commentsView = [[AddcommentsView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _commentsView.delegate = self;
        [self.view addSubview:_commentsView];
    }
    return _commentsView;
}
-(AddwritingView *)writingView{
    if (!_writingView) {
        _writingView = [[AddwritingView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _writingView.delegate = self;
        [self.view addSubview:_writingView];
    }
    return _writingView;
}
-(ShowtextView *)showtextView{
    if (!_showtextView) {
        _showtextView = [[ShowtextView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _showtextView.delegate = self;
        [self.view addSubview:_showtextView];
    }
    return _showtextView;

}
-(UITableView *)reshTableView{
    if (!_reshTableView) {
        _reshTableView = [[UITableView alloc]init];
    }
    return _reshTableView;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
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
    self.navigationItem.title = @"视频详情";
    [self.view addSubview:self.collectionView];
    
    self.userId = self.xf.Loginid;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self Microdetailrequst0];
        [self GetMircroClass];
        
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
}
//获取正在进行的微课堂
-(void)GetMircroClass{
    MicoClassRequst *requst = [[MicoClassRequst alloc]init];
    [requst requstGetmicListWithchangId:@"2" Withmasterid:@"0" Withsubjectid:@"0" Withindex:@"1" Withpagesize:@"3" Withrecommed:@"-1" Withprostatic:@"-1" Withtimespan:@"0" :^(NSDictionary *json) {
        
        
        [self.microArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            WriteListModel *model = [WriteListModel loadWithJSOn:dic];
            [self.microArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];

}
//获取微课第一行信息
//课程大纲和本课习作
//这里可能需要判断是否登录
-(void)Microdetailrequst0{
    __weak typeof (self) weakSelf = self;
    self.panduan = @"0";
    Microdetailrequst *requst = [[Microdetailrequst alloc]init];
    [requst GetmicroInfoWithClassId:self.classId withUserId:@"0" :^(NSDictionary *json) {
        
        [weakSelf.detailArray removeAllObjects];
        weakSelf.detailmodel = [[MicrodetailModel alloc]init];
            weakSelf.detailmodel = [MicrodetailModel loadWithJSOn:json[@"ret_data"]];
        
            [weakSelf.videoArray removeAllObjects];
            [weakSelf.writeArray removeAllObjects];
        
            for (NSDictionary *dic in self.detailmodel.videoList) {
                MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
                [weakSelf.videoArray addObject:model];
            }
        weakSelf.modelArray = weakSelf.videoArray;
            for (NSDictionary *dic in weakSelf.detailmodel.writelist) {
                
                MicroWriteModel *model = [MicroWriteModel loadWithJSOn:dic];
                [weakSelf.writeArray addObject:model];
            }
       
//        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:1];
//        [self.collectionView reloadSections:indexset];
            [weakSelf.collectionView reloadData];
    }];

}


//获取写片段列表
-(void)MicroXiepianduanRequst{
    __weak typeof (self) weakSelf = self;
    self.panduan = @"1";
    MicroPianduanRequst *requst = [[MicroPianduanRequst alloc]init];
    [requst GetMricopianduanwithNoticeObject:self.classId withmodelid:@"5" withUserId:self.userId :@"1" :@"20" :^(NSDictionary *json) {
        [weakSelf.modelArray removeAllObjects];
        
        XFMicData *micData = [XFMicData mj_objectWithKeyValues:json];

        
        weakSelf.modelArray = micData.ret_data.pageInfo.x_Userblogs;
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
        [weakSelf.collectionView reloadSections:indexset];
//        NSIndexPath *index =  [NSIndexPath indexPathForRow:0 inSection:2];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            MicrodetailsecondCell *cell= [self.collectionView cellForItemAtIndexPath:index];
//            NSLog(@"--%f",cell.frame.size.height);
//            [cell.tableView reloadData];
            
//            [self .reshTableView reloadData];
//        });
        
    }];
}
//获取写作文列表
-(void)MicroXiezuowenRequst{
    __weak typeof (self) weakSelf = self;
    self.panduan = @"2";
    GetGJListRequst *requst = [[GetGJListRequst alloc]init];
    [requst GetGJListRequstWithuserId:self.userId withPageIndex:@"1" withPagesize:@"20" withTypeid:self.classId withModelid:@"5" :^(NSDictionary *json) {
        [weakSelf.modelArray removeAllObjects];
        XFMicData *micData = [XFMicData mj_objectWithKeyValues:json];
        weakSelf.modelArray = micData.ret_data.pageInfo.x_Userblogs;
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
        [weakSelf.collectionView reloadSections:indexset];
//        dispatch_async(dispatch_get_main_queue(), ^{
//        [self .reshTableView reloadData];
//        });
    }];
    
}
//课程交流
-(void)MicrokechengjiaoliuRequst{
    __weak typeof (self) weakSelf = self;
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.classId withmodelId:@"5" withPageIndex:@"1" withPageSize:@"10" :^(NSDictionary *json) {
        [weakSelf.modelArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [weakSelf.modelArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.panduan = @"3";
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
            [weakSelf.collectionView reloadSections:indexset];
            
        });
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.panduan = @"3";
//
//            [self .reshTableView reloadData];
//        });
        
        
    }];
    
}
//本课习作
-(void)MicCommWriteList{
    __weak typeof (self) weakSelf = self;
    self.panduan = @"4";
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:@"1" withpagesiz:@"4" withgradid:@"5" withtypeid:self.classId withishot:@"-1" withtuijian:@"-1"  withlabelid:@"0"  withkeword:@""  BlogStatic:@"1" :^(NSDictionary *json) {
        [weakSelf.modelArray removeAllObjects];
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
            [weakSelf.modelArray addObject:model];
            
        }
        
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
        [weakSelf.collectionView reloadSections:indexset];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self .reshTableView reloadData];
//        });
    }];
    
    
}
//公益点评
-(void)MicrogongyidianpingRequst{
    __weak typeof (self) weakSelf = self;
    GetDinaPinListRequst *requst = [[GetDinaPinListRequst alloc]init];
    [requst GetDinaPinListRequswithPageIndex:@"1" withPageSize:@"10" withclassId:self.classId withmodelId:@"5" withkeyWord:@"" :^(NSDictionary *json) {
        [weakSelf.modelArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [self.modelArray addObject:model];
        }
        weakSelf.panduan = @"5";
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
        [weakSelf.collectionView reloadSections:indexset];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self .reshTableView reloadData];
//        });
    }];
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame-64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MicrodetailFrsitCell class] forCellWithReuseIdentifier:@"cellfrsit"];
        [_collectionView registerClass:[MicrodetailsecondheadCell class] forCellWithReuseIdentifier:@"cellsecondhead"];
        [_collectionView registerClass:[MicrodetailsecondCell class] forCellWithReuseIdentifier:@"cellscecond"];
        [_collectionView registerClass:[MicrodetailThridCell class] forCellWithReuseIdentifier:@"cellthrid"];
        [_collectionView registerClass:[HomePaFristheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];//注册cell的headview
        _collectionView.showsVerticalScrollIndicator =NO;
        
    }
    return _collectionView;
    
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.detailArray == 0) {
            return 0;
        }
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section ==2){
        return 1;
    }else if (section ==3){
        return self.microArray.count;
    }
    return 0;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MicrodetailFrsitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellfrsit" forIndexPath:indexPath];
        cell.delegate = self;

        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",self.detailmodel.className];
        cell.teacherLabel.text = [NSString stringWithFormat:@"讲课老师：%@",self.detailmodel.classMaster];

        cell.sjLabel.text = [NSString stringWithFormat:@"课程时间：%@~%@",[self.detailmodel.classStartTime substringToIndex:9],[self.detailmodel.classEndTime substringToIndex:9]];
        cell.mobiaoLabel.text = [NSString stringWithFormat:@"讲课目标：%@",self.detailmodel.classTarget];
        cell.miaoshuLabel.text = [NSString stringWithFormat:@"课程描述：%@",self.detailmodel.classInfo];
        cell.biaoqianLabel.text = [NSString stringWithFormat:@"关键标签：%@",self.detailmodel.classKeyWord];
        cell.duixiangLabel.text = [NSString stringWithFormat:@"课程对象：%@",self.detailmodel.classObject];

        
        _urlstr = [NSString string];
        for (NSDictionary *dic in self.detailmodel.videoList) {
            MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
            _urlstr = model.MicroclassItemMp4Path;
        }
        
        cell.playView.urlString = _urlstr;
        
        return cell;
    }else if (indexPath.section == 1){
        
        MicrodetailsecondheadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellsecondhead" forIndexPath:indexPath];
        cell.delegate = self;
        
        self.btnArray = cell.tabBtnArray;
        return cell;
    
    }
    else if (indexPath.section == 2){
        MicrodetailsecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellscecond" forIndexPath:indexPath];
//        cell.dagangArray = [[NSMutableArray alloc]init];
//        self.reshTableView = cell.tableView;
        
        cell.IF = self.panduan;
        [cell.tableView reloadData];
        
        cell.dagangArray = self.modelArray;
        

        cell.delegate = self;
        cell.showViewdelegate = self;

        return cell;
    
    }else if (indexPath.section == 3){
        MicrodetailThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellthrid" forIndexPath:indexPath];
        WriteListModel *model = self.microArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.titleLabel.text = model.MicroclassInfoTitle;
        cell.liulanLabel.text = [NSString stringWithFormat:@"%@浏览",model.MicroclassInfoAttr];
        cell.canyuLabel.text =@"8674参与";
//        cell.canyuLabel.text = [NSString stringWithFormat:@"%@参与",model.MicroclassInfoAttr1];
        return cell;
        
    }
    return nil;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3){
        MicrodetailController *vc = [[MicrodetailController alloc]init];
        
            WriteListModel *model = self.microArray[indexPath.row];
            
            vc.classId = model.ID;
            [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, HeightFrame/3+200);
        
    }else if (indexPath.section == 1){
        
        return CGSizeMake(WidthFrame,40);
        
    }else if (indexPath.section == 2){
        
        return CGSizeMake(WidthFrame,130);
        
    }else if (indexPath.section == 3){
        
        return CGSizeMake(WidthFrame/3-15,HeightFrame/8+20+20);
    }
    return CGSizeZero;

        
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    if (section == 3) {
        return UIEdgeInsetsMake(2, 10, 2, 10);
    }
    else return UIEdgeInsetsMake(2, 0, 2, 0);
    
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return CGSizeMake(WidthFrame, 25);
    }else
        return CGSizeZero;
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        
        
        
        if (indexPath.section == 3){
            HomePaFristheadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            view.delegate = self;
    
            view.textLable.text = @"相关课程";
            return view;
        }
        return nil;
        
        
    }
    return nil;
    
}
//更多课程
-(void)getMore :(UIButton *)bt{
    
    SynchroClassViewController *synchroVc = [[SynchroClassViewController alloc]init];
    [self.navigationController pushViewController:synchroVc animated:NO];
}

-(void)srollView :(UIButton *)bt{
    
    for (UIButton *btn in self.btnArray){
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (bt.tag == 1000) {
                
                
                [self Microdetailrequst0];
                
                
            }else{
                //                XFUserInfo *xf = [XFUserInfo getUserInfo];
                //                if (xf.Loginid == NULL) {
                //                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
                //                    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //                        return ;
                //                    }]];
                //                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //                        LoginViewController *loginvc = [[LoginViewController alloc]init];
                //                        [self presentViewController:loginvc animated:YES completion:nil];
                //
                //                    }]];
                //                    [self presentViewController:alert animated:YES completion:nil];
                //                }
//                if (self.xf.Loginid == NULL) {
//                    [SVProgressHUD showInfoWithStatus:@"您还未登录"];
//                    
//                    
//                    
//                }else
                {
                    if (bt.tag ==1001) {
                        
                        
                        [self MicroXiepianduanRequst];//获取片段
                        
                        
                    }else if (bt.tag ==1002) {
                        
                        self.panduan = @"2";
                        [self MicroXiezuowenRequst];//获取作文
                        
                        
                    }else if (bt.tag ==1003) {
                        self.panduan = @"3";
                        [self MicrokechengjiaoliuRequst];//课程交流
                        
                        
                    }else if (bt.tag ==1004) {
                        self.panduan = @"4";
                        [self MicCommWriteList]; //本课习作
                    }else if (bt.tag ==1005) {
                        self.panduan = @"5";
                        [self MicrogongyidianpingRequst];
                        
                    }
                }
            }
            
            
        }else{
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
}


//弹出评论视图
-(void)addcomment{
    [self.commentsView showView];
}
//点击保存，新建段落
-(void)preservestage{
    __weak typeof (self) weakSelf = self;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.commentsView.textview.text];
    
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attributedString dataFromRange:NSMakeRange(0, attributedString.length)
                                    documentAttributes:tempDic
                                                 error:nil];
    MicroAddcommentRequst *requst = [[MicroAddcommentRequst alloc]init];
    [requst GetMricoAddpianduanrequsWithNoticeName:self.commentsView.titletextfield.text withNoticeObject:self.classId withNoticeContment:[[NSString alloc] initWithData:htmlData
                                                                                                                                                                encoding:NSUTF8StringEncoding] withNoticeId:@"0" withUserId:self.userId :^(NSDictionary *json) {
        
        
        [weakSelf.commentsView.titletextfield setText:nil];
        [weakSelf.commentsView.textview setText:nil];
        NSLog(@"liuleliule%@",json[@"ret_msg"]);
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            [weakSelf MicroXiepianduanRequst];//需要分类  通过panduan
        }
    }];
    
    
    [self.commentsView dismissView];

    
    
}
//编辑后保存
-(void)SaveDuanluo :(NSString *)noticeId{
    __weak typeof (self) weakSelf = self;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.showtextView.textView.text];
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attributedString dataFromRange:NSMakeRange(0, attributedString.length)
                         documentAttributes:tempDic
                                      error:nil];
    
    
    MicroAddcommentRequst *requst = [[MicroAddcommentRequst alloc]init];
    [requst GetMricoAddpianduanrequsWithNoticeName:self.showtextView.titletextfield.text withNoticeObject:self.classId withNoticeContment:[[NSString alloc] initWithData:htmlData
                                                                                                                                                                encoding:NSUTF8StringEncoding] withNoticeId:noticeId withUserId:self.userId :^(NSDictionary *json) {
        
        
        
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            if ([weakSelf.panduan isEqualToString:@"1"]){
                [weakSelf MicroXiepianduanRequst];//需要分类  通过panduan
            }else if ([self.panduan isEqualToString:@"2"]){
                
                [weakSelf MicroXiezuowenRequst];
            }
        }
    }];
    
    [self.showtextView dissMiss];
    
    
    
}
//合并段落
-(void)merge{
    

    
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要合并已经写好的片段吗，合并后片段将锁定，将不能编辑?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString *jihe = @"";
        for (int i = 0 ; i < _modelArray.count;i++){
              MicPianduanmodel *model = self.modelArray[i];
            jihe = [NSString stringWithFormat:@"%@%@,",jihe,model.ID];
        }
        NSString *cccc = [jihe substringToIndex:[jihe length] - 1];
        NSLog(@"jiheshishenme------------------------%@",cccc);
        MicHBWriterequst *requst = [[MicHBWriterequst alloc]init];
        [requst MicHBWriterequstWithclassId:self.classId ids:cccc withModelld:@"5" withUserID:self.userId :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                [weakSelf MicroXiepianduanRequst];//需要分类  通过panduan
            }else{
                [SVProgressHUD showErrorWithStatus:@"合并失败"];
            }

        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];


}
//点击弹出段落，可修改
-(void)showPiandian:(NSIndexPath *)index{
    __weak typeof (self) weakSelf = self;
    [self.showtextView showView];

    //这里要通过接口请求 内容数据;
    //通过model 的字段判断是否可以编辑
    if ([self.panduan isEqualToString:@"1"]) {
        MicPianduanmodel *model=self.modelArray[index.row];
        
        self.showtextView.titletextfield.text = model.BlogTitle;
        self.showtextView.timeLabel2.text = model.BlogAddTime;
        self.showtextView.typeId = model.ID;
        GetBlogContentInfoRequst *requst = [[GetBlogContentInfoRequst alloc]init];
        
        [requst GetBlogContentInfoRequstWithNoticeID:model.ID :^(NSDictionary *json) {
            
            
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                NSString *str1 = [self htmlEntityDecode:json[@"ret_data"]];
                NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
                weakSelf.showtextView.textView.attributedText = attributeStr;
                if ([model.BlogStatic isEqualToString:@"1"]) {
                    //不可编辑
//                    [self.showtextView showView];
                    weakSelf.showtextView.textView.editable = NO;
                    weakSelf.showtextView.baocunBt.hidden = YES;
                    weakSelf.showtextView.titletextfield.enabled = NO;
                    //            self.showtextView.textView.frame = CGRectMake(0, 70, WidthFrame, 170);
                }else if ([model.BlogStatic isEqualToString:@"0"]){
                    //可编辑
//                    [self.showtextView showView];
                    weakSelf.showtextView.textView.editable = YES;
                    weakSelf.showtextView.baocunBt.hidden = NO;
                    weakSelf.showtextView.titletextfield.enabled = YES;
                    //            self.showtextView.textView.frame = CGRectMake(0, 70, WidthFrame, 140);
                    
                }

            }
        }];

        
    }
    
}
//点击弹出作文，可修改
-(void)showzuowen:(NSIndexPath *)index{
    __weak typeof (self) weakSelf = self;
    [self.showtextView showView];
    if ([self.panduan isEqualToString:@"2"]) {

        MicPianduanmodel *model=self.modelArray[index.row];
        _tijiaolaoshimodel = model;
        self.showtextView.titletextfield.text = model.BlogTitle;
        self.showtextView.timeLabel2.text = model.BlogAddTime;
        self.showtextView.typeId = model.ID;
        GetBlogContentInfoRequst *requst = [[GetBlogContentInfoRequst alloc]init];
        [requst GetBlogContentInfoRequstWithNoticeID:model.ID :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
//                [self.showtextView showView];
                NSString *str1 = [self htmlEntityDecode:json[@"ret_data"]];
                NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
                weakSelf.showtextView.textView.attributedText = attributeStr;
                
                if ([model.BlogStatic isEqualToString:@"1"]) {
                    //不可编辑
                    weakSelf.showtextView.textView.editable = NO;
                    weakSelf.showtextView.baocunBt.hidden = YES;
                    weakSelf.showtextView.titletextfield.enabled = NO;
//                    [weakSelf.showtextView showView];
                    //            self.showtextView.textView.frame = CGRectMake(0, 70, WidthFrame, 170);
                }else if ([model.BlogStatic isEqualToString:@"0"]){
                    //可编辑
//                    [weakSelf.showtextView showView];
                    weakSelf.showtextView.textView.editable = YES;
                    weakSelf.showtextView.baocunBt.hidden = NO;
                    weakSelf.showtextView.titletextfield.enabled = YES;
//                    [weakSelf.showtextView showView];
                    //            self.showtextView.textView.frame = CGRectMake(0, 70, WidthFrame, 140);
                    
                }

            }
        }];
        

    }
}
//点击已经创建的作文，是否可以保存
-(void)hold :(NSString *)Id{
    NSLog(@"idiidididi %@",Id);
    if ([self.panduan isEqualToString:@"1"]) {
        //掉接口
        NSLog(@"保存");
        [self SaveDuanluo :Id];
        
    }else if ([self.panduan isEqualToString:@"2"]){
        
        NSLog(@"我日");
        [self SaveDuanluo:Id];
    }
    
}

//新建作文,弹出视图
-(void)Newbuild{
    [self.writingView showView];
    
    
}

//点击保存，新建作文
-(void)newWriting{
    __weak typeof (self) weakSelf = self;
    AddBlogRequst *requst = [[AddBlogRequst alloc]init];
    [requst AddBlogRequstWithNoticeName:self.writingView.titletextfield.text withNoticeObject:self.classId withNoticeContent:self.writingView.textview.text withNoticeID:@"0" withuserid:self.userId withactiveItemId:@"0" withposttype:@"0" :^(NSDictionary *json) {
        
        [weakSelf.writingView.titletextfield setText:nil];
        [weakSelf.writingView.textview setText:nil];
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            [weakSelf MicroXiezuowenRequst];//需要分类  通过panduan
        }
    }];
    

    [self.writingView dismissView];

}
//保存 ，无法编辑
-(void)SaveGJ{
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要保存吗，稿件保存后将不能编辑?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SaveGJRequst *requst = [[SaveGJRequst alloc]init];
        [requst SaveGJRequstWithclassId:self.classId withModelld:@"5" withUserID:self.userId ids:_tijiaolaoshimodel.ID :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                 [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                [weakSelf MicroXiezuowenRequst];//需要分类  通过panduan
            }else{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            }
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];

    
    
}
//提交老师
-(void)SubmittTeacher{
    
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要提交老师嘛?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SaveGJRequst *requst = [[SaveGJRequst alloc]init];
        [requst PostTeacherWithclassId:self.classId withModelld:@"5" withUserID:self.userId  ids:_tijiaolaoshimodel.ID :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                [weakSelf MicroXiezuowenRequst];//需要分类  通过panduan
                [SVProgressHUD showSuccessWithStatus:json[@"ret_data"]];
            }else{
                [SVProgressHUD showErrorWithStatus:json[@"ret_data"]];
            }
        }];
    }]];
     [self presentViewController:alert animated:YES completion:nil];
}
//添加评论
-(void)comment:(UITextView *)textView{
    __weak typeof (self) weakSelf = self;
    WeikePostCommentRequst *requst = [[WeikePostCommentRequst alloc]init];
    
    [requst WeikePostCommentRequstwithuserid:self.userId withmodelid:@"5" withclassid:self.classId withuserip:@"127.0.0.1" withCommentinfo:textView.text :^(NSDictionary *json) {
        NSLog(@"%@",json[@"ret_msg"]);
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            [textView setText:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加评论成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //刷新数据
                [weakSelf MicrokechengjiaoliuRequst];
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    }];
    

}

-(void)fenxiang:(NSIndexPath *)index{

//    WeikeGoodcolActionRequst *requst = [[WeikeGoodcolActionRequst alloc]init];
//    [requst WeikeGoodcolActionRequstwith:self.userId withweikeid:self.classId withtypeflag:@"good" :^(NSDictionary *json) {
//        if ([json[@"ret_code"] isEqualToString:@"0"]) {
//            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
//        }else{
//             [SVProgressHUD showErrorWithStatus:@"分享失败"];
//        }
//
//    }];
//    NSString *shareText = [NSString stringWithFormat:@"《%@》",self.detailmodel.className];
////    UIImage *shareImage = [UIImage imageNamed:@"shareImage.png"];
////    NSURL *shareUrl = [NSURL URLWithString:@"http://blog.csdn.net/flyingkuikui"];
//    NSArray *activityItemsArray = @[shareText];
//    
//    // 自定义的CustomActivity，继承自UIActivity
//    CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:@"wangsk" ActivityImage:[UIImage imageNamed:@"custom.png"] URL:[NSURL URLWithString:@"http://blog.csdn.net/flyingkuikui"] ActivityType:@"Custom"];
//    NSArray *activityArray = @[customActivity];
//    
//    // 2、初始化控制器，添加分享内容至控制器
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
//    activityVC.modalInPopover = YES;
//    // 3、设置回调
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        // ios8.0 之后用此方法回调
//        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
//            NSLog(@"activityType == %@",activityType);
//            if (completed == YES) {
//                NSLog(@"completed");
//            }else{
//                NSLog(@"cancel");
//            }
//        };
//        activityVC.completionWithItemsHandler = itemsBlock;
//    }else{
//        // ios8.0 之前用此方法回调
//        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
//            NSLog(@"activityType == %@",activityType);
//            if (completed == YES) {
//                NSLog(@"completed");
//            }else{
//                NSLog(@"cancel");
//            }
//        };
//        activityVC.completionHandler = handlerBlock;
//    }
//    // 4、调用控制器
//    [self presentViewController:activityVC animated:YES completion:nil];

    
    
    
     [SVProgressHUD showErrorWithStatus:@"该功能暂未开启"];
}
//收藏
-(void)shoucang{
//    NSLog(@"%@",self.userId);
//    NSLog(@"%@",self.classId);
    WeikeGoodcolActionRequst *requst = [[WeikeGoodcolActionRequst alloc]init];
    [requst WeikeGoodcolActionRequstwith:self.userId withweikeid:self.classId withtypeflag:@"col" :^(NSDictionary *json) {
        if ([json[@"ret_code"]  isEqualToString:@"0"]) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }else{
             [SVProgressHUD showErrorWithStatus:@"收藏失败"];
        }
        
    }];
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    string = [string stringByReplacingOccurrencesOfString:@"{}" withString:@""];
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}


-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSNotification *LoseResponse = [NSNotification notificationWithName:@"removeMV" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];
}

@end
