//
//  PicListCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PicListCell.h"

@implementation PicListCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WidthFrame/3-30 ,130)];
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)setModel:(GetWritePicModel *)model{
    NSString *pic = [NSString stringWithFormat:@"%@",model.FixPicUrl];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.PicUrl];
    NSString *str1 = [NSString stringWithFormat:@"%@%@",HTurl,model.FixPicUrl];
    if (pic.length > 3){
         [self.imgView sd_setImageWithURL:[NSURL URLWithString:str1] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    }else{
         [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"xf_Norecord"] options:SDWebImageRefreshCached];
    }
   
}
@end
