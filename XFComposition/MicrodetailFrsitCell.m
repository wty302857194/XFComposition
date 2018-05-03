//
//  MicrodetailFrsitCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailFrsitCell.h"
#import <AVFoundation/AVFoundation.h>

//#import ""
@interface MicrodetailFrsitCell ()

@end
@implementation MicrodetailFrsitCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.playView = [CLAVPlayerView videoPlayView];
        self.playView.frame = CGRectMake(20, 0, WidthFrame-40, HeightFrame/3);
//        self.playView.contrainerViewController = self;
//        self.playView.imageView
        self.playView.layer.borderWidth = 0.5;
        self.playView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        NSString *url = @"http://xf.vqune.com/LocalFiles/Weike/File/1480173972162.flv";
        
        NSString *url2 = @"http://120.25.226.186:32812/resources/videos/minion_02.mp4";
        NSString *urlss = [NSString stringWithFormat:@"%@/LocalFiles/Weike/File/1480173972162.flv",HTurl];
        [self addSubview:self.playView];

        self.playView.urlString = urlss;
        
//        UIView *microView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, WidthFrame-40, HeightFrame/3)];
//        microView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:microView];
        
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        self.titleLabel.text = @"《三年级 上册》";
        self.titleLabel.sd_layout.topSpaceToView(self.playView, 10).leftSpaceToView(self, 10).heightIs(20);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        

        UIImageView *imgView1 = [[UIImageView alloc]init];
        [self addSubview:imgView1];
        imgView1.sd_layout.leftSpaceToView(self.titleLabel, 12).topSpaceToView(self.playView,10 ).heightIs(20).widthIs(20);
        
        imgView1.image = [UIImage imageNamed:@"icon_shoucang"];
        
        
        self.scLabel = [[UILabel alloc]init];
        [self addSubview:self.scLabel];
        self.scLabel.text = @"收藏(150)";
        self.scLabel.font = [UIFont systemFontOfSize:8];
        self.scLabel.sd_layout.leftSpaceToView(imgView1, 2).topSpaceToView(self.playView, 10).heightIs(20);
        [self.scLabel setSingleLineAutoResizeWithMaxWidth:0];
        

        UIImageView *imgView2 = [[UIImageView alloc]init];
        [self addSubview:imgView2];
        imgView2.sd_layout.leftSpaceToView(self.scLabel, 5).topSpaceToView(self.playView, 10).heightIs(20).widthIs(20);
        imgView2.image = [UIImage imageNamed:@"icon_liulan"];
        [self addSubview:imgView2];
        
        self.llLabel = [[UILabel alloc]init];
        [self addSubview:self.llLabel];
        self.llLabel.text = @"浏览(150)";
        self.llLabel.font = [UIFont systemFontOfSize:8];
        self.llLabel.sd_layout.leftSpaceToView(imgView2, 2).topEqualToView(self.scLabel).heightIs(20);
        [self.llLabel setSingleLineAutoResizeWithMaxWidth:0];

        UIImageView *imgView3 = [[UIImageView alloc]init];
        [self addSubview:imgView3];
        imgView3.sd_layout.leftSpaceToView(self.llLabel, 5).topSpaceToView(self.playView, 10).heightIs(20).widthIs(20);
        imgView3.image = [UIImage imageNamed:@"icon_canjia"];
        
        
        self.cyLabel = [[UILabel alloc]init];
        [self addSubview:self.cyLabel];
        self.cyLabel.text = @"参与(150)";
        self.cyLabel.font = [UIFont systemFontOfSize:8];
        self.cyLabel.sd_layout.leftSpaceToView(imgView3, 2).topEqualToView(self.scLabel).heightIs(20);
        [self.cyLabel setSingleLineAutoResizeWithMaxWidth:0];

        UIImageView *imgView4 = [[UIImageView alloc]init];
        [self addSubview:imgView4];
        imgView4.sd_layout.leftSpaceToView(self.cyLabel, 5).topEqualToView(imgView3).heightIs(20).widthIs(20);
        
        imgView4.image = [UIImage imageNamed:@"icon_fenxiang"];
        
        
        self.fxLabel = [[UILabel alloc]init];
        [self addSubview:self.fxLabel];
        self.fxLabel.text = @"分享(150)";
        self.fxLabel.font = [UIFont systemFontOfSize:8];
        self.fxLabel.sd_layout.leftSpaceToView(imgView4, 2).topEqualToView(self.scLabel).heightIs(20);
        [self.fxLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        
        self.teacherLabel = [[UILabel alloc]init];
        [self addSubview:self.teacherLabel];
        self.teacherLabel.text = @"讲课老师:bobo";
        self.teacherLabel.font = [UIFont systemFontOfSize:10];
        self.teacherLabel.sd_layout.leftSpaceToView(self, 20).topSpaceToView(self.titleLabel, 10).heightIs(20);
        [self.teacherLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.mobiaoLabel = [[UILabel alloc]init];
        [self addSubview:self.mobiaoLabel];
        self.mobiaoLabel.text = @"讲课目标：学会写日志";
        self.mobiaoLabel.font = [UIFont systemFontOfSize:10];
        self.mobiaoLabel.sd_layout.rightSpaceToView(self, 50).topEqualToView(self.teacherLabel).heightIs(20);
        [self.mobiaoLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.duixiangLabel = [[UILabel alloc]init];
        [self addSubview:self.duixiangLabel];
        self.duixiangLabel.text = @"课程对象：小学";
        self.duixiangLabel.font = [UIFont systemFontOfSize:10];
        self.duixiangLabel.sd_layout.leftEqualToView(self.teacherLabel).topSpaceToView(self.teacherLabel, 5).heightIs(20);
        [self.duixiangLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.biaoqianLabel = [[UILabel alloc]init];
        [self addSubview:self.biaoqianLabel];
        self.biaoqianLabel.text = @"关键标签：课程/语文";
        self.biaoqianLabel.font = [UIFont systemFontOfSize:10];
        self.biaoqianLabel.sd_layout.rightEqualToView(self.mobiaoLabel).topSpaceToView(self.mobiaoLabel, 5).heightIs(20);
        [self.biaoqianLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.sjLabel = [[UILabel alloc]init];
        [self addSubview:self.sjLabel];
        self.sjLabel.text = @"课程时间";
        self.sjLabel.font = [UIFont systemFontOfSize:10];
        self.sjLabel.sd_layout.leftEqualToView(self.duixiangLabel).topSpaceToView(self.duixiangLabel, 5).heightIs(20);
        [self.sjLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.miaoshuLabel = [[UILabel alloc]init];
        [self addSubview:self.miaoshuLabel];
        self.miaoshuLabel.text = @"课程描述：";
        self.miaoshuLabel.font = [UIFont systemFontOfSize:10];
        self.miaoshuLabel.sd_layout.leftEqualToView(self.sjLabel).topSpaceToView(self.sjLabel, 5).heightIs(20);
        [self.miaoshuLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.collectbt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectbt.frame = CGRectMake(WidthFrame/5, HeightFrame/3+200-30-10, WidthFrame/5, 30);
        [self.collectbt setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectbt addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
        [self.collectbt setBackgroundColor:UIColorFromRGBA(255, 97, 0, 1.0f)];
        self.collectbt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.collectbt.layer.cornerRadius = 6;
        self.collectbt.layer.masksToBounds = YES;
        [self addSubview:self.collectbt];
        
        self.sharebt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sharebt.frame = CGRectMake(WidthFrame/5*3, HeightFrame/3+200-30-10, WidthFrame/5, 30);
        [self.sharebt setTitle:@"分享" forState:UIControlStateNormal];
        [self.sharebt addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self.sharebt setBackgroundColor:UIColorFromRGBA(255, 153, 18, 1.0f)];
        self.sharebt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.sharebt.layer.cornerRadius = 6;
        self.sharebt.layer.masksToBounds = YES;
        [self addSubview:self.sharebt];
    }
    return self;
}
//-(void)setUpVideoPlayView
//{
//    self.playView = [CLAVPlayerView videoPlayView];
//    self.playView.frame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width * 9 / 16);
//    self.playView.contrainerViewController = self;
//    [self.view addSubview:self.playView];
//    
//}

- (void)setIndex:(NSIndexPath *)index{
    self.index = index;
}
-(void)collect{
    if ([self.delegate respondsToSelector:@selector(shoucang)]) {
        [self.delegate shoucang];
    }

}
-(void)share{
    if ([self.delegate respondsToSelector:@selector(fenxiang:)]) {
        [self.delegate fenxiang :self.index];
    }

}

@end
