//
//  PersonalCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PersonalCell.h"

@implementation PersonalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.imgView = [[UIImageView alloc]init];
        [self.contentView sd_addSubviews:@[self.label1,self.label2,self.label3,self.imgView]];
        
        self.label1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
    
        self.label1.font = [UIFont systemFontOfSize:15];
        self.label2.sd_layout.leftSpaceToView(self.label1, 20).centerYEqualToView(self.contentView).heightIs(15).widthIs(15);
        self.label2.layer.cornerRadius = 7.5;
        self.label2.layer.masksToBounds = YES;
        self.label2.textColor = [UIColor whiteColor];
        self.label2.backgroundColor = [UIColor redColor];
        self.label2.textAlignment = NSTextAlignmentCenter;
        [self.label2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];//加粗
        
        self.label3.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:15];
        
        self.imgView.sd_layout.rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 5).heightIs(30).widthIs(30);
        self.imgView.image = [UIImage imageNamed:@"right-arrow-"];
        
        
    }
    return self;
}

@end
