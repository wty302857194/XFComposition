//
//  WendaCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WendaCell.h"

@implementation WendaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.titleLabel = [[UILabel alloc]init];
//        [self.contentView addSubview:self.titleLabel];
        self.textView = [[UITextView alloc]init];
        [self.contentView addSubview:self.textView];
    }
    return self;
}
-(void)setModel:(GetActivePageViewModel *)model{
    _model = model;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.frame =CGRectMake(10, 10, 200, 20);
    [self.contentView addSubview:self.titleLabel];
    
    
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
    
    
    self.textView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.titleLabel, 20).rightSpaceToView(self.contentView, 20).heightIs(50);
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.borderWidth = 1;
    self.textView.font = [UIFont systemFontOfSize:14];
    
}
@end
