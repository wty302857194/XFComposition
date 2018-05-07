//
//  PerLeftViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PerLeftViewController.h"
#import "PerLeftFristCell.h"
#import "PerLeftSecondCell.h"
#import "PerCenterViewController1.h"

#import <CoreText/CoreText.h>
#import "SendMessageViewController.h"
#import "GetMessageListRequst.h"
#import "GetMessageListModel.h"
#import "GetMessageWaitNumRequst.h"
@interface PerLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSString * navStr;
    NSString * navStr2;
    
}
@property (nonatomic,strong) UITableView *tabelView;
@property (nonatomic,strong)NSArray *array1;
@property (nonatomic,strong)NSArray *array2;
@property (nonatomic,strong)NSArray *typeArray;
@property (nonatomic,strong)NSArray *flagArray;
@property (nonatomic,strong)NSArray *colorArray;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong) XFUserInfo *xf;
@property (nonatomic,strong)NSString *typeStr;
@property (nonatomic,strong)NSString *flagStr;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,assign)NSInteger msg;

@end

@implementation PerLeftViewController
- (UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc] initWithFrame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
        _tabelView.backgroundColor = [UIColor whiteColor];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        [_tabelView registerClass:[PerLeftFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tabelView registerClass:[PerLeftSecondCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _tabelView;
}
-(NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray array];
        _imageArray = @[@"icon_shoujiang",@"icon_faxin",@"icon_caogao",@"icon_laji",@"icon_yifa"];
    }
    return _imageArray;
}
-(NSArray *)array1{
    if (!_array1) {
        _array1 = [NSArray array];
        _array1 = @[@"收信箱",@"发信",@"草稿箱",@"垃圾箱",@"已发信息"];
    }
    return _array1;
}
-(NSArray *)array2{
    if (!_array2) {
        _array2 = [NSArray array];
        _array2 = @[@"全部消息",@"普通消息",@"班级消息",@"系统消息",@"学校通知"];
    }
    return _array2;
}
-(NSArray *)colorArray{
    if (!_colorArray) {
        _colorArray = [NSArray array];
        _colorArray = @[@"3690CE",@"7DCDF3",@"5CC6C8",@"E93E33",@"F5B450"];
    }
    return _colorArray;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}
-(NSArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [[NSArray alloc]init];
        _typeArray = @[@"0",@"1",@"2",@"3",@"4"];
        
    }
    return _typeArray;
}
-(NSArray *)flagArray{
    if (!_flagArray) {
        _flagArray = [[NSArray alloc]init];
        _flagArray = @[@"",@"",@"",@""];
    }
    return _flagArray;
}
//获取我的所有消息
-(void)GetMessagelist{
    __weak typeof (self) weakSelf = self;
    
    GetMessageListRequst *requst = [[GetMessageListRequst alloc]init];
    [requst GetMessageListRequstwithPageIndex:@"1" withPageSize:@"20" withtype:self.typeStr withflag:self.flagStr withuserid:self.xf.Loginid :^(NSDictionary *json) {
        [weakSelf.array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetMessageListModel *model = [[GetMessageListModel alloc] initWithDictionary:dic];
            [weakSelf.array addObject:model];
        }

    }];
    
}
//我的未读消息数目
-(void)GetMessageWait{
    __weak typeof (self) weakSelf = self;
    GetMessageWaitNumRequst *requst = [[GetMessageWaitNumRequst alloc]init];
    [requst GetMessageWaitNumRequstWithuserid:self.xf.Loginid :^(NSDictionary *json) {
        weakSelf.msg = [json[@"ret_data"] integerValue];
        [weakSelf.tabelView reloadData];
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabelView];
    self.xf = [XFUserInfo getUserInfo];
    self.typeStr = @"0";
    self.flagStr = @"1";
    navStr2 = @"全部消息";
    navStr = @"收信箱";
    [self GetMessagelist];
    [self GetMessageWait];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return 2;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PerLeftFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.label1.text = self.array1[indexPath.row];
        cell.imgView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        if (indexPath.row == 0) {
            cell.label2.hidden = NO;
            cell.label2.text = [NSString stringWithFormat:@"%ld",(long)self.msg];
        }else{
            cell.label2.hidden = YES;
        }
        return cell;
    }else if (indexPath.section == 1){
        PerLeftSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.lable.backgroundColor = [UIColor colorWithHexString:self.colorArray[indexPath.row]];
        cell.label1.text = self.array2[indexPath.row];
//        cell.label2.text = @"10";
        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, WidthFrame-20, 40)];
    label.text = @"【收信箱】消息分类";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];//加粗
    [view addSubview:label];
    return view;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.flagStr = @"1";
        }else if (indexPath.row == 2){
            self.flagStr = @"2";
        }else if (indexPath.row == 3){
            self.flagStr = @"3";
        }else if (indexPath.row == 4){
            self.flagStr = @"4";
        }else if (indexPath.row == 1){
            
            SendMessageViewController *vc = [[SendMessageViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        navStr = _array1[indexPath.row];
    }else if (indexPath.section == 1){
        self.typeStr = self.typeArray[indexPath.row];
        navStr2 = _array2 [indexPath.row];
    }
    if (indexPath.section == 0&&indexPath.row == 1) {
        return;
    }
    [self.drawer reloadCenterViewControllerUsingBlock:^{
        
        //执行点击事件，如果传值可以将plainViewController作成单例传值
        
        PerCenterViewController1 *plainVC = [PerCenterViewController1 defaultPlainViewController];
//        plainVC.messgeArray = self.array;
        NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(%@)",navStr,navStr2]];
        NSRange range = [[NSString stringWithFormat:@"%@(%@)",navStr,navStr2] rangeOfString:[NSString stringWithFormat:@"(%@)",navStr2]];
        
        [noteStr addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:12].fontName,
                                                                         [UIFont systemFontOfSize:12].pointSize,
                                                                         NULL))
                        range:range];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300 , 44)];
        UILabel * label = [[UILabel alloc]initWithFrame:view.frame];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.attributedText = noteStr;
        [view addSubview:label];
        view.frame = CGRectMake((kScreenWidth-300)/2, 20, 300, 44);
        
        //坐标系转换到titleview
        
        view.frame = [self.view.window convertRect:view.frame toView:self.navigationItem.titleView];
         plainVC.drawer.navigationItem.titleView = view;
         plainVC.flagStr = self.flagStr;
         plainVC.typeStr = self.typeStr;
        
        [plainVC.tableView.mj_header beginRefreshing];
        
    }];
}

@end
