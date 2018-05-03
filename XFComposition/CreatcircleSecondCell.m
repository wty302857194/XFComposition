//
//  CreatcircleSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CreatcircleSecondCell.h"

@implementation CreatcircleSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 25)];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"圈子说明：";
        [self.contentView addSubview:label];
        
        self.textview  = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 10, WidthFrame-165, 190)];
        self.textview.layer.borderWidth = 1;
        self.textview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textview.layer.cornerRadius = 6;
        self.textview.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.textview];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textview.frame)+5, 92.5, 40, 25)];
        label2.layer.cornerRadius = 6;
        label2.layer.masksToBounds = YES;
        label2.backgroundColor = [UIColor colorWithHexString:@"F3A932"];
        label2.text = @"必填";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label2];
    }
    return self;
}

@end
