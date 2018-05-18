//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "XFCorrectViewController.h"
#import "TYImageEditViewController.h"
#import "QiPaoTagView.h"

#import "SaveCommentCheckRequst.h"
#import "GetWritePicRemarkRequst.h"
#import "DeleteCommentCheckRequst.h"
#import "UploadPicRequst.h"

#import "GetWritePicRemarkModel.h"

static NSInteger const qiPaoWidth = 160;
@interface XFCorrectViewController ()<UIScrollViewDelegate>
{
    TYImageEditViewController * contentViewController;
}
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong) NSMutableArray *qiPaoArr;//旁批内容
@property (nonatomic,strong)NSMutableArray *remarkArray;
@property (nonatomic,strong)NSString *picnameurl;

@end

@implementation XFCorrectViewController
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kLayoutViewMarginTop, kScreenWidth, kScreenHeight - kLayoutViewMarginTop - kSafeAreaMaiginBottom)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(WidthFrame*3/2, _scrollView.height);
        _scrollView.scrollEnabled = NO;
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
        [_scrollView addSubview:_leftView];
        
        contentViewController = [[TYImageEditViewController alloc] init];
        contentViewController.TYCorrecVC = self;
        contentViewController.picModel = self.picModel;//执行frame时才会走viewdidload方法
        contentViewController.view.frame = CGRectMake(0, 0, _leftView.width, _leftView.height);
        [contentViewController getGetWriteAudioRequestData];
        [self addChildViewController:contentViewController];
        [_leftView addSubview:contentViewController.view];
        
        
        
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.width, 0, _scrollView.width/2.f, _scrollView.height)];
        _rightView.backgroundColor = hexColor(e2d5cb);
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomBtn setTitle:@"添 加" forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.backgroundColor = hexColor(3198d5);
        [bottomBtn addTarget:self action:@selector(addPangPi) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(40);
        }];
        [_scrollView addSubview:_rightView];
    }
    return _scrollView;
}
- (void)addPangPi {
    [self addPangPi:nil];
}

- (void)addPangPi:(GetWritePicRemarkModel *)model {
    NSInteger height = 50;
    if (model) {
        height = [Global heightForText:model.Remark?:@"" textFont:15 standardWidth:qiPaoWidth]+44;
    }
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake([model.XLocation?:@"" integerValue], [model.YLocation?:@"" integerValue], qiPaoWidth, height)];
    
    if (model) {
        qiPaoView.textView.text = model.Remark?:@"";
    }
    
    __weak typeof(self) weakSelf = self;
    __weak QiPaoTagView *weak_qiPaoView = qiPaoView;
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        __strong QiPaoTagView *strong_qiPaoView = weak_qiPaoView;
        NSInteger X = strong_qiPaoView.frame.origin.x;
        NSInteger Y = strong_qiPaoView.frame.origin.y;
        
        NSDictionary *dic = @{
                              @"Id": model.ID?:@"0",   //标识   0是新增  非0 即修改
                              @"CreateTime": [Global currentTime],
                              @"BlogID":weakSelf.picModel.ID, //习作ID
                              @"PicID":weakSelf.picModel.PicID,  //习作图片ID
                              @"UserID":weakSelf.xf.userId, //用户ID
                              @"Sort": @"0", //排序
                              @"Remark": contentStr,    //点评内容
                              @"XLocation": @(X),  //X轴
                              @"YLocation": @(Y)  //Y轴
                              };
        
        [weakSelf.qiPaoArr addObject:dic];
    };
    [_rightView addSubview:qiPaoView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _qiPaoArr = [NSMutableArray arrayWithCapacity:0];
    
    if (self.isChange) {
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"保存批改" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao)];
        self.navigationItem.rightBarButtonItem = item2;
    }else {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"查看旁批" style:UIBarButtonItemStylePlain target:self action:@selector(seePangPi)];
        self.navigationItem.rightBarButtonItem = item1;
    }
    
    
    [self.view addSubview:self.scrollView];
    
    
    [self GetWritePicRemarkRequestData];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x == 0) {
        scrollView.scrollEnabled = NO;
    }
}
- (void)seePangPi {
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth/2.f, self.scrollView.contentOffset.y)];
        self.scrollView.scrollEnabled = YES;
    }];
}
//保存批改
-(void)tijiao {
    UIImage *image = [Global makeImageWithView:contentViewController.imgView withSize:contentViewController.imgView.size];
    UploadPicRequst *uploadPicRequst = [[UploadPicRequst alloc]init];
    NSData *imageData = UIImagePNGRepresentation(image);
    [uploadPicRequst UploadPicRequstWithfileValue:imageData withuserid:self.xf.Loginid withtypeid:@"1" :^(NSDictionary *json) {
        self.picnameurl = json[@"ret_data"];
        
        [self SubmitPicCheckRequestData];

    }];
}
/*
 "Action:SubmitPicCheck
 Token:0A66A4FD-146F-4542-8D7B-33CDEC2981F9
 PicID：23    // 习作图片标识
 userID：23    // 用户标识
 blogID：23    // 习作标识
 PicUrl:   //复制习作图片
 FixPicUrl:   //教师处理后的图片
 Remarks: [
 {
 ""Id"": 134,   //标识   0是新增  非0 即修改
 ""CreateTime"": ""2017/5/1 22:07:30"",
 ""BlogID"": ""43"",  //习作ID
 ""PicID"": ""43"",  //习作图片ID
 ""UserID"": ""23"", //用户ID
 ""Sort"": ""0"", //排序
 ""Remark"": ""这段写的好"",    //点评内容
 ""XLocation"": 10.08,  //X轴
 ""YLocation"": 10.08  //Y轴
 }
 ]
 Audios: [
 {
 ""Id"": 134,   //标识  0是新增  非0 即修改
 ""CreateTime"": ""2017/5/1 22:07:30"",
 ""BlogID"": ""43"",  //习作ID
 ""PicID"": ""43"",  //习作图片ID
 ""UserID"": ""23"", //用户ID
 ""Sort"": ""0"", //排序
 ""AudioUrl"": ""/LocalFiles/WriteAudio/2018/4/2018419232927.mp3"",    //录音URL
 ""XLocation"": 10.08,  //X轴
 ""YLocation"": 10.08  //Y轴
 }
 ]"
 */
#pragma mark - 保存批改
- (void)SubmitPicCheckRequestData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"SubmitPicCheck",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"BlogID": self.picModel.ID,  //习作ID
                          @"PicID": self.picModel.PicID,  //习作图片ID
                          @"UserID": [XFUserInfo getUserInfo].Loginid, //用户ID
                          @"PicUrl":self.picModel.PicUrl,
                          @"FixPicUrl":self.picnameurl,
                          @"Remarks":self.qiPaoArr,
                          @"Audios":contentViewController.vedioArr
                          };
    NSLog(@"dic = %@",dic);
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

//-(void)GetWritePicRemark{
//    __weak typeof (self) weakSelf = self;
//    //    GetWritePicModel *model = self.picArray[indexPath.row];
//    GetWritePicRemarkRequst *requst = [[GetWritePicRemarkRequst alloc]init];
//    [requst GetWritePicRemarkRequstwithpicid:self.PicID :^(NSDictionary *json) {
//        [self.remarkArray removeAllObjects];
//        for (NSDictionary *dic in json[@"ret_data"]) {
//            GetWritePicRemarkModel *model = [GetWritePicRemarkModel loadWithJSOn:dic];
//            [weakSelf.remarkArray addObject:model];
//        }
//    }];
//}
/*
{
    "Id": 134,   //标识
    "CreateTime": "2017/5/1 22:07:30",
    "BlogID": "43",  //习作ID
    "PicID": "43",  //习作图片ID
    "UserID": "23", //用户ID
    "Sort": "0", //排序
    "Remark": "这段写的好",    //点评内容
    "XLocation": "10.08",  //X轴
    "YLocation": "10.08"  //Y轴
}*/
#pragma mark - 获取旁批
- (void)GetWritePicRemarkRequestData {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:APIurl];
    NSDictionary *dic = @{
                          @"Action":@"GetWritePicRemark",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"blogID": self.picModel.BlogID,  //习作ID
                          @"PicID": self.picModel.PicID,  //习作图片ID
                          @"userID": [XFUserInfo getUserInfo].Loginid, //用户ID
                          };
    NSLog(@"dic = %@",dic);
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        NSArray *arr = succeedResult[@"ret_data"];
        if (arr&&arr.count>0) {
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = (NSDictionary *)obj;
                
                GetWritePicRemarkModel *model = [GetWritePicRemarkModel loadWithJSOn:dic];
                [self addPangPi:model];
            }];
        }
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
@end
