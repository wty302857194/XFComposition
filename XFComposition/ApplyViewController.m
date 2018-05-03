//
//  ApplyViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//
/************
 志愿者教师申请
 ***********/
#import "ApplyViewController.h"
#import "ApplyFrsitCell.h"
#import "ApplySecondCell.h"
#import "TeachApplyActionRequst.h"
#import "UploadPicRequst.h"

#import "JXAlertview.h"
#import "CustomDatePicker.h"
//#import "AFHTTPRequestOperationManager.h"
@interface ApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CustomAlertDelegete>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextField *textfield2;
@property (nonatomic,strong)UITextField *textfield3;
@property (nonatomic,strong)UITextField *textfield4;
@property (nonatomic,strong)UITextField *textfield5;

@property (nonatomic,strong)UIButton *isbutton;
@property (nonatomic,strong)NSArray *texenameArray;
@property (nonatomic,strong)NSArray *placheoldArray;
@property (nonatomic,strong)NSArray *addPicArray;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)CustomDatePicker *Dpicker;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)NSString *str2;
@property (nonatomic,strong)NSString *str3;
@property (nonatomic,strong)NSString *str4;
@property (nonatomic,strong)NSString *str5;
@property (nonatomic,strong)NSMutableArray *btarray;

@end

@implementation ApplyViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"志愿教师申请";
    self.xf = [XFUserInfo getUserInfo];
    [self.view addSubview:self.tableView];
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ApplyFrsitCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[ApplySecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    }
    return _tableView;
}

-(NSArray *)texenameArray{
    if (!_texenameArray) {
        _texenameArray = @[@"姓名",@"年龄",@"性别",@"手机号码",@"教师简介"];
    }
    return _texenameArray;
}
-(NSArray *)placheoldArray{
    if (!_placheoldArray) {
        _placheoldArray = @[@"例：鲁迅>",@"例：1990年2月12日>",@"例：男>",@"手机号码>",@"简介>"];
    }
    return _placheoldArray;
}
-(NSArray *)addPicArray{
    if (!_addPicArray) {
        _addPicArray = @[@"添加本人正面照片",@"添加本人身份证照片",@"添加教师资格证照片",@"添加本人工作证照片",@"添加申请表"];
    }
    return _addPicArray;
}
-(CustomDatePicker *)Dpicker{
    if (!_Dpicker) {
        _Dpicker = [[CustomDatePicker alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width-20, 200)];
    }
    return _Dpicker;
}
-(NSString *)str1{
    if (!_str1) {
        _str1 = [[NSString alloc]init];
    }
    return _str1;
}
-(NSString *)str2{
    if (!_str2) {
        _str2 = [[NSString alloc]init];
    }
    return _str2;
}
-(NSString *)str3{
    if (!_str3) {
        _str3 = [[NSString alloc]init];
    }
    return _str3;
}
-(NSString *)str4{
    if (!_str4) {
        _str4 = [[NSString alloc]init];
    }
    return _str4;
}
-(NSString *)str5{
    if (!_str5) {
        _str5 = [[NSString alloc]init];
    }
    return _str5;
}
-(NSMutableArray *)btarray{
    if (!_btarray) {
        _btarray = [[NSMutableArray alloc]init];
        for (int i=0; i<5; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.btarray addObject:bt];
        }
        
    }
    return _btarray;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if (indexPath.section == 0) {
        ApplyFrsitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = self.texenameArray[indexPath.row];
        cell.textfield.placeholder = self.placheoldArray[indexPath.row];

        if (indexPath.row == 0) {
            self.textfield1 = [[UITextField alloc]init];
            self.textfield1 = cell.textfield;
            
        }else if (indexPath.row == 1) {

            self.textfield2 = [[UITextField alloc]init];
            self.textfield2 = cell.textfield;
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(200, 0, WidthFrame-200, 40);
            [bt addTarget:self action:@selector(showTextfield) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:bt];
//            self.textfield2.delegate = self;

        }else if (indexPath.row == 2) {
            self.textfield3 = [[UITextField alloc]init];
            self.textfield3 = cell.textfield;
            
        }else if (indexPath.row == 3) {
            self.textfield4 = [[UITextField alloc]init];
            self.textfield4 = cell.textfield;
            
        }else if (indexPath.row == 4) {
            self.textfield5 = [[UITextField alloc]init];
            self.textfield5 = cell.textfield;
            
        }
        return cell;
    }else if (indexPath.section == 1){
        ApplySecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.bt setTitle:self.addPicArray[indexPath.row] forState:UIControlStateNormal];
        [cell.bt addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
        cell.bt.tag = 1000+indexPath.row;
        self.btarray[indexPath.row] = cell.bt;
        
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(WidthFrame/3, 10, WidthFrame/3, 30);
        [bt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = 4;
        [bt addTarget:self action:@selector(applyTeacher) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:@"提交申请" forState:UIControlStateNormal];
        [cell addSubview:bt];
        return cell;
        
    }
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
    
        return 140;
    }
    return 80;
}
-(void)addPic:(UIButton *)bt{
    self.isbutton = bt;
    [self openCamera];
}
- (void)openCamera

{
    
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
    
    // 设置图片
    [self.isbutton setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [self.isbutton setTitle:nil forState:UIControlStateNormal];
    NSData *imageData2 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];
    [requst UploadPicRequstWithfileValue:imageData2 withuserid:self.xf.Loginid withtypeid:@"3" :^(NSDictionary *json) {
        if (self.isbutton.tag == 1000) {
            self.str1 = json[@"ret_data"];
        }else if (self.isbutton.tag == 1001){
            self.str2 = json[@"ret_data"];
            
        }else if (self.isbutton.tag == 1002){
            self.str3 = json[@"ret_data"];
            
        }else if (self.isbutton.tag == 1003){
            self.str4 = json[@"ret_data"];
            
        }else if (self.isbutton.tag == 1004){
            self.str5 = json[@"ret_data"];
            
        }
    }];


}
-(void)showTextfield{
    JXAlertview *alert = [[JXAlertview alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height-260)/2, self.view.frame.size.width-20, 260)];
    //alert.image = [UIImage imageNamed:@"dikuang"];
    alert.delegate = self;
    [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定"];
    
    //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
    [alert addSubview:self.Dpicker];
    [alert show];
}

-(void)btnindex:(int)index :(int)tag
{
    if (index == 2) {
        self.textfield2.text = [NSString stringWithFormat:@"%d年%d月%d日",self.Dpicker.year,self.Dpicker.month,self.Dpicker.day];
        [self.textfield2 resignFirstResponder];
    }
}


//提交申请
-(void)applyTeacher{
    /*方式二：使用Base64字符串传图片*/
    
    TeachApplyActionRequst *requst = [[TeachApplyActionRequst alloc]init];
    [requst TeachApplyActionWithUserId:self.xf.Loginid withName:self.textfield1.text withAge:self.textfield2.text withSex:self.textfield3.text withPhone:self.textfield4.text withteacherpic:self.str1 withteachercardfond:self.str2 withteachercardback:self.str3 withteachercertified:self.str4 withteacherworkcard:self.str5 withteacherapplytable1:@"" withteacherapplytable2:@"" withteacherinfo:@"" :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]){
             [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
             [self onBack];
        }else{
             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_data"]]];
        }
        NSLog(@"%@",json[@"ret_data"]);
    }];

}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
