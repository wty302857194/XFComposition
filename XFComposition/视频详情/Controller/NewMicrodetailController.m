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

static NSString *firstCellID = @"NewMicoFristCell";
static NSString *secondCellID = @"NewMicoSecondCell";
static NSString *thirdCellID = @"NewMicoThirdCell";
static NSString *fourthCellID = @"NewMicoFourthCell";
static NSString *fiveCellID = @"NewMicoFiveCell";
static NSString *sixthCellID = @"NewMicoSixthCell";
static NSString *seventhCellID = @"NewMicoSeventhCell";

@interface NewMicrodetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VideoPlayer *playerView;


@end

@implementation NewMicrodetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频详情";
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    self.navigationItem.leftBarButtonItem=item;
    
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.tableView];
//    self.tableView.tableHeaderView = self.playerView;
    
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
        PlayerConfiguration *configuration = [[PlayerConfiguration alloc]init];
        configuration.shouldAutoPlay = YES;
        configuration.supportedDoubleTap = YES;
        configuration.shouldAutorotate = YES;
        configuration.repeatPlay = YES;
        configuration.statusBarHideState = StatusBarHideStateFollowControls;
        configuration.sourceUrl = [NSURL URLWithString:@"file:///Users/liyan/Downloads/%E9%BB%91%E8%B1%B9_bd.mp4"];
        configuration.videoGravity = VideoGravityResizeAspect;
        
        _playerView = [[VideoPlayer alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 180) configuration:configuration];
        
    }
    return _playerView;
}
#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NewMicoFristCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.data =
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
        
        cell.titleLab.text = @"四年级下册习作5 《植物研究报告》";
        cell.teacherLab.text = @"liyan";
        cell.teachGuideLab.text = @"k阿克苏男那是你撒南山南三阿森纳是你卡上看啊看卡刷卡时可撒开卡刷卡时卡卡卡上扣卡卡阿克苏男那是你撒南山南三阿森纳是你卡上看啊看卡刷卡时可撒开卡刷卡时卡卡卡上扣卡卡";
        cell.workLab.text = @"Jay：你住的 巷子里 我租了一间公寓 为了想与你不期而遇 高中三年 我为什么 为什么不好好读书 没考上跟你一样的大学 我找了份工作 离你宿舍很近 当我开始学会做蛋饼 才发现你 不吃早餐 喔 你又擦肩而过 你耳机听什么 能不能告诉我";
        return cell;
    } else if (indexPath.section == 1) {
        NewMicoSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text =@"1 四年级下册习作5 《植物研究报告》";
        cell.courceLab.text = @"课时 1";
        cell.dateLab.text = @"时长 【0:08:58】";
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
