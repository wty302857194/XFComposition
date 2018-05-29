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
        height = [Global heightForText:model.Remark?:@"" textFont:15 standardWidth:qiPaoWidth]+24;
    }
    float x_oragin = [model.XLocation?:@"" floatValue]*self.rightView.width;
    float y_oragin = [model.YLocation?:@"" floatValue]*self.view.height;
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake(x_oragin, y_oragin, qiPaoWidth, height)];
    qiPaoView.tag = self.qiPaoArr.count;
    if (model) {
        qiPaoView.textView.text = model.Remark?:@"";
        qiPaoView.time = model.CreateTime;
    }else {
        qiPaoView.time = [Global currentTime];
    }
    
    NSDictionary *dic =@{
                         @(qiPaoView.tag):@{
                                 @"Id": model.ID?:@"0",   //标识   0是新增  非0 即修改
                                 @"CreateTime": qiPaoView.time,
                                 @"BlogID":self.picModel.BlogID, //习作ID
                                 @"PicID":self.picModel.ID,  //习作图片ID
                                 @"UserID":[XFUserInfo getUserInfo].Loginid , //用户ID
                                 @"Sort": @"0", //排序
                                 @"Remark": model.Remark?:@"",    //点评内容
                                 @"XLocation": @(qiPaoView.frame.origin.x/self.rightView.width),  //X轴
                                 @"YLocation": @(qiPaoView.frame.origin.y/self.view.height)  //Y轴
                                 }
                         };
  
    if (model == nil) {
        [self.qiPaoArr addObject:dic];

    }
    __weak typeof(self) weakSelf = self;
    __weak QiPaoTagView *weak_qiPaoView = qiPaoView;
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        __strong QiPaoTagView *strong_qiPaoView = weak_qiPaoView;

        [weakSelf.qiPaoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:obj];
            if ([[dataDic.allKeys firstObject] integerValue] == strong_qiPaoView.tag ) {
                NSMutableDictionary *veluedic = [NSMutableDictionary dictionaryWithDictionary:dataDic.allValues.firstObject];
                veluedic[@"Remark"] = contentStr;
                dataDic[@(strong_qiPaoView.tag)] = veluedic;
            }
            [self.qiPaoArr replaceObjectAtIndex:idx withObject:dataDic];
            NSLog(@"self.vedioArr===%@",self.qiPaoArr);
        }];
    };
    qiPaoView.locationBlock = ^(CGRect frame) {
        __strong QiPaoTagView *strong_qiPaoView = weak_qiPaoView;
        float X = frame.origin.x/weakSelf.rightView.width;
        float Y = frame.origin.y/weakSelf.view.height;
        
        [weakSelf.qiPaoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:obj];
            if ([[dataDic.allKeys firstObject] integerValue] == strong_qiPaoView.tag ) {
                NSMutableDictionary *veluedic = [NSMutableDictionary dictionaryWithDictionary:dataDic.allValues.firstObject];
                veluedic[@"XLocation"] = @(X);
                veluedic[@"YLocation"] = @(Y);
                dataDic[@(strong_qiPaoView.tag)] = veluedic;

            }
            [self.qiPaoArr replaceObjectAtIndex:idx withObject:dataDic];
            NSLog(@"self.vedioArr===%@",self.qiPaoArr);
        }];
    };
    
    qiPaoView.longPressBlock = ^{
        __strong QiPaoTagView *strong_qiPaoView = weak_qiPaoView;

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否要删除？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteCommentCheckRequestData:model.ID qiPaoView:strong_qiPaoView];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
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
    NSMutableArray *qiPaoNewArr = [NSMutableArray arrayWithCapacity:0];
    [self.qiPaoArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:obj];
        [qiPaoNewArr addObject:dataDic.allValues.firstObject];
    }];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSData *qiPaoData = [NSJSONSerialization dataWithJSONObject:qiPaoNewArr
                                                       options:kNilOptions
                                                         error:nil];
    
    NSString *qiPaoString = [[NSString alloc] initWithData:qiPaoData
                                                 encoding:NSUTF8StringEncoding];
    
    NSData *vedioData = [NSJSONSerialization dataWithJSONObject:contentViewController.vedioArr
                                                        options:kNilOptions
                                                          error:nil];
    
    NSString *vedioDataString = [[NSString alloc] initWithData:vedioData
                                                      encoding:NSUTF8StringEncoding];
    
    
    BaseRequest *request = [BaseRequest requestWithURL:nil];
    NSDictionary *dic = @{
                          @"Action":@"SubmitPicCheck",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"blogID": self.picModel.BlogID,  //习作ID
                          @"PicID": self.picModel.ID,  //习作图片ID
                          @"userID": [XFUserInfo getUserInfo].Loginid, //用户ID
                          @"PicUrl":self.picModel.PicUrl,
                          @"FixPicUrl":self.picnameurl,
                          @"Remarks":qiPaoString,
                          @"Audios":vedioDataString
                          };
    NSLog(@"dic = %@",dic);
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
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
                          @"PicID": self.picModel.ID,  //习作图片ID
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
#pragma mark - 删除旁批、
- (void)deleteCommentCheckRequestData:(NSString *)ID qiPaoView:(QiPaoTagView *)qiPaoView {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BaseRequest *request = [BaseRequest requestWithURL:APIurl];
    NSDictionary *dic = @{
                          @"Action":@"DeleteCommentCheck",
                          @"Token":@"0A66A4FD-146F-4542-8D7B-33CDEC2981F9",
                          @"RemarkID": ID,  //习作ID
                          };
    NSLog(@"dic = %@",dic);
    [request startWithMethod:HTTPTypePOST params:dic successedBlock:^(id succeedResult) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"ForecastUrl === %@",succeedResult);
        if ([succeedResult[@"ret_code"] integerValue] == 0) {
            [qiPaoView removeFromSuperview];
        }
    } failedBolck:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error===%@",error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
@end
