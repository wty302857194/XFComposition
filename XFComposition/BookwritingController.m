//
//  BookwritingController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookwritingController.h"
#import "BookwritingView.h"
#import "UploadPicRequst.h"
#import "AddBlogwritingRequst.h"
#import "AddBlogPicReuqst.h"
@interface BookwritingController ()<bookWritingDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)BookwritingView *bookView;
@property (nonatomic,strong)UIButton *isbutton;

@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSString *str1;
@property (nonatomic,strong)NSString *str2;
@property (nonatomic,strong)NSString *str3;
@property (nonatomic,strong)NSString *str4;
@property (nonatomic,strong)NSString *str5;
@property (nonatomic,strong)NSString *str6;

@property (nonatomic,strong)NSString *writStr;
@property (nonatomic,strong)NSString *isTF;
@end

@implementation BookwritingController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(BookwritingView *)bookView{
    if (!_bookView) {
        _bookView = [[BookwritingView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _bookView.delegate = self;
        
    }
    return _bookView;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
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
-(NSString *)str6{
    if (!_str6) {
        _str6 = [[NSString alloc]init];
    }
    return _str6;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"习作书写";
    self.view.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
    
    [self.view addSubview:self.bookView];
}
-(void)didsome:(UIButton *)bt{
    for (UIButton *button in self.bookView.btarray) {
        if (button.tag == bt.tag) {
            self.isbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.isbutton = button;
            [self openCamera];
        }
        
    }
    

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
        NSData *imageData1 = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.2);
        
        UploadPicRequst *requst = [[UploadPicRequst alloc]init];
        
        [requst UploadPicRequstWithfileValue:imageData1 withuserid:self.xf.Loginid withtypeid:@"1" :^(NSDictionary *json) {

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

            }else if (self.isbutton.tag == 1005){
                self.str6 = json[@"ret_data"];
            }
        }];
    
}


//保存
-(void)didSave{
    
    NSArray *arr = @[self.str1,self.str2,self.str3,self.str4,self.str5,self.str6];
    
    __weak typeof (self) weakSelf = self;
    AddBlogwritingRequst *requst = [[AddBlogwritingRequst alloc]init];
    [requst AddBlogwritingRequstwithNoticeName:self.bookView.textfield.text withNoticeObject:@"0" withNoticeContent:@"" withNoticeID:@"0" withuserid:self.xf.Loginid withmodel:@"7" withposttype:self.bookView.xingji withIsApp:@"1" :^(NSDictionary *json) {
        
        if ([json[@"ret_code"] isEqualToString:@"0"]){
           [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
            weakSelf.writStr = json[@"ret_data"];
            
            for (int i = 0; i<6; i++) {
                if ([arr[i] isEqualToString:@""]) {
                    
                }else{
                    //            NSLog(@"哈哈%@",weakSelf.writStr);
                    
                    AddBlogPicReuqst *requst2 = [[AddBlogPicReuqst alloc]init];
                    [requst2 AddBlogPicReuqstwithblogID:weakSelf.writStr withblogPic:arr[i] withuserid:self.xf.Loginid :^(NSDictionary *json) {
                        self.isTF = json[@"ret_code"];
                    }];
                }
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"ret_msg"]]];
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
