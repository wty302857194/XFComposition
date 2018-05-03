//
//  CreatecircleViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CreatecircleViewController.h"
#import "CreatcircleFristCell.h"
#import "CreatcircleSecondCell.h"
#import "CreatcircleThridCell.h"
#import "CreatcircleFourCell.h"

#import "MenuView.h"
#import "UploadPicRequst.h"
#import "CreateGroupRequst.h"
#import "GetGroupTypeRequst.h"//获取圈子类型
#import "GetGroupTypeModel.h"
@interface CreatecircleViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textfield1;
@property (nonatomic,strong)UITextView *textView1;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)NSString *picStr;
@property (nonatomic,strong)NSMutableArray *groupTypeArray1;
@property (nonatomic,strong)NSMutableArray *groupTypeArray2;
@end

@implementation CreatecircleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CreatcircleFristCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[CreatcircleSecondCell class] forCellReuseIdentifier:@"cell2"];
        [_tableView registerClass:[CreatcircleThridCell class] forCellReuseIdentifier:@"cell3"];
        [_tableView registerClass:[CreatcircleFourCell class] forCellReuseIdentifier:@"cell4"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _tableView;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;

        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(100, 407.5, 120, 30*self.groupTypeArray2.count)cellarray:self.groupTypeArray2 block:^(NSInteger i) {
            weakSelf.isShow1 = NO;

            [weakSelf.bt2 setTitle:weakSelf.groupTypeArray2[i] forState:UIControlStateNormal];
            weakSelf.str1 = weakSelf.groupTypeArray1[i];
//            [weakSelf GetBookBJList:weakSelf.str1];
            
        }];
        [self.tableView addSubview:_menuView1];
    }
    return _menuView1;
}

-(NSString *)picStr{
    if (!_picStr) {
        _picStr = [[NSString alloc]init];
    }
    return _picStr;
}
-(NSString *)str1{
    if (!_str1) {
        _str1 = [[NSString alloc]init];
    }
    return _str1;
}
-(NSMutableArray *)groupTypeArray1{
    if (!_groupTypeArray1) {
        _groupTypeArray1 = [[NSMutableArray alloc]init];
    }
    return _groupTypeArray1;
}
-(NSMutableArray *)groupTypeArray2{
    if (!_groupTypeArray2) {
        _groupTypeArray2 = [[NSMutableArray alloc]init];
    }
    return _groupTypeArray2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建圈子";
    [self.view addSubview:self.tableView];
    [self getGroupType];
}
//获取圈子类型
-(void)getGroupType{
    GetGroupTypeRequst *requst = [[GetGroupTypeRequst alloc]init];
    
    [requst GetGroupTypeRequstwith:^(NSDictionary *json) {
        [self.groupTypeArray1 removeAllObjects];
        [self.groupTypeArray2 removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetGroupTypeModel *model = [GetGroupTypeModel loadWithJSOn:dic];
            [self.groupTypeArray1 addObject:[NSString stringWithFormat:@"%ld",(long)model.Typeid]];
            [self.groupTypeArray2 addObject:model.name];
        }
    }];
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 45;
    }else if (indexPath.row == 1){
        
        return 200;
        
    }else if (indexPath.row == 2){
        
        return 120;
    }else if (indexPath.row == 3){
        
        return 100;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CreatcircleFristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textfield1 = [[UITextField alloc]init];
        
        self.textfield1 = cell.textfield;
        
        
        return cell;
    }else if (indexPath.row == 1){
        CreatcircleSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textView1 = [[UITextView alloc]init];
        self.textView1 = cell.textview;
        
        
        return cell;
        
        
    }else if (indexPath.row == 2){
        CreatcircleThridCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt1 = cell.bt;
        [self.bt1 addTarget:self action:@selector(openCanmer) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
        
    }else if (indexPath.row == 3){
        CreatcircleFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = cell.bt;
        [self.bt2 setTitle:@"阅读乐园" forState:UIControlStateNormal];
        [self.bt2 addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
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
    
    return 60;
    
}
#pragma mark - headeView内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 60)];
    backview.backgroundColor = [UIColor whiteColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(WidthFrame/4, 20, WidthFrame/2, 40);
    [bt setTitle:@"保存" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(baocunquanzi) forControlEvents:UIControlEventTouchUpInside];
    bt.layer.cornerRadius = 6;
    bt.layer.masksToBounds = YES;
    [bt setBackgroundColor:[UIColor colorWithHexString:@"F1AF49"]];
    [backview addSubview:bt];
    return backview;
}
-(void)openCanmer{
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
    [self.bt1 setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [self.bt1 setTitle:nil forState:UIControlStateNormal];
    NSData *imageData1 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
    __weak typeof (self) weakSelf = self;
    UploadPicRequst *requst = [[UploadPicRequst alloc]init];
    
    [requst UploadPicRequstWithfileValue:imageData1 withuserid:self.userid withtypeid:@"5" :^(NSDictionary *json) {
        weakSelf.picStr = json[@"ret_data"];
    }];
    
    
}

-(void)showMenu{
    _isShow1 = !_isShow1;
    if (_isShow1) {
        [self.menuView1 showView];
    }else{
        [self.menuView1 dismissView];
    }

}
//保存创建圈子
-(void)baocunquanzi{
     __weak typeof (self) weakSelf = self;
    CreateGroupRequst *requst = [[CreateGroupRequst alloc]init];
    [requst CreateGroupRequstwithid:@"0" withuserid:self.userid withgroupname:self.textfield1.text withtypeid:self.str1 withgroupinfo:self.textView1.text withgroupicon:self.picStr :^(NSDictionary *json) {
        if ([json[@"ret_code"] isEqualToString:@"0"]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"创建成功，等待审核!" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }]];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }

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
