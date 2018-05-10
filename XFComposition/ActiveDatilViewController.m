//
//  ActiveDatilViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ActiveDatilViewController.h"
#import "ActiveDatilCell.h"
#import "ActivityDetailRequst.h"
#import "ActiveDatilFristModel.h"
#import "ActiveDatilSecondModel.h"
#import "ActiveDatilThridModel.h"
#import "ActiveHeadView.h"
#import "ActiveDatilFristModel.h"
#import "ActiveotherCell.h"
@interface ActiveDatilViewController ()<UITableViewDelegate,UITableViewDataSource,ActiveDatilCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@property (nonatomic,strong)NSMutableArray *FristArray;
@property (nonatomic,strong)NSMutableArray *SecondArray;
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)ActiveHeadView *headView;
@property (nonatomic,strong)ActiveDatilFristModel *Fmodel;
@end

@implementation ActiveDatilViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(ActiveHeadView *)headView{
    if (!_headView) {
        _headView = [[ActiveHeadView alloc]init];
        
    }
    return _headView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        _tableView.style = UITableViewStyleGrouped;
        [_tableView registerClass:[ActiveDatilCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[ActiveotherCell class] forCellReuseIdentifier:@"othercell"];
    }
    return _tableView;
}
-(NSMutableArray *)FristArray{
    if (!_FristArray) {
        _FristArray = [NSMutableArray array];
    }
    return _FristArray;
}
-(NSMutableArray *)SecondArray{
    if (!_SecondArray) {
        _SecondArray = [NSMutableArray array];
    }
    return _SecondArray;
}
-(NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}
-(NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}
-(ActiveDatilFristModel *)Fmodel{
    if (!_Fmodel) {
        _Fmodel = [[ActiveDatilFristModel alloc]init];
    }
    return _Fmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
    [self ActivityDetail];
    self.headView.frame = CGRectMake(0, 0, WidthFrame, self.headView.height);
    self.tableView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.headView, 0).widthIs(WidthFrame).heightIs(HeightFrame-self.headView.size.height-64);

}
-(void)ActivityDetail{
    ActivityDetailRequst *requst = [[ActivityDetailRequst alloc]init];
    [requst ActivityDetailwithActiveID:self.strid :^(NSDictionary *json) {
        
        self.Fmodel = [ActiveDatilFristModel loadWithJSOn:json[@"ret_data"]];
        [self.FristArray removeAllObjects];
        [self.selectedArray removeAllObjects];
        [self.allArray removeAllObjects];
        for (NSDictionary *dic in self.Fmodel.activeNav) {
            ActiveDatilSecondModel *model2 = [ActiveDatilSecondModel loadWithJSOn:dic];
            [self.FristArray addObject:model2];
            [self.selectedArray addObject:@"0"];
            
            for (NSDictionary *dic2 in model2.childfirst) {
                ActiveDatilThridModel *model3 = [ActiveDatilThridModel loadWithJSOn:dic2];
                [self.SecondArray addObject:model3];
            }
            [self.allArray addObject:self.SecondArray];
        }
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.Fmodel.activePic];
        [self.headView.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        self.headView.label4.text = [NSString stringWithFormat:@"初次审核通过：0 作品限制：0"];
        self.headView.label1.text = self.Fmodel.activeName;
        self.headView.label2.text = [NSString stringWithFormat:@"活动时间：%@~%@",[self.Fmodel.activeStartTime substringToIndex:10],[self.Fmodel.activeEndTime substringToIndex:10]];
        
        NSString * str1 = [self.Fmodel.activeInfo stringByRemovingPercentEncoding];
        
        //1.将字符串转化为标准HTML字符串
        str1 = [self htmlEntityDecode:str1];
        //2.将HTML字符串转换为attributeString
        NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
        self.headView.label3.attributedText = attributeStr;
//        NSString *str2 = [self htmlEntityDecode:[self.Fmodel.activeInfo stringByRemovingPercentEncoding]];
//        self.headView.label3.text = [NSString stringWithFormat:@"%@",str2];
        
        
        [self.tableView reloadData];
    }];
    
}
//我要投稿
-(void)click :(UIButton *)bt{
    
    
}
#pragma mark section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.Fmodel.activeNav.count>0) {
        return self.FristArray.count;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.Fmodel.activeNav.count>0) {
        ActiveDatilSecondModel *model2 = self.FristArray[section];
        if ([model2.isParent integerValue] == 0) {
            return 1;
        }
        if ([_selectedArray[section] isEqualToString:@"0"]) {
            ActiveDatilSecondModel *model2 = self.FristArray[section];
            return model2.childfirst.count;
        }
        return 0;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.Fmodel.activeNav.count>0) {
        ActiveDatilSecondModel *model2 = self.FristArray[indexPath.section];
        if ([model2.isParent integerValue] == 0) {
            return [self.tableView cellHeightForIndexPath:indexPath model:model2 keyPath:@"model2" cellClass:[ActiveDatilCell class] contentViewWidth:[self cellContentViewWith]];
        }
        ActiveDatilThridModel *model3 = self.allArray[indexPath.section][indexPath.row];
        return [self.tableView cellHeightForIndexPath:indexPath model:model3 keyPath:@"model" cellClass:[ActiveDatilCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.Fmodel.activeNav.count>0) {
        ActiveDatilSecondModel *model2 = self.FristArray[indexPath.section];
        if ([model2.isParent integerValue] == 0) {
            ActiveDatilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.delegate = self;
//            cell.tag = 2000+indexPath.section;
            cell.model2 = model2;
            return cell;
        }
        ActiveDatilCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        ActiveDatilThridModel *model3 = self.allArray[indexPath.section][indexPath.row];
        cell.delegate = self;
        
        cell.model = model3;
        return cell;
    }else{
        
        ActiveotherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"othercell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.Fmodel.activeNav.count>0) {
        ActiveDatilSecondModel *model2 = self.FristArray[section];
        if ([model2.isParent integerValue] == 0) {
            return 5;
        }
        return 50;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.Fmodel.activeNav.count>0) {
        ActiveDatilSecondModel *model2 = self.FristArray[section];
        if ([model2.isParent integerValue] == 0) {
            return nil;
        }
        //    ActiveDatilSecondModel *model2 = self.FristArray[section];
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
        sectionView.backgroundColor = [UIColor colorWithHexString:@"E7F2FA"];
        
        UIButton *sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        sectionButton.tag = 1000+section;
        if ([_selectedArray[section] isEqualToString:@"0"]) {
            [sectionButton setImage:[UIImage imageNamed:@"left-arrow_s"] forState:UIControlStateNormal];
        }else{
            [sectionButton setImage:[UIImage imageNamed:@"right-arrow-"] forState:UIControlStateNormal];
        }
        
    
        sectionButton.frame = sectionView.frame;
        sectionButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [sectionButton setTitle:model2.name forState:UIControlStateNormal];
        [sectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sectionButton setBackgroundColor:[UIColor colorWithHexString:@"DCDCDC"]];
        [sectionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, -100)];
        [sectionView addSubview:sectionButton];
        return sectionView;
    }
    return nil;
}
#pragma mark button点击方法
-(void)buttonAction:(UIButton *)button
{
    
    if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
//        [button setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
        //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
//        [self.tableView beginUpdates];
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
//        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationNone];
//         [self.tableView endUpdates];
        [self.tableView reloadData];
    }
    else
    {
        
        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
//        [self.tableView beginUpdates];
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
//        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationNone];
//        [self.tableView endUpdates];
        [self.tableView reloadData];
    }
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
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
