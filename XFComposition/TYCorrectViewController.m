//
//  TYCorrectViewController.m
//  XFComposition
//
//  Created by wbb on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYCorrectViewController.h"
#import "ImageView.h"
#import "AudioRecordView.h"
#import "AudioView.h"
#import "TZImagePickerController.h"
#import "YasicClipPage.h"
#import "UploadPicRequst.h"
#import "StrokeView.h"
#import "HBDrawingBoard.h"
#import "XFLbraryViewController.h"
#import "QiPaoTagView.h"

@interface TYCorrectViewController ()<UIScrollViewDelegate,ImageViewDelegate,UITableViewDelegate,UITableViewDataSource,HBDrawingBoardDelegate>{
    
      int i;
    CGPoint _prevDraggingPosition; //拖动的起点
    CGFloat  _widthStroke; //滑动宽
   
    BOOL _isEraser; //橡皮擦
}

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) HBDrawingBoard *drawView;
@property (strong, nonatomic) IBOutlet UIButton *drawBrn;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UITableView *moreTablVuew;
@property (nonatomic, strong)AudioRecordView * recordView;
@property (strong, nonatomic) IBOutlet UIImageView *imgeView;
@property (strong, nonatomic) IBOutlet UIView *moreView;

@property (strong, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutlet UIView *leftView;
@property (nonatomic,strong)  IBOutlet UIScrollView *scorllView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftViewWidth;

@property (nonatomic, assign) CGMutablePathRef path;

@property (nonatomic, strong) NSMutableArray * moreArray;
@property (nonatomic, strong) NSMutableArray * colorArray;
@property (nonatomic, strong) NSMutableArray * widthArray;
@property (nonatomic,strong) NSMutableArray *qiPaoArr;//旁批内容


@property (strong, nonatomic) IBOutlet UIButton *cropBottomBtn;
@property (nonatomic, strong) UIColor *colorStroke;  //滑动颜色
;
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, strong) StrokeView * strokeView;

- (IBAction)crop_action:(id)sender;

- (IBAction)play_action:(id)sender;
- (IBAction)addContent_action:(id)sender;
- (IBAction)button_action:(id)sender;
@end

@implementation TYCorrectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"习作详情";
    _leftViewWidth.constant = kScreenWidth;
    _scorllView.delegate = self;
    _scorllView.contentSize = CGSizeMake(kScreenWidth*3/2, HeightFrame-SafeAreaTopHeight);
    _backgroundViewWidth.constant = kScreenWidth*3/2;
    _scorllView.pagingEnabled = YES;//设置整屏滚动
    _scorllView.bounces = YES;//设置边缘无弹跳
    _scorllView.delaysContentTouches = NO;
    _scorllView.scrollEnabled = NO;
    
    _isEraser = YES;
    _widthStroke = 1;
    _colorStroke = [UIColor redColor];
    _moreArray = [NSMutableArray arrayWithArray:@[@"清屏",@"颜色",@"画笔",@"还原大小",@"范文库",@"病文库",@"橡皮擦"]];
    
    _colorArray = [NSMutableArray array];
    _qiPaoArr = [NSMutableArray array];
    _widthArray = [NSMutableArray array];
    
    for (int i =0 ; i< @[@"红色",@"绿色",@"白色"].count; i++) {
        StandardInfo * bean = [[StandardInfo alloc]init];
        NSString * str = @[@"红色",@"绿色",@"白色"][i];
        bean.StandardText = str;
        if (i == 0) {
            bean.isSelected = YES;
        }
        [_colorArray addObject:bean];
    }
    
    for (int i =0 ; i< @[@"细",@"中",@"粗"].count; i++) {
        StandardInfo * bean = [[StandardInfo alloc]init];
        NSString * str = @[@"细",@"中",@"粗"][i];
        bean.StandardText = str;
        if (i == 0) {
            bean.isSelected = YES;
        }
        [_widthArray addObject:bean];
    }
    _moreView.hidden = YES;
    i = 0;
    _drawView = [[HBDrawingBoard alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60 - SafeAreaTopHeight)];
    _drawView.delegate = self;
    _drawView.lineWidth = 1;
    _drawView.lineColor = [UIColor redColor];
    [_leftView addSubview:_drawView];
    
    [self.drawView.backImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,_picModel.PicUrl]]];
    
    _cropBottomBtn.hidden = YES;
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [_leftView bringSubviewToFront:_bottomView];

    [_leftView bringSubviewToFront:_cropBottomBtn];
    [_leftView bringSubviewToFront:_moreView];


}
- (void)addPangPi {
    QiPaoTagView *qiPaoView = [[QiPaoTagView alloc] initWithFrame:CGRectMake(0, 200, 160, 50)];
    __weak typeof(self) weakSelf = self;
    qiPaoView.contentStrBlock = ^(NSString *contentStr) {
        [weakSelf.qiPaoArr addObject:contentStr];
    };
    [_rightView addSubview:qiPaoView];
}
- (void)drawBoard:(HBDrawingBoard *)drawView drawingStatus:(HBDrawingStatus)drawingStatus model:(HBDrawModel *)model{
    
    NSLog(@"%@",model.keyValues);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _moreView.hidden = YES;
    [_moreBtn setSelected:NO];
    
}
- (IBAction)crop_action:(id)sender {
    
    
    [_drawView cropImage];
    
    
}

- (IBAction)play_action:(id)sender {
    
    
    
    
}

-(StrokeView*)strokeView{
    
    
    if (_strokeView == nil) {
        
        __weak typeof(self) weakSelf = self;
        _strokeView = [[NSBundle mainBundle] loadNibNamed:@"StrokeView" owner:self options:nil].lastObject;
        _strokeView.layer.cornerRadius = 6.0;
        _strokeView.layer.masksToBounds = YES;
        _strokeView.strokeViewBlcok = ^(int arguments,BOOL isSetColor) {
    
            if (isSetColor) {
                
                weakSelf.drawView.lineColor = @[[UIColor redColor],[UIColor greenColor],[UIColor whiteColor]][arguments];
            }else{
                weakSelf.drawView.lineWidth = arguments+1;
            }
            
        };
        
    }
    return _strokeView;
}

//画线
-(void)drawLine:(CGPoint)from to:(CGPoint)to
{
    CGSize size = _imgeView.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [_imgeView.image drawInRect:_imgeView.frame];
    
    CGFloat strokeWidth = MAX(1, _widthStroke);
    UIColor *strokeColor = _colorStroke;
    
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
//    if(!_isEraser){
//        CGContextSetBlendMode(context, kCGBlendModeClear);
//    }

    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    
    _imgeView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}


-(AudioRecordView*)recordView{
    
    __weak typeof(self)  weakSelf = self;
    
    if (_recordView == nil) {
        _recordView = [[NSBundle mainBundle] loadNibNamed:@"AudioRecordView" owner:self options:nil].lastObject;
        _recordView.recordViewBlock = ^(id recordFileUrl) {
            
            
            
            [[XFRequestManager sharedInstance] XFRequstUploadAudio:[XFUserInfo getUserInfo].Loginid  fileValue:recordFileUrl :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    [weakSelf creatAudioView:[NSString stringWithFormat:@"%@%@",HTurl,responseData]];
                    
                }
                
            }] ;
        };
    }
    return _recordView;
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _moreArray.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = hexColor(333333);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.text = _moreArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _moreView.hidden = YES;
    [_moreBtn setSelected:NO];
    _cropBottomBtn.hidden = YES;

    switch (indexPath.row) {
        case 0:// 清屏
            [_drawView setBoard:setTypeClearAll];
            break;
        case 1: // 颜色
            [self.strokeView showStrokeView:_colorArray isSetColor:YES];
            break;
        case 2: // 画笔
             [self.strokeView showStrokeView:_widthArray isSetColor:NO];
            
            
            break;
        case 3:// 还原大小
       
            [_drawView setBoard:setTypeClearAll];
            
            
            
            break;
        case 4://范文库
            
        {
            
            
            [[XFRequestManager sharedInstance] XFRequstGetCutPicBlog:[XFUserInfo getUserInfo].Loginid blogID:_picModel.BlogID ExtractType:@"0" :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    XFLbraryViewController * vc = [[XFLbraryViewController alloc]init];
                    
                    vc.dataArray = responseData;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }] ;
            
        }
            
            
            break;
         case 5:// 病文库
        {
            
            [[XFRequestManager sharedInstance] XFRequstGetCutPicBlog:[XFUserInfo getUserInfo].Loginid blogID:_picModel.BlogID ExtractType:@"1" :^(NSString *requestName, id responseData, BOOL isSuccess) {
                if (isSuccess) {
                    XFLbraryViewController * vc = [[XFLbraryViewController alloc]init];
                    
                    vc.dataArray = responseData;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }] ;
            
        }
           
            break;
        case 6:// 橡皮擦
            _drawView.lineWidth = 10;
            
            [_drawView setBoard:setTypeEraser];
            break;
      
            
        default:
            break;
    }
    
    
    
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_scorllView.contentOffset.x == 0) {
        _scorllView.scrollEnabled = NO;
    }else{
        
        _scorllView.scrollEnabled = YES;
    }
    
}
- (IBAction)addContent_action:(id)sender {
    [self addPangPi];
    _cropBottomBtn.hidden = YES;

}

- (IBAction)button_action:(id)sender {
    UIButton * btn = (UIButton*)sender;
    _moreView.hidden = YES;
    _cropBottomBtn.hidden = YES;
    [self.drawView closeCropView];
   
    switch (btn.tag) {
        case 0://语音
            [self.recordView  showAudioRecordView];
            [_moreBtn setSelected:NO];
            [_drawBrn setSelected:NO];
            [_cropBottomBtn setSelected:NO];
            [_drawBrn setTitleColor:hexColor(333333) forState:UIControlStateNormal];
            [_drawBrn setBackgroundColor:[UIColor clearColor]];
            _drawView.isDraw = NO;
            break;
        case 1://截图
        {
            
            // 手绘不选中
            [_drawBrn setTitleColor:hexColor(333333) forState:UIControlStateNormal];
            [_drawBrn setBackgroundColor:[UIColor clearColor]];
            _drawView.isDraw = NO;
            
            [_cropBottomBtn setSelected:!_cropBottomBtn.isSelected];
            
            if (_cropBottomBtn.isSelected) {
                [self.drawView showCropView];
                _cropBottomBtn.hidden = NO;

            }
            __weak typeof(self) weakSelf = self;
            self.drawView.imgeBlock = ^(NSInteger index, UIImage *imge) {
                NSData * imageData = nil;
                
                if (UIImagePNGRepresentation(imge)) {
                    imageData = UIImagePNGRepresentation(imge);
                }else {
                    imageData = UIImageJPEGRepresentation(imge, 0.2);
                }
                UploadPicRequst *requst = [[UploadPicRequst alloc]init];
                [requst UploadPicRequstWithfileValue:imageData withuserid:[XFUserInfo getUserInfo].Loginid withtypeid:@"1" :^(NSDictionary *json){
                    NSString * str =   json[@"ret_data"]?:@"";
                    
                    [[XFRequestManager sharedInstance] XFRequstAddCutPic:[XFUserInfo getUserInfo].Loginid PicID:weakSelf.picModel.PicID blogID:weakSelf.picModel.BlogID ExtractPicUrl:str ExtractContent:@"" ExtractType:[NSString stringWithFormat:@"%ld",(long)index] :^(NSString *requestName, id responseData, BOOL isSuccess) {

                        [SVProgressHUD showInfoWithStatus:responseData];

                    }];
                    
                }];
                
            };
            [_moreBtn setSelected:NO];
            [_drawBrn setSelected:NO];

        }
            
            
            break;
            
        case 2://旁批
        {
            [_scorllView setContentOffset:CGPointMake(kScreenWidth/2, 0) animated:YES];
            _scorllView.scrollEnabled = YES;
            [_moreBtn setSelected:NO];
            [_drawBrn setSelected:NO];
            [_cropBottomBtn setSelected:NO];

            
        }
            break;
            
        case 3://手绘
        {
            [_moreBtn setSelected:NO];
            [_cropBottomBtn setSelected:NO];

            [btn setSelected:!btn.selected];

            if (_drawBrn.isSelected) {
                [_drawBrn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_drawBrn setBackgroundColor:hexColor(009dff)];
                _drawView.isDraw = YES;
                _drawView.pan.enabled = YES;
            }
            
        }
            break;
            
        case 4://撤销
        {
            [_moreBtn setSelected:NO];
            [_drawView setBoard:setTypeBack];
            [_cropBottomBtn setSelected:NO];

            [_drawBrn setSelected:NO];

        }
            break;
        case 5://更多
        {
            [_cropBottomBtn setSelected:NO];
            [btn setSelected:!btn.selected];
            [_drawBrn setSelected:NO];

            if (btn.isSelected) {
                _moreView.hidden = NO;
            }else{
                
                _moreView.hidden = YES;

            }
            [_moreTablVuew reloadData];
            
        }
            break;
            
            
        default:
            break;
    }
    
}




//创建多个
-(void)creatAudioView:(NSString*)urlStr{
    
//    [self creatView];
    AudioView * view = [[NSBundle mainBundle] loadNibNamed:@"AudioView" owner:self options:nil].lastObject;
    view.tapBlock = ^{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL URLWithString:urlStr]];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
        
        AVPlayer*  player = [AVPlayer playerWithPlayerItem:item];
        [player play];
    };
    view.panBlock = ^(CGPoint point) {
        
    };
    
    [_leftView addSubview:view];
    
}
//-(void)creatView{
//    i++;
//    ImageView *imgView = [[ImageView alloc]init];
//    imgView.tag = i;
//    imgView.delegate =self;
//    [self.rightView addSubview:imgView];
//    imgView.frame = CGRectMake(14, HeightFrame/2-32, WidthFrame/2-15, 30);
//
//}
//-(void)showAlter :(ImageView *)imgView;
//{
//    
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
