//
//  MicroSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroSecondCell.h"

@implementation MicroSecondCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 =[[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
//        self.label1.text = @"《快乐阅读》";
        self.label1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).heightIs(15);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:10];
        
        
        
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
//        self.label2.text = @"课时1";
        self.label2.sd_layout.leftSpaceToView(self.label1, 20).topSpaceToView(self.contentView, 5).heightIs(15);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:10];
        
        
        self.label3 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label3];
//        self.label3.text = @"时长：【9分钟】";
        self.label3.sd_layout.leftSpaceToView(self.label2, 20).topSpaceToView(self.contentView, 5).heightIs(15);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:10];
        
    }
    return self;

}

@end
