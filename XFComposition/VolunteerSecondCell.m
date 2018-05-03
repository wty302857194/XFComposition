//
//  VolunteerSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerSecondCell.h"
#import "VolunteerModel.h"
@interface VolunteerSecondCell ()<UIScrollViewDelegate>

@end
@implementation VolunteerSecondCell
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/5+10)];
        _scrollView.contentSize = CGSizeMake(WidthFrame*3, HeightFrame/5+10);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
 
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WidthFrame/2-20, HeightFrame/5+10)];
//        self.backgroundView.backgroundColor =[UIColor whiteColor];
//        [self.scrollView addSubview:backView];
        
//        NSData * archiveData = [NSKeyedArchiver archivedDataWithRootObject:backView];
//        UIView* backView2 = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
//        backView2.frame = CGRectMake(WidthFrame, 0, WidthFrame, HeightFrame/5+10);
//        [self.scrollView addSubview:backView2];
//        
//
//        UIView *back1View = [self copyAView:backView];
//        back1View.frame = CGRectMake(WidthFrame, 0, WidthFrame, HeightFrame/5+10);
//        [self.scrollView addSubview:back1View];
        

        
    }
    return self;
}
-(void)layoutSubviews{
    NSLog(@"------===11   %lu",(unsigned long)self.array1.count);
    NSLog(@"------===22   %lu",(unsigned long)self.array2.count);
    NSLog(@"------===33   %lu",(unsigned long)self.array3.count);
    [self addSubview:self.scrollView];
    NSLog(@"个数%lu",self.array1.count+self.array2.count+self.array3.count);
    for (int i =0; i <self.array1.count+self.array2.count+self.array3.count; i++) {
        UIView *backView = [[UIView alloc]init ];
        //            CGRectMake(10, 0, WidthFrame/2-15, HeightFrame/5+10)
//        VolunteerModel *model = self.array[i];
        backView.frame = CGRectMake(10+(WidthFrame/2-20+20)*i, 0, WidthFrame/2-15, HeightFrame/5+10);
        backView.tag = 1000+i;
        self.backgroundView.backgroundColor =[UIColor whiteColor];
        [self.scrollView addSubview:backView];
        
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        backView.layer.cornerRadius = 6;
        backView.layer.masksToBounds = YES;
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-20, HeightFrame/25*3)];
        [backView addSubview:self.imgView];
        
        CGFloat h =HeightFrame/50;
        CGFloat textH = HeightFrame/25;
        self.titleLabel = [[UILabel alloc]init];
        [backView addSubview:self.titleLabel];
//        self.titleLabel.text = model.activename;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.sd_layout.leftSpaceToView(backView, 0).topSpaceToView(self.imgView, 2).heightIs(h-2);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        
        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/2-10-10-30, CGRectGetMaxY(self.imgView.frame)+2, 30, h-2)];
        
        //        moreLabel.sd_layout.topSpaceToView(self, 2).rightSpaceToView(self, 2).heightIs(h-2);
        
//        moreLabel.text = @"more";
        moreLabel.font = [UIFont systemFontOfSize:8];
        moreLabel.layer.cornerRadius = 7;
        moreLabel.textAlignment = NSTextAlignmentCenter;
        moreLabel.clipsToBounds = YES;
        moreLabel.layer.borderWidth = 1;
        moreLabel.text = @"more";
        moreLabel.layer.borderColor = [UIColorFromRGBA(135, 206, 235, 1.0f) CGColor];
        [backView addSubview:moreLabel];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+h+2, WidthFrame/2-20, textH+6)];
        self.textView.font = [UIFont systemFontOfSize:9];
        self.textView.text = @"22233333";
        self.textView.editable = NO;
        
        [backView addSubview:self.textView];
        CGFloat btW = (WidthFrame/2-10)/3;
        self.bt = [[UIButton alloc]initWithFrame:CGRectMake(btW, CGRectGetMaxY(self.textView.frame)+2, btW, h-2)];
        
        self.bt.titleLabel.font = [UIFont systemFontOfSize:10];
        self.bt.layer.cornerRadius = 6;
        self.bt.clipsToBounds = YES;
        self.bt.backgroundColor = UIColorFromRGBA(135, 206, 235, 1.0f);
        [self.bt setTitle:@"申请工作" forState:UIControlStateNormal];
        [backView addSubview:self.bt];
        if (i==0 || i==1) {
            VolunteerModel *model = self.array1[i];
            self.titleLabel.text = model.activename;
            self.textView.text = model.activeendtime;
            NSString *str = [NSString stringWithFormat:@"http://xf.vqune.com%@",model.activepic];
//            http://xf.vqune.com/LocalFiles/ActiveWriteImg/1501051362407.png
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:str]];
            
        }else if (i==2||i==3){
            VolunteerModel *model = self.array2[i-2];
            self.titleLabel.text = model.activename;
            NSLog(@"%@",model.activeendtime);
        
        }else if (i==4 || i==5){
            VolunteerModel *model = self.array3[i-4];
            self.titleLabel.text = model.activename;
            self.textView.text = model.activeendtime;
            NSString *str = [NSString stringWithFormat:@"http://xf.vqune.com%@",model.activepic];
            //            http://xf.vqune.com/LocalFiles/ActiveWriteImg/1501051362407.png
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:str]];

        }
    }

}
-(void)setArray:(NSArray *)array1{
    _array1 = array1;

}
-(void)setArray2:(NSArray *)array2{
    _array2 = array2;
}
-(void)setArray3:(NSArray *)array3{
    _array3 = array3;
}
@end
