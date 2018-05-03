


//
//  ApplyActiveSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyActiveSecondCell.h"
@interface ApplyActiveSecondCell()
@end
@implementation ApplyActiveSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        label.text = @"分配选项：";
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.bt1.frame = CGRectMake(CGRectGetMaxX(label.frame)+5, 5, 100, 30);
        self.bt1.layer.masksToBounds = YES;
        self.bt1.layer.cornerRadius = 4;
        self.bt1.layer.borderWidth = 1;
        [self.bt1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.bt1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.bt1.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.bt1 addTarget:self action:@selector(fenpei) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bt1];
        
    }
    return self;
}
-(void)fenpei{
    if ([self.delegate respondsToSelector:@selector(xtfenpei)]) {
        [self.delegate xtfenpei];
    }
    
}
@end
