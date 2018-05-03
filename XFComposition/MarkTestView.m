//
//  MarkTestView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkTestView.h"
#import "MarkTestCell.h"
#import "GetActiveSubectByGuiZeRequst.h"

#import "SaveMypageRequst.h"
@interface MarkTestView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIView *backView2;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UITextField *textField1;
@property (nonatomic,strong)UITextField *textField2;
@property (nonatomic,strong)UITextField *textField3;
@property (nonatomic,strong)UITextField *textField4;
@property (nonatomic,strong)UITextField *textField5;
@property (nonatomic,strong)UITextField *textField6;
@property (nonatomic,strong)UITextField *textField7;
@property (nonatomic,strong)UITextField *textField8;
@property (nonatomic,strong)UITextField *textField9;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)GetActiveSubectByGuiZeModel *guizeModel;
@property (nonatomic,strong)NSString *str;
@end
@implementation MarkTestView

-(NSArray *)array{
    if (!_array) {
        _array = [NSArray array];
        _array = @[@"单选数量：",@"多选数量：",@"判断数量：",@"填空数量：",@"简答数量："];
    }
    return _array;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, WidthFrame-40, 160) collectionViewLayout:layout];
        _collectionView.layer.borderWidth = 0.5;
        _collectionView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MarkTestCell class] forCellWithReuseIdentifier:@"MarkTestCell"];
    }
    return _collectionView;
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 5;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MarkTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarkTestCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.array[indexPath.row];
    if (indexPath.row == 0) {
        self.textField1 = [[UITextField alloc]init];
        self.textField1 = cell.textfield;
        self.textField1.text = @"10";
    }else if (indexPath.row == 1){
        self.textField2 = [[UITextField alloc]init];
        self.textField2 = cell.textfield;
        self.textField2.text = @"10";
    }else if (indexPath.row == 2){
        self.textField3 = [[UITextField alloc]init];
        self.textField3 = cell.textfield;
        self.textField3.text = @"5";
    }else if (indexPath.row == 3){
        self.textField4 = [[UITextField alloc]init];
        self.textField4 = cell.textfield;
        self.textField4.text = @"5";
    }else if (indexPath.row == 4){
        self.textField5 = [[UITextField alloc]init];
        self.textField5 = cell.textfield;
        self.textField5.text = @"2";
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthFrame/2-40,35);
    
}

// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
    return UIEdgeInsetsMake(15, 10, 5, 10);
    
}
//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}


-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(20, HeightFrame/2-140, WidthFrame-40, 280)];
        self.backView.layer.cornerRadius = 4;
        self.backView.layer.masksToBounds = YES;
        self.backView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-100, 60)];
        label.text = @"自动出题规则设置";
        label.font = [UIFont systemFontOfSize:18];
        [self.backView addSubview:label];
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt1 setBackgroundColor:[UIColor lightGrayColor]];
        bt1.frame = CGRectMake(WidthFrame-100, 20, 20, 20);
        [bt1 addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:bt1];
        [self.backView addSubview:self.collectionView];
        
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt2 setBackgroundColor:[UIColor colorWithHexString:@"3B8DBC"]];
        bt2.frame = CGRectMake(20, 235, 80, 30);
        bt2.layer.cornerRadius = 4;
        bt2.layer.masksToBounds = YES;
        [bt2 setTitle:@"确定设置" forState:UIControlStateNormal];
        bt2.titleLabel.font = [UIFont systemFontOfSize:13];
        [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt2 addTarget:self action:@selector(dosure) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:bt2];
        
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt3 setBackgroundColor:[UIColor colorWithHexString:@"EB6752"]];
        bt3.frame = CGRectMake(WidthFrame-40-20-160, 235, 160, 30);
        bt3.layer.cornerRadius = 4;
        bt3.layer.masksToBounds = YES;
        [bt3 setTitle:@"取消自动--（手动设置题目）" forState:UIControlStateNormal];
        [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt3 addTarget:self action:@selector(cancelit) forControlEvents:UIControlEventTouchUpInside];
        bt3.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.backView addSubview:bt3];

    }
    return _backView;
}
-(UIView *)backView2{
    if (!_backView2) {
        _backView2 = [[UIView alloc]initWithFrame:CGRectMake(20, HeightFrame/2-140, WidthFrame-40, 280)];
        self.backView2.layer.cornerRadius = 4;
        self.backView2.layer.masksToBounds = YES;
        self.backView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backView2];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-100, 60)];
        label.text = @"保存试卷";
        label.font = [UIFont systemFontOfSize:18];
        [self.backView2 addSubview:label];
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt1 setBackgroundColor:[UIColor lightGrayColor]];
        bt1.frame = CGRectMake(WidthFrame-100, 20, 20, 20);
        [bt1 addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        [self.backView2 addSubview:bt1];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 80, 35)];
        
        [self makeLabel:label1 :self.backView2 :@"试卷名称"];
        self.textField6 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 80, WidthFrame-80-80, 35)];
        [self maketextfield:self.textField6 :self.backView2];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame)+15, 80, 35)];
        [self makeLabel:label2 :self.backView2 :@"试卷时间"];
        self.textField7 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame), CGRectGetMaxY(label1.frame)+15, 60, 35)];
        self.textField7.text = @"30";
        
        [self maketextfield:self.textField7 :self.backView2];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textField7.frame), CGRectGetMaxY(label1.frame)+15, 100, 35)];
        [self makeLabel:label3 :self.backView2 :@"试卷及格分数"];
        self.textField8 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMaxY(label1.frame)+15, 60, 35)];
        self.textField8.text = @"30";
        [self maketextfield:self.textField8 :self.backView2];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label2.frame)+15, 80, 35)];
        [self makeLabel:label4 :self.backView2 :@"试卷说明"];
        self.textField9 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame), CGRectGetMaxY(label2.frame)+15, WidthFrame-80-80, 35)];
        
        [self maketextfield:self.textField9:self.backView2];
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt2 setBackgroundColor:[UIColor colorWithHexString:@"3B8DBC"]];
        bt2.frame = CGRectMake(20, 235, 40, 30);
        bt2.layer.cornerRadius = 4;
        bt2.layer.masksToBounds = YES;
        [bt2 setTitle:@"保存" forState:UIControlStateNormal];
        bt2.titleLabel.font = [UIFont systemFontOfSize:13];
        [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt2 addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        [self.backView2 addSubview:bt2];
        
        UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt3 setBackgroundColor:[UIColor colorWithHexString:@"EB6752"]];
        bt3.frame = CGRectMake(WidthFrame-40-20-40, 235, 40, 30);
        bt3.layer.cornerRadius = 4;
        bt3.layer.masksToBounds = YES;
        [bt3 setTitle:@"取消" forState:UIControlStateNormal];
        [bt3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bt3 addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        bt3.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.backView2 addSubview:bt3];

    }
    return _backView2;
    
}
-(void)makeLabel :(UILabel *)label :(UIView *)view :(NSString *)str{
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithHexString:@"F3F4F3"];
    label.text = str;
    [view addSubview:label];

}
-(void)maketextfield :(UITextField *)tetxtfield :(UIView *)view{
    tetxtfield.clearButtonMode=YES;
    tetxtfield.leftViewMode=UITextFieldViewModeAlways;
    //        [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    tetxtfield.font = [UIFont systemFontOfSize:14];
    tetxtfield.layer.borderWidth = 0.5;
    tetxtfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [view addSubview:tetxtfield];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.7];
        
        [self addSubview:self.backView];
        
    }
    return self;
}


-(void)sureMake :(NSString *)field1 :(NSString *)field2 :(NSString *)field3 :(NSString *)field4 :(NSString *)field5{
    GetActiveSubectByGuiZeRequst *requst = [[GetActiveSubectByGuiZeRequst alloc]init];
    [requst GetActiveSubectByGuiZeRequstwithDanXuanSubjectNum:field1 withDuoXuanSubjectNum:field2 withPanDuanSubjectNum:field3 withTianKongSubjectNum:field4 withWenDaSubjectNum:field5 withActiveID:@"0" withuserid:self.xf.Loginid :^(NSDictionary *json) {
        if ([json[@"ret_code"] integerValue] == 0) {
            self.guizeModel = [[GetActiveSubectByGuiZeModel alloc]init];
            self.guizeModel = [GetActiveSubectByGuiZeModel loadWithJSOn:json[@"ret_data"]];
            
            self.str = [[NSString alloc]init];
            self.str = json[@"ret_data"][@"ids"];
            if ([self.delegate respondsToSelector:@selector(sureMake::)]) {
                [self.delegate sureMake:self.guizeModel :json[@"ret_data"][@"ids"]];
            }
        }
        
        
    }];
}

//确定设置
-(void)dosure{

    [self sureMake:self.textField1.text :self.textField2.text :self.textField3.text :self.textField4.text :self.textField5.text];
    
    [UIView animateWithDuration:0.01 animations:^{
        self.backView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.backView.alpha = 0;
    }];
//    [self.collectionView reloadData];
    
    self.backView2.alpha = 0;
    self.backView2.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.7 animations:^{
        self.backView2.transform = CGAffineTransformMakeScale(1, 1);
        self.backView2.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];

}
//取消自动--（手动设置题目)
-(void)cancelit{
    [self dissMiss];
}
-(void)baocun{
    if ([self.delegate respondsToSelector: @selector(SaveTest::::::::)]) {
        [self.delegate SaveTest:self.textField6.text :[NSString stringWithFormat:@"%ld",(long)self.guizeModel.allSocre] :self.textField9.text :@"0" :self.textField7.text :self.str :self.textField8.text :self.xf.Loginid];
    }

}
-(void)showView{
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1;
        
    } completion:^(BOOL finished) {

    }];
}
-(void)dissMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}
@end
