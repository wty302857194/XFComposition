

//
//  ApplyActiveThirdCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyActiveThirdCell.h"

@implementation ApplyActiveThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 30)];
        label.text = @"空余时间：";
        label.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        
        self.textfield1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 5, 110, 30)];
        self.textfield1.layer.borderWidth = 0.5;
        self.textfield1.font = [UIFont systemFontOfSize:11];
        self.textfield1.textAlignment = NSTextAlignmentCenter;
        self.textfield1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:self.textfield1];
        
        UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        bt1.frame = CGRectMake(CGRectGetMaxX(label.frame), 5, 110, 30);
        bt1.tag = 1000;
        [bt1 addTarget:self action:@selector(click :) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt1];
        
        
        UILabel *jgLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textfield1.frame)+10, 20, 20, 1)];
        jgLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:jgLabel];
        
        self.textfield2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(jgLabel.frame)+10, 5, 110, 30)];
        self.textfield2.layer.borderWidth = 0.5;
        self.textfield2.font = [UIFont systemFontOfSize:11];
        self.textfield2.textAlignment = NSTextAlignmentCenter;
        self.textfield2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.contentView addSubview:self.textfield2];
        UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        bt2.frame = CGRectMake(CGRectGetMaxX(jgLabel.frame), 5, 110, 30);
        bt2.tag = 1001;
        [bt2 addTarget:self action:@selector(click :) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt2];
        
    }
    return self;
}
-(void)click :(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(showTextfield :)]) {
        [self.delegate showTextfield :bt] ;
    }
}
@end
