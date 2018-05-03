//
//  canyuViewController.m
//  XFComposition
//
//  Created by longrise on 2018/4/11.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "canyuViewController.h"

#import "DanxuanCell.h"
#import "DuoXuanCell.h"
#import "PanduanCell.h"
#import "TiankongCell.h"
#import "WendaCell.h"
#import "GetActivePageViewRequst.h"
#import "GetActivePageViewModel.h"

#import "GetActiveTestModel.h"
#import "GetActivePageModel.h"
#import "GetPageSubjectRequst.h"
@interface canyuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *Array1;
@property (nonatomic,strong)NSMutableArray *Array2;
@property (nonatomic,strong)NSMutableArray *Array3;
@property (nonatomic,strong)NSMutableArray *Array4;
@property (nonatomic,strong)NSMutableArray *Array5;
@property (nonatomic,strong)NSMutableArray *tixingArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSMutableArray *testArray;
@end

@implementation canyuViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self leftBarButton];
}

-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DanxuanCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[DuoXuanCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[PanduanCell class] forCellReuseIdentifier:@"cell3"];
        [_tableView registerClass:[TiankongCell class] forCellReuseIdentifier:@"cell4"];
        [_tableView registerClass:[WendaCell class] forCellReuseIdentifier:@"cell5"];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, 30)];
        
        UIButton *suer = [UIButton buttonWithType:UIButtonTypeSystem];
        [suer setTitle:@"提交测试" forState:UIControlStateNormal];
        suer.frame = CGRectMake(0, 0, WidthFrame, 30);
        [view addSubview:suer];
        [suer addTarget:self action:@selector(suer) forControlEvents:UIControlEventTouchUpInside];
        _tableView.tableFooterView = view;
 
        
    }
    return _tableView;
}
-(NSMutableArray *)Array1{
    if (!_Array1) {
        _Array1 = [[NSMutableArray alloc]init];
    }
    return _Array1;
}
-(NSMutableArray *)Array2{
    if (!_Array2) {
        _Array2 = [[NSMutableArray alloc]init];
    }
    return _Array2;
}
-(NSMutableArray *)Array3{
    if (!_Array3) {
        _Array3 = [[NSMutableArray alloc]init];
    }
    return _Array3;
}
-(NSMutableArray *)Array4{
    if (!_Array4) {
        _Array4 = [[NSMutableArray alloc]init];
    }
    return _Array4;
}
-(NSMutableArray *)Array5{
    if (!_Array5) {
        _Array5 = [[NSMutableArray alloc]init];
    }
    return _Array5;
}
-(NSMutableArray *)tixingArray{
    
    if (!_tixingArray) {
        _tixingArray = [[NSMutableArray alloc]init];
    }
    return _tixingArray;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        
    }
    return _titleArray;
}
-(NSMutableArray *)testArray{
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]init];
    }
    return _testArray;
}
-(void)GetActivePageView{
    __weak typeof (self) weakSelf = self;
    GetActivePageViewRequst *requst = [[GetActivePageViewRequst alloc]init];
    [requst GetActivePageViewRequstwithSubjectid:self.ids :^(NSDictionary *json) {
        
        [weakSelf makeit:json];
        
        [weakSelf.tableView reloadData];
    }];
    
}
-(void)liulan :(NSDictionary *)json{
    
    
}

-(void)makeit :(NSDictionary *)json{
    
    [self.Array1 removeAllObjects];
    [self.Array2 removeAllObjects];
    [self.Array3 removeAllObjects];
    [self.Array4 removeAllObjects];
    [self.Array5 removeAllObjects];
    [self.tixingArray removeAllObjects];
    
    
    for (NSDictionary *dic in json[@"ret_data"][@"SinCSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array1 addObject:model];
    }
    
    
    for (NSDictionary *dic in json[@"ret_data"][@"MuiCSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array2 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"PDSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array3 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"TKSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array4 addObject:model];
    }
    for (NSDictionary *dic in json[@"ret_data"][@"WDSb"]) {
        GetActivePageViewModel *model = [GetActivePageViewModel loadWithJSOn:dic];
        [self.Array5 addObject:model];
    }
    if (self.Array1.count>0) {
        [self.tixingArray addObject:self.Array1];
        [self.titleArray addObject:@"单选题"];
        //             _titleArray = @[@"单选题",@"多选题",@"判断题",@"问答题",@"填空题"];
    }
    if (self.Array2.count>0) {
        [self.tixingArray addObject:self.Array2];
        [self.titleArray addObject:@"多选题"];
    }
    if (self.Array3.count>0) {
        [self.tixingArray addObject:self.Array3];
        [self.titleArray addObject:@"判断题"];
    }
    if (self.Array4.count>0) {
        [self.tixingArray addObject:self.Array4];
        [self.titleArray addObject:@"问答题"];
    }
    if (self.Array5.count>0) {
        [self.tixingArray addObject:self.Array5];
        [self.titleArray addObject:@"填空题"];
    }
    NSLog(@"%@+++++++++++++++++++++",self.tixingArray);
    NSLog(@"%@+++++++++++++++++++++",self.titleArray);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预览试卷";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    
    if ([self.liulantype isEqualToString:@"1000"]) {
        [self makeit:self.dic];
        [self.tableView reloadData];
    }else{
        
        [self GetActivePageView];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.tixingArray.count;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tixingArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //    if ([self.titleArray[indexPath.section] isEqualToString:@"单选题"]) {
    //        DanxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        GetActivePageViewModel *Model = self.Array1[indexPath.row];
    //        cell.model = Model;
    //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //
    //        return cell;
    //    }else if ([self.titleArray[indexPath.section] isEqualToString:@"多选题"]){
    //        DuoXuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        GetActivePageViewModel *Model = self.Array2[indexPath.row];
    //        cell.model = Model;
    //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //        cell.model = self.Array2[indexPath.row];
    //        return cell;
    //    }else if ([self.titleArray[indexPath.section] isEqualToString:@"判断题"]){
    //        PanduanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        GetActivePageViewModel *Model = self.Array3[indexPath.row];
    //        cell.model = Model;
    //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //        cell.model = self.Array3[indexPath.row];
    //        return cell;
    //    }else if ([self.titleArray[indexPath.section] isEqualToString:@"问答题"]){
    //        WendaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        GetActivePageViewModel *Model = self.Array4[indexPath.row];
    //        cell.model = Model;
    //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //        cell.model = self.Array4[indexPath.row];
    //        return cell;
    //    }else
    //        if ([self.titleArray[indexPath.section] isEqualToString:@"填空题"]){
    //        TiankongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
    //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //        cell.model = self.Array5[indexPath.row];
    //        GetActivePageViewModel *Model = self.Array5[indexPath.row];
    //        cell.model = Model;
    //        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //        return cell;
    //        }else{
    //            DanxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //            GetActivePageViewModel *Model = self.Array1[indexPath.row];
    //            cell.model = Model;
    //            cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
    //
    //        }
    
    if ([self.titleArray[indexPath.section] isEqualToString:@"单选题"]) {
        DanxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetActivePageViewModel *Model = self.Array1[indexPath.row];
        cell.model = Model;
        //        NSString *str = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        
        return cell;
    }else if ([self.titleArray[indexPath.section] isEqualToString:@"多选题"]){
        DuoXuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetActivePageViewModel *Model = self.Array2[indexPath.row];
        cell.model = Model;
        NSString *str = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        NSLog(@"-----------------%@",str);
        //        cell.model = self.Array2[indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        return cell;
    }else if ([self.titleArray[indexPath.section] isEqualToString:@"判断题"]){
        PanduanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetActivePageViewModel *Model = self.Array3[indexPath.row];
        cell.model = Model;
        
        //        cell.model = self.Array3[indexPath.row];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        return cell;
    }else if ([self.titleArray[indexPath.section] isEqualToString:@"问答题"]){
        WendaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetActivePageViewModel *Model = self.Array4[indexPath.row];
        cell.model = Model;
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        //        cell.model = self.Array4[indexPath.row];
        return cell;
    }else if ([self.titleArray[indexPath.section] isEqualToString:@"填空题"]){
        TiankongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.Array5[indexPath.row];
        GetActivePageViewModel *Model = self.Array5[indexPath.row];
        cell.model = Model;
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        return cell;
    }else{
        DanxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GetActivePageViewModel *Model = self.Array1[indexPath.row];
        cell.model = Model;
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),Model.SubjectTitle];
        
    }
    return nil;
    
    
}

- (void)suer{
    
     [SVProgressHUD showSuccessWithStatus:@"该功能暂未开放,敬请期待"];
//    GetPageSubjectRequst *requst = [[GetPageSubjectRequst alloc]init];
//    NSMutableArray *ary1 = [NSMutableArray array];
//    NSMutableArray *ary2 = [NSMutableArray array];
//    NSMutableArray *ary3 = [NSMutableArray array];
//    NSMutableArray *ary4 = [NSMutableArray array];
//    NSMutableArray *ary5 = [NSMutableArray array];
////    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] initWithCapacity:0];
////    [dic1 setObject:@"185" forKey:@"SubjectID"];
////    [dic1 setObject:@"399" forKey:@"ItemID"];
//    for (int i = 0; i < _Array1.count; i++) {
//        GetActivePageViewModel *Model = self.Array1[i];
//        NSDictionary* dic = @{
//                               @"SubjectID" : Model.SubjectID,
//                               @"answerID" : @"399"
//                               };
//        [ary1 addObject:dic];
//    }
//    for (int i = 0; i < _Array2.count; i++) {
//        GetActivePageViewModel *Model = self.Array2[i];
//        NSDictionary* dic = @{
//                              @"SubjectID" : Model.SubjectID,
//                              @"answerID" : @"399"
//                              };
//        [ary2 addObject:dic];
//    }
//    for (int i = 0; i < _Array3.count; i++) {
//        GetActivePageViewModel *Model = self.Array3[i];
//        NSDictionary* dic = @{
//                              @"SubjectID" : Model.SubjectID,
//                              @"answerID" : @"399"
//                              };
//        [ary3 addObject:dic];
//    }
//    for (int i = 0; i < _Array4.count; i++) {
//        GetActivePageViewModel *Model = self.Array4[i];
//        NSDictionary* dic = @{
//                              @"SubjectID" : Model.SubjectID,
//                              @"answerID" : @"399"
//                              };
//        [ary4 addObject:dic];
//    }
//    for (int i = 0; i < _Array5.count; i++) {
//        GetActivePageViewModel *Model = self.Array5[i];
//        NSDictionary* dic = @{
//                              @"SubjectID" : Model.SubjectID,
//                              @"answerID" : @"399"
//                              };
//        [ary5 addObject:dic];
//    }
//
//    NSDictionary* muDic = @{
//                           @"answer" : @"info",
//                           @"danxuan" : ary1,
//                           @"duoxuan" : ary2,
//                           @"tiankong" :ary3,
//                           @"panduan" :ary4,
//                           @"wenda" :ary5
//                           };
//
//
//
//
//    [requst PostAnswerRequstwithpageid:self.bookid withuserid:self.xf.Loginid daan:[self objectToJson:muDic]  :^(NSDictionary *json) {
//
//
//    }];
}

- (NSString*)objectToJson:(NSObject *)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//字典转字符串
- (NSString *)convertToJsonData:(id)infoDict

{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:infoDict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *jsonString = @"";
    
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.tixingArray[section] count] > 0) {
        return 40;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-40, 40)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [backView addSubview:titleLabel];
    if ([self.tixingArray[section] count] > 0) {
        titleLabel.text = self.titleArray[section];
    }
    
    return backView;
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
