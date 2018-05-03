//
//  ReadSenvenCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadSenvenCell.h"

@implementation ReadSenvenCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 10, 10)];
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.backgroundColor = [UIColor colorWithHexString:@"ABD498"];
        [self.contentView addSubview:label];
        
        self.textLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, WidthFrame/4-15, 20)];
        self.textLable.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:self.textLable];
        
        self.schoolLabel = [[UILabel alloc]initWithFrame:CGRectMake(WidthFrame/4+15, 0, WidthFrame/4-55, 20)];
        self.schoolLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.schoolLabel];
    }
    
    return self;
}
@end
