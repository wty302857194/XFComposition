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
#import "NewMicoFristCell.h"
#import "MicrodetailModel.h"


#import "NewMicoSecondCell.h"
#import "NewMicoThirdCell.h"
#import "NewMicoFourthCell.h"
#import "NewMicoFiveCell.h"
#import "NewMicoSixthCell.h"
#import "NewMicoSeventhCell.h"

#import "Microdetailrequst.h"
#import "MicoClassRequst.h"
#import "MicrodetailModel.h"
#import "WriteListModel.h"
#import "MicroVideoModel.h"
#import "MicroWriteModel.h"

static NSString *firstCellID = @"NewMicoFristCell";
static NSString *secondCellID = @"NewMicoSecondCell";
static NSString *thirdCellID = @"NewMicoThirdCell";
static NSString *fourthCellID = @"NewMicoFourthCell";
static NSString *fiveCellID = @"NewMicoFiveCell";
static NSString *sixthCellID = @"NewMicoSixthCell";
static NSString *seventhCellID = @"NewMicoSeventhCell";

@interface NewMicrodetailController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *playBackImgView;
@property (nonatomic, strong) VideoPlayer *playerView;
@property (nonatomic, strong) PlayerConfiguration *configuration;


@property (nonatomic, assign) NSString *panduan;
@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) MicrodetailModel *detailmodel;


@end

@implementation NewMicrodetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频详情";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ty_jianTouLeft"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    self.navigationItem.leftBarButtonItem=item;
    
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.tableView];
    
    [self Microdetailrequst0];
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
//获取微课第一行信息
//课程大纲和本课习作
//这里可能需要判断是否登录
-(void)Microdetailrequst0{
    __weak typeof (self) weakSelf = self;
    self.panduan = @"0";
    Microdetailrequst *requst = [[Microdetailrequst alloc]init];
    [requst GetmicroInfoWithClassId:self.classId withUserId:@"0" :^(NSDictionary *json) {
        
        weakSelf.detailmodel = [MicrodetailModel loadWithJSOn:json[@"ret_data"]];
        
        
        NSDictionary *dic = weakSelf.detailmodel.videoList.firstObject;
        if (dic) {
            MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
            self.configuration.imageUrl = [NSString stringWithFormat:@"%@%@",HTurl,model.picpath];
            self.configuration.sourceUrl = [NSURL URLWithString:model.MicroclassItemMp4Path];
            [self.playerView setPlayerConfiguration:self.configuration];
        }
        
        [weakSelf.videoArray removeAllObjects];
        for (NSDictionary *dic in weakSelf.detailmodel.videoList) {
            MicroVideoModel *model = [MicroVideoModel loadWithJSOn:dic];
            [weakSelf.videoArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    }];
    
}

-(void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
    
    NSNotification *LoseResponse = [NSNotification notificationWithName:@"removeMV" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:LoseResponse];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerView.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.playerView.frame)) style:UITableViewStylePlain];
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
        _playerView = [[VideoPlayer alloc] initWithFrame:CGRectMake(0, iPhoneX ? 88 : 64, self.view.frame.size.width, 180)];
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

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NewMicoFristCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataModel = self.detailmodel;
        cell.clickBlock= ^(NSInteger index) {
            //TODO
            switch (index) {
                case 0://收藏
                    {
                    }
                    break;
                case 1://分享
                    {
                    }
                    break;
                default:
                    break;
            }
        };
        return cell;
    } else if (indexPath.section == 1) {
        NewMicoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.datas = self.videoArray;
        return cell;
    } else if (indexPath.section == 2) {
        NewMicoThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell resetFrame:10];
        return cell;
    } else if (indexPath.section == 3) {
        NewMicoFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell resetFrame:10];
        return cell;
    } else if (indexPath.section == 4) {
        NewMicoFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:fiveCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 5) {
        NewMicoSixthCell *cell = [tableView dequeueReusableCellWithIdentifier:sixthCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 6) {
        NewMicoSeventhCell *cell = [tableView dequeueReusableCellWithIdentifier:seventhCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

@end
