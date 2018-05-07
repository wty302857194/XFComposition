//
//  MyFristTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyFristTableViewCell.h"

@implementation MyFristTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGBA(227, 240, 248, 1);
        
        self.photoImageView = [[UIImageView alloc]init];
        self.label = [[UILabel alloc]init];
        [self sd_addSubviews:@[self.photoImageView,self.label]];
        
        self.photoImageView.sd_layout.topSpaceToView(self, 50).centerXEqualToView(self).widthIs(86).heightIs(86);
        self.photoImageView.layer.cornerRadius = 43;
        self.photoImageView.clipsToBounds = YES;
        self.photoImageView.backgroundColor = [UIColor yellowColor];
        
        
        
        self.label.size = CGSizeMake(WidthFrame, 20);
        self.label.center =CGPointMake(WidthFrame/2, 100);
        
        
        self.label.sd_layout.topSpaceToView(self.photoImageView, 15).centerXEqualToView(self.photoImageView).heightIs(20).widthIs(0);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:13];
        
//        self.label.text = @"我读书我快乐";
        
//        self.sexLabel = [[UILabel alloc]init];
//        [backImageView addSubview:self.sexLabel];
//        self.sexLabel.sd_layout.leftSpaceToView(self.label, 5).topEqualToView(self.label).heightIs(20);
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
