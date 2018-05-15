//
//  NewMicrodetailController.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicrodetailController.h"
#import "VideoPlayer.h"
#import "PlayerConfiguration.h"
#import "SynchroClassViewController.h"
#import "AlertWriteView.h"

#import "NewMicoFristCell.h"
#import "NewMicoSecondCell.h"
#import "NewMicoThirdCell.h"
#import "NewMicoFourthCell.h"
#import "NewMicoFiveCell.h"
#import "NewMicoSixthCell.h"
#import "NewMicoSeventhCell.h"

#import "Microdetailrequst.h"
#import "MicoClassRequst.h"
#import "GetGJListRequst.h"
#import "GetDinaPinListRequst.h"
#import "CommWriteListRequst.h"
#import "GetCommentListRequst.h"
#import "WeikePostCommentRequst.h"
#import "WeikeGoodcolActionRequst.h"
#import "AddBlogRequst.h"
#import "SaveGJRequst.h"
#import "GetBlogContentInfoRequst.h"
#import "MicrodetailModel.h"
#import "WriteListModel.h"
#import "MicroVideoModel.h"
#import "MicPianduanmodel.h"
#import "DianPingModel.h"
#import "CommwritelistModel.h"
#import "GetCommentListModel.h"



static NSString *firstCellID = @"NewMicoFristCell";
static NSString *secondCellID = @"NewMicoSecondCell";
static NSString *thirdCellID = @"NewMicoThirdCell";
static NSString *fourthCellID = @"NewMicoFourthCell";
static NSString *fiveCellID = @"NewMicoFiveCell";
static NSString *sixthCellID = @"NewMicoSixthCell";
static NSString *seventhCellID = @"NewMicoSeventhCell";

@interface NewMicrodetailController ()<UITableViewDelegate, UITableViewDataSource,AddwritingViewDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *playBackImgView;
@property (nonatomic, strong) VideoPlayer *playerView;
@property (nonatomic, strong) PlayerConfiguration *configuration;


@property (nonatomic, assign) NSString *panduan;
@property (nonatomic, strong) NSMutableArray *videoArray;// 课程大纲
@property (nonatomic, strong) NSMutableArray *articleArray;//写作文
@property (nonatomic, strong) NSMutableArray *microArray;//相关课程
@property (nonatomic, strong) NSMutableArray *commentArray;//公益点评
@property (nonatomic, strong) NSMutableArray *writeArray;//本课习作
@property (nonatomic, strong) NSMutableArray *discussArray; //课程交流
@property (nonatomic, strong) MicrodetailModel *detailmodel;

@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)XFUserInfo *xf;

@end

@implementation NewMicrodetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"视频详情";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ty_jianTouLeft"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    self.navigationItem.leftBarButtonItem=item;
    
    self.userId = self.xf.Loginid;
    
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.tableView];
    
    __weak typeof (self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getAllData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self getAllData];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)getAllData
{
    [self Microdetailrequst0];//视频详情
    [self MicroXiezuowenRequst];//写作列表
    [self MicrokechengjiaoliuRequst];//课程交流
    [self MicrogongyidianpingRequst];//本课习作
    [self MicrogongyidianpingRequst];//公益点评
    [self GetMircroClass];//相关课程
}

#pragma mark --接口
//获取微课第一行信息
//课程大纲和本课习作
//这里可能需要判断是否登录
-(void)Microdetailrequst0
{
    __weak typeof (self) weakSelf = self;
    Microdetailrequst *requst = [[Microdetailrequst alloc]init];
    [requst GetmicroInfoWithClassId:self.classId withUserId:self.userId :^(NSDictionary *json) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.detailmodel = [MicrodetailModel loadWithJSOn:json[@"ret_data"]];
        
        
        NSDictionary *dic = weakSelf.detailmodel.videoList.firstObject;
        if (dic) {
            MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
            weakSelf.configuration.imageUrl = [NSString stringWithFormat:@"%@%@",HTurl,model.picpath];
            weakSelf.configuration.sourceUrl = [NSURL URLWithString:model.MicroclassItemMp4Path];
            
//            self.configuration.sourceUrl = [NSURL URLWithString:@"http://www.crowncake.cn:18080/wav/no.9.mp4"] ;
            weakSelf.configuration.title = model.title;
            [weakSelf.playerView setPlayerConfiguration:self.configuration];
        }
        
        [weakSelf.videoArray removeAllObjects];
        for (NSDictionary *dic in weakSelf.detailmodel.videoList) {
            MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
            [weakSelf.videoArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    }];
    
}

//获取写作文列表
-(void)MicroXiezuowenRequst{
    __weak typeof (self) weakSelf = self;
    GetGJListRequst *requst = [[GetGJListRequst alloc]init];
    [requst GetGJListRequstWithuserId:self.userId withPageIndex:@"1" withPagesize:@"20" withTypeid:self.classId withModelid:@"5" :^(NSDictionary *json) {
        [weakSelf.articleArray removeAllObjects];
        XFMicData *micData = [XFMicData mj_objectWithKeyValues:json];
        weakSelf.articleArray = micData.ret_data.pageInfo.x_Userblogs;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:2];
            [weakSelf.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
}
//新建作文
-(void)newWriting:(NSString *)title content:(NSString *)content flag:(NSString *)flg{
    __weak typeof (self) weakSelf = self;
    AddBlogRequst *requst = [[AddBlogRequst alloc]init];
    [requst AddBlogRequstWithNoticeName:title withNoticeObject:self.classId withNoticeContent:content withNoticeID:flg withuserid:self.userId withactiveItemId:@"0" withposttype:@"0" :^(NSDictionary *json) {
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            [weakSelf MicroXiezuowenRequst];
        }
    }];
    
}

//保存 ，无法编辑
-(void)SaveGJ:(NSString *)ids
{
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要保存吗，稿件保存后将不能编辑?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SaveGJRequst *requst = [[SaveGJRequst alloc]init];
        [requst SaveGJRequstWithclassId:self.classId withModelld:@"5" withUserID:self.userId ids:ids :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                [MBProgressHUD showSuccess:@"保存成功"];
                [weakSelf MicroXiezuowenRequst];
            }else{
                [MBProgressHUD showError:@"保存失败"];
            }
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    

    
}
//提交老师
-(void)SubmittTeacher:(NSString *)ids
{
    
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要提交老师嘛?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        SaveGJRequst *requst = [[SaveGJRequst alloc]init];
        [requst PostTeacherWithclassId:self.classId withModelld:@"5" withUserID:self.userId  ids:ids :^(NSDictionary *json) {
            if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
                [weakSelf MicroXiezuowenRequst];
                [MBProgressHUD showSuccess:json[@"ret_data"]];
            }else{
                [MBProgressHUD showError:json[@"ret_data"]];
            }
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//点击弹出作文，可修改
-(void)showzuowen:(MicPianduanmodel *)model{
    
    __weak typeof (self) weakSelf = self;
    GetBlogContentInfoRequst *requst = [[GetBlogContentInfoRequst alloc]init];
    [requst GetBlogContentInfoRequstWithNoticeID:model.ID :^(NSDictionary *json) {
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            NSString *str1 = [self htmlEntityDecode:json[@"ret_data"]];
            NSAttributedString * attributeStr = [weakSelf attributedStringWithHTMLString:str1];
            NSString *string = [attributeStr string];
            AlertWriteView *alertView = [[AlertWriteView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            alertView.delegate = weakSelf;
            [alertView showViewWithModel:model content:string flag:@"1"];
            
        }
    }];
    
}
//添加评论
-(void)comment:(UITextView *)textView{
    __weak typeof (self) weakSelf = self;
    WeikePostCommentRequst *requst = [[WeikePostCommentRequst alloc]init];
    
    [requst WeikePostCommentRequstwithuserid:self.userId withmodelid:@"5" withclassid:self.classId withuserip:@"127.0.0.1" withCommentinfo:textView.text :^(NSDictionary *json) {
        NSLog(@"%@",json[@"ret_msg"]);
        if ([json[@"ret_msg"] isEqualToString:@"成功"]) {
            [textView setText:nil];
            [MBProgressHUD showSuccess:@"添加评论成功"];
            //刷新数据
            [weakSelf MicrokechengjiaoliuRequst];
            
        } else {
            [MBProgressHUD showError:json[@"ret_data"]];
        }
    }];
    
    
}
//课程交流
-(void)MicrokechengjiaoliuRequst{
    __weak typeof (self) weakSelf = self;
    GetCommentListRequst *requst = [[GetCommentListRequst alloc]init];
    [requst GetCommentListRequstWithclassId:self.classId withmodelId:@"5" withPageIndex:@"1" withPageSize:@"10" :^(NSDictionary *json) {
        [weakSelf.discussArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetCommentListModel *model = [GetCommentListModel loadWithJSOn:dic];
            [weakSelf.discussArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:3];
            [weakSelf.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
            
        });        
    }];
    
}
//本课习作
-(void)MicCommWriteList{
    __weak typeof (self) weakSelf = self;
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:[NSNumber numberWithInteger:1] withpagesiz:@"4" withgradid:@"5" withtypeid:self.classId withishot:@"-1" withtuijian:@"-1"  withlabelid:@"0"  withkeword:@""  BlogStatic:@"1" :^(NSDictionary *json) {
        [weakSelf.writeArray removeAllObjects];
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
            [weakSelf.writeArray addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:4];
            [weakSelf.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
    
    
}
//公益点评
-(void)MicrogongyidianpingRequst{
    __weak typeof (self) weakSelf = self;
    GetDinaPinListRequst *requst = [[GetDinaPinListRequst alloc]init];
    [requst GetDinaPinListRequswithPageIndex:@"1" withPageSize:@"10" withclassId:self.classId withmodelId:@"5" withkeyWord:@"" :^(NSDictionary *json) {
        [weakSelf.commentArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            DianPingModel *model = [DianPingModel loadWithJSOn:dic];
            [weakSelf.commentArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:5];
            [weakSelf.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
        });
    }];
    
}
//获取正在进行的微课堂
-(void)GetMircroClass{
    __weak typeof (self) weakSelf = self;
    MicoClassRequst *requst = [[MicoClassRequst alloc]init];
    [requst requstGetmicListWithchangId:@"2" Withmasterid:@"0" Withsubjectid:@"0" Withindex:@"1" Withpagesize:@"3" Withrecommed:@"-1" Withprostatic:@"-1" Withtimespan:@"0" :^(NSDictionary *json) {
        
        
        [weakSelf.microArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            WriteListModel *model = [WriteListModel loadWithJSOn:dic];
            [weakSelf.microArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:6];
            [weakSelf.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
        });
        
    }];
    
}
//收藏
-(void)shoucang{
   
    WeikeGoodcolActionRequst *requst = [[WeikeGoodcolActionRequst alloc]init];
    [requst WeikeGoodcolActionRequstwith:@"" withweikeid:self.classId withtypeflag:@"col" :^(NSDictionary *json) {
        if ([json[@"ret_code"]  isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:@"收藏成功"];
        }else{
            [MBProgressHUD showError:@"收藏失败"];
        }
        
    }];
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof (self) weakSelf = self;
    if (indexPath.section == 0) {
        // 视频详情
        NewMicoFristCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataModel = self.detailmodel;
        cell.clickBlock= ^(NSInteger index) {
            
            if (index == 0) {
                //收藏
                [weakSelf shoucang];
            } else if (index == 1) {
                //TODO : 分享
                
            }
            
        };
        return cell;
    } else if (indexPath.section == 1) {
        // 课程大纲
        NewMicoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.videoArray;
        
        return cell;
    } else if (indexPath.section == 2) {
        // 写作文
        NewMicoThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.articleArray;
        cell.didSelectRowBlock = ^(MicPianduanmodel *model) {
            [weakSelf showzuowen:model];
            
        };
        cell.clickBlock = ^(NSArray<MicPianduanmodel *> *array, ClickType type) {
            
            if (type == ClickTypeAdd) {//新建作文
                AlertWriteView *alertView = [[AlertWriteView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
                alertView.delegate = weakSelf;
                [alertView showViewWithModel:nil content:nil flag:@"0"];

            } else if (type == ClickTypeSave) {//保存
                NSMutableArray *ary = [NSMutableArray array];
                for (MicPianduanmodel *model in array) {
                    [ary addObject:model.ID];
                }
                NSString *ids = [ary componentsJoinedByString:@","];
                [weakSelf SaveGJ:ids];
                
            } else if (type == ClickTypeSubmit) {//提交
                NSMutableArray *ary = [NSMutableArray array];
                for (MicPianduanmodel *model in array) {
                    [ary addObject:model.ID];
                }
                NSString *ids = [ary componentsJoinedByString:@","];
                [weakSelf SubmittTeacher:ids];
            }
            
        };
        return cell;
    } else if (indexPath.section == 3) {
        // 课程交流
        NewMicoFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.discussArray;
        cell.submitCommentBlock = ^(UITextView *textView) {
            [weakSelf comment:textView];
        };
        
        return cell;
    } else if (indexPath.section == 4) {
        // 本课习作
        NewMicoFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:fiveCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.writeArray;
        return cell;
    } else if (indexPath.section == 5) {
        // 公益点评
        NewMicoSixthCell *cell = [tableView dequeueReusableCellWithIdentifier:sixthCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.commentArray;
        
        return cell;
    } else if (indexPath.section == 6) {
        // 相关课程
        NewMicoSeventhCell *cell = [tableView dequeueReusableCellWithIdentifier:seventhCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.microArray;
        cell.showMoreBlock = ^() {
            [weakSelf goMore];
        };
        cell.showDetailBlock = ^ (WriteListModel *model) {
            NewMicrodetailController *vc = [[NewMicrodetailController alloc]init];
            vc.classId = model.ID;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


#pragma mark --

- (void)goMore
{
    SynchroClassViewController *synchroVc = [[SynchroClassViewController alloc]init];
    [self.navigationController pushViewController:synchroVc animated:NO];
}
-(void)onBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSNotification *LoseResponse = [NSNotification notificationWithName:@"removeMV" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];
}

#pragma mark -- 懒加载
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (MicrodetailModel *)detailmodel
{
    if (!_detailmodel) {
        _detailmodel = [[MicrodetailModel alloc] init];
    }
    return _detailmodel;
}

- (NSMutableArray *)videoArray
{
    if (!_videoArray) {
        _videoArray = [NSMutableArray array];
    }
    return _videoArray;
}

- (NSMutableArray *)articleArray
{
    if (!_articleArray) {
        _articleArray = [NSMutableArray array];
    }
    return _articleArray;
}

- (NSMutableArray *)microArray
{
    if (!_microArray) {
        _microArray = [NSMutableArray array];
    }
    return _microArray;
}

- (NSMutableArray *)commentArray
{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (NSMutableArray *)writeArray
{
    if (!_writeArray) {
        _writeArray = [NSMutableArray array];
    }
    return _writeArray;
}

- (NSMutableArray *)discussArray
{
    if (!_discussArray) {
        _discussArray = [NSMutableArray array];
    }
    return _discussArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_playerView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(_playerView.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoFristCell" bundle:nil] forCellReuseIdentifier:firstCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoSecondCell" bundle:nil] forCellReuseIdentifier:secondCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoThirdCell" bundle:nil] forCellReuseIdentifier:thirdCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoFourthCell" bundle:nil] forCellReuseIdentifier:fourthCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoFiveCell" bundle:nil] forCellReuseIdentifier:fiveCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoSixthCell" bundle:nil] forCellReuseIdentifier:sixthCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"NewMicoSeventhCell" bundle:nil] forCellReuseIdentifier:seventhCellID];
        
    }
    return _tableView;
}

- (UIView *)playerView
{
    if (!_playerView) {
        _playerView = [[VideoPlayer alloc] initWithFrame:CGRectMake(0, iPhoneX ? 88 : 64, kScreenWidth, 180)];
    }
    return _playerView;
}

- (PlayerConfiguration *)configuration
{
    if (!_configuration) {
        _configuration = [[PlayerConfiguration alloc]init];
        _configuration.shouldAutoPlay = NO;
        _configuration.supportedDoubleTap = YES;
        _configuration.shouldAutorotate = YES;
        _configuration.repeatPlay = NO;
        _configuration.videoGravity = VideoGravityResizeAspect;
    }
    return _configuration;
}

#pragma mark --
- (void)addWriting:(NSString *)title content:(NSString *)content flag:(NSString *)flg
{
    
    [self newWriting:title content:content flag:flg];
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


-(void)dealloc
{
    [self.playerView _deallocPlayer];
    [self.playerView removeFromSuperview];
}
@end
