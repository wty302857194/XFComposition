//
//  BookEditViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookEditViewController.h"
#import "BookFristCell.h"
#import "BookSecondCell.h"
#import "BookThridCell.h"
#import "MenuView.h"
#import "ListSelectView.h"

#import "SaveBookRequst.h"//保存图书
#import "GetBookTypeRequst.h"//全部年级获取
#import "GetBookTypeModel.h"
#import "UploadPicRequst.h"
#import "GetBookInfoRequst.h"
#import "GetBookInfoModel.h"
@interface BookEditViewController ()<UITableViewDelegate,UITableViewDataSource,BookThridCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    NSString *_categoryStr;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)GetBookInfoModel *bookinfoModel;
@property (nonatomic,strong)UITextField *textFiled1;
@property (nonatomic,strong)UITextField *textFiled2;
@property (nonatomic,strong)UITextField *textFiled3;
@property (nonatomic,strong)UITextField *textFiled4;
@property (nonatomic,strong)UITextField *textFiled5;
@property (nonatomic,strong)UITextField *textFiled6;
@property (nonatomic,strong)FSTextView *textview;


@property (nonatomic,strong)MenuView *menuView;

@property (nonatomic,strong)NSMutableArray *gradeArray;
@property (nonatomic,strong)NSMutableArray *menuarray;
@property (nonatomic,strong)NSMutableArray *strArray;
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic,strong)NSString *bookTypeId;

@property (nonatomic,strong)UIButton *picBt;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation BookEditViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[BookFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[BookSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[BookThridCell class] forCellReuseIdentifier:@"cell3"];

    }
    return _tableView;
}
-(MenuView *)menuView{
    if (!_menuView) {
        
        __weak typeof (self) weakSelf = self;
        _menuView = [[MenuView alloc]initWithFrame:CGRectMake(100, 235, WidthFrame-120, 30*self.menuarray.count) cellarray:self.menuarray block:^(NSInteger index) {
            weakSelf.isShow = NO;
//            weakSelf.quxianStr = weakSelf.strArray[index];
//            if ([self.bookFlag isEqualToString:@"1"]) {
//                self.textFiled6.text = self.menuarray[0];
//                self.bookTypeId = self.strArray[0];
//            }else{
                self.textFiled6.text = self.menuarray[index];
                self.bookTypeId = self.strArray[index];
//            }
            
        }];
        [self.tableView addSubview:_menuView];
    }
    return _menuView;
}
-(NSMutableArray *)gradeArray{
    if (!_gradeArray) {
        _gradeArray = [[NSMutableArray alloc]init];
    }
    return _gradeArray;
}
-(NSMutableArray *)menuarray{
    if (!_menuarray) {
        _menuarray = [[NSMutableArray alloc]init];
    }
    return _menuarray;
}
-(NSMutableArray *)strArray{
    if (!_strArray) {
        _strArray = [[NSMutableArray alloc]init];
    }
    return _strArray;
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"图书名称：",@"出 版 社：",@"图书作者：",@"图书页数：",@"图书类别："];
    }
    return _titleArray;
}
-(GetBookInfoModel *)bookinfoModel{
    if (!_bookinfoModel) {
        _bookinfoModel = [[GetBookInfoModel alloc]init];
    }
    return _bookinfoModel;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        
    }
    return _xf;
}
-(NSString *)str1{
    if (!_str1) {
        _str1 = [[NSString alloc]init];
    }
    return _str1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图书编辑";
    _categoryStr = @"";
    [self.view addSubview:self.tableView];
   
    self.xf = [XFUserInfo getUserInfo];
    [self GetGradeList];
    if ([self.bookFlag isEqualToString:@"1"]) {
        [self GetBookInfo];
    }
}

//图书信息
-(void)GetBookInfo{
    
    GetBookInfoRequst *requst = [[GetBookInfoRequst alloc]init];
    [requst GetBookInfoRequstWithbookid:self.bookId withuserid:self.xf.Loginid :^(NSDictionary *josn) {
        self.bookinfoModel = [[GetBookInfoModel alloc]init];
        self.bookinfoModel = [GetBookInfoModel loadWithJSOn:josn[@"ret_data"]];
                dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
//全部年级
-(void)GetGradeList{
    GetBookTypeRequst *requst = [[GetBookTypeRequst alloc]init];
    [requst GetBookTypeRequst:^(NSDictionary *json) {
        [self.gradeArray removeAllObjects];
        [self.menuarray removeAllObjects];
        [self.strArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetBookTypeModel *model = [GetBookTypeModel loadWithJSOn:dic];
            [self.gradeArray addObject:model];
            [self.menuarray addObject:model.BookTypeName];
            [self.strArray addObject:model.BookTypeid];
        }
        _categoryStr = self.menuarray[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

//上传照片
-(void)Uppic{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
        
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:picture];
    [self presentViewController:alertVc animated:YES completion:nil];
}
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
//    self.image1 = info[UIImagePickerControllerOriginalImage];
    [self.picBt setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [self.picBt setTitle:nil forState:UIControlStateNormal];
    NSData *imageData1 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
    
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];
    
    [requst UploadPicRequstWithfileValue:imageData1 withuserid:self.xf.Loginid withtypeid:@"2" :^(NSDictionary *json) {
        self.str1 = json[@"ret_data"];
    }];


}
//保存信息
-(void)baocun :(NSString *)bookFlag{
    
  
    if ( _textFiled1.text.length == 0|| _textFiled2.text.length == 0|| _textFiled3.text.length == 0|| _textFiled4.text.length == 0|| _textFiled5.text.length == 0|| _textFiled6.text.length == 0){
               [MBProgressHUD showError:@"请完善图书信息"];
    }else{
        __weak typeof (self) weakSelf = self;
        SaveBookRequst *requst = [[SaveBookRequst alloc]init];
        [requst SaveBookRequstwithbookName:self.textFiled1.text withbookAuthor:self.textFiled3.text withbookPublish:self.textFiled2.text withbookPic:self.str1 withbookInfo:self.textview.text withbookTypeID:self.bookTypeId withbookPages:self.textFiled5.text withbookFlag:self.bookFlag withBookBuyAddress:self.textFiled4.text withboobx:@"0" withuserid:self.xf.Loginid :^(NSDictionary *json) {
            if ([json[@"ret_code"] isEqualToString:@"0"]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                }]];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            
        }];
    }
 
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return self.titleArray.count;
    }else if (section == 1){
        return 1;
        
    }else if (section == 2){
        return 1;
        
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        return 110;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BookFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label.text = self.titleArray[indexPath.row];
        if (indexPath.row == 0) {
            self.textFiled1 = [[UITextField alloc]init];
            self.textFiled1 = cell.textfield;
            self.textFiled1.placeholder = @"请输入图书名称";
            if ([self.bookFlag isEqualToString:@"1"]) {
                self.textFiled1.text = self.bookinfoModel.bookname;
            }
        }else if (indexPath.row == 1){
            self.textFiled2 = [[UITextField alloc]init];
            self.textFiled2 = cell.textfield;
            self.textFiled2.placeholder = @"请输入出版社";
            if ([self.bookFlag isEqualToString:@"1"]) {
                self.textFiled2.text = self.bookinfoModel.bookpublish;
            }
        }else if (indexPath.row == 2){
            self.textFiled3 = [[UITextField alloc]init];
            self.textFiled3 = cell.textfield;
            self.textFiled3.placeholder = @"请输入图书作者";

            if ([self.bookFlag isEqualToString:@"1"]) {
                self.textFiled3.text = self.bookinfoModel.bookauthor;
            }
        }else if (indexPath.row == 3){
            self.textFiled4 = [[UITextField alloc]init];
            self.textFiled4 = cell.textfield;
            self.textFiled4.placeholder = @"请输入图书页数";

            if ([self.bookFlag isEqualToString:@"1"]) {
                self.textFiled4.text = self.bookinfoModel.bookpages;
            }
        }else if (indexPath.row == 4){
            self.textFiled5 = [[UITextField alloc]init];
            self.textFiled5 = cell.textfield;
            self.textFiled5.enabled  = NO;
            self.textFiled5.placeholder = @"请输入图书类别";
            

            if ([self.bookFlag isEqualToString:@"1"]) {
                self.textFiled5.text = [NSString stringWithFormat:@"%@",_categoryStr];
            }
        }
//        else if (indexPath.row == 5){
//
//            self.textFiled6 = [[UITextField alloc]init];
//            self.textFiled6 = cell.textfield;
//            self.textFiled6.placeholder = @"请输入图书介绍";
//
//            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
//            bt.frame = CGRectMake(100, 5, WidthFrame-120, 30);
//            [bt addTarget:self action:@selector(showmenu) forControlEvents:UIControlEventTouchUpInside];
//            if ([self.bookFlag isEqualToString:@"1"]) {
//                if (self.menuarray.count>0) {
//                    self.textFiled6.text = self.menuarray[0];
//                    self.bookTypeId = self.strArray[0];
//                }
//
//            }
//            [cell addSubview:bt];
//
//        }
        return cell;
    }else if (indexPath.section == 1){
    
        BookSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textview = [[FSTextView alloc]init];
        self.textview = cell.textView;
        self.textview.placeholder = @"请输入图书介绍";

        if ([self.bookFlag isEqualToString:@"1"]) {
            self.textview.text = self.bookinfoModel.bookinfo;
        }
        return cell;
    }else if (indexPath.section == 2){
        BookThridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        self.picBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.picBt = cell.shangchuanbt;
        if ([self.bookFlag isEqualToString:@"1"]) {
            
            NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.bookinfoModel.bookpic];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
            
            [self.picBt  setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        }

        return cell;
    }
    
    return nil;
}
#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section ==2) {
        return 50;
    }
    return 0.01;
}
#pragma mark - footView内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:@"保存标记" forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.layer.cornerRadius = 4;
        bt.layer.masksToBounds = YES;
        bt.frame = CGRectMake(10, 10,(WidthFrame-30)/2.f, 30);
        [bt addTarget:self action:@selector(baocun :) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bt];
        
        
        UIButton *cancel_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancel_btn setTitle:@"取 消" forState:UIControlStateNormal];
        [cancel_btn setBackgroundColor:[UIColor colorWithHexString:@"e38f24"]];
        cancel_btn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancel_btn.layer.cornerRadius = 4;
        cancel_btn.layer.masksToBounds = YES;
        cancel_btn.frame = CGRectMake(10+10+(WidthFrame-30)/2.f, 10,(WidthFrame-30)/2.f, 30);
        [cancel_btn addTarget:self action:@selector(goBackNV) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:cancel_btn];
        return view;

    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0&&indexPath.row == 4) {
        __weak typeof(self) weakSelf = self;
        ListSelectView *select_view = [[ListSelectView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight-kLayoutViewMarginTop)];
        select_view.choose_type = MORECHOOSETITLETYPE;
        select_view.isShowCancelBtn = NO;
        select_view.isShowSureBtn = NO;
        select_view.isShowTitle = NO;
        [select_view addTitleArray:self.menuarray andTitleString:@"温馨提示" animated:YES completionHandler:^(NSString * _Nullable string, NSInteger index) {
            _categoryStr = string;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } withSureButtonBlock:^{
            NSLog(@"sure btn");
        }];
        [self.view addSubview:select_view];
    }
}
-(void)showmenu{
    _isShow = !_isShow;
    if (_isShow) {
        [self.menuView showView];
        
    }else{
        [self.menuView dismissView];
        
    }
}

-(void)leftBarButton{
    GO_BACK;
}
-(void)goBackNV {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
