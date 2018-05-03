//
//  ApplyFrsitCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ApplyFrsitCell.h"

@implementation ApplyFrsitCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        
        self.textfield = [[UITextField alloc]init];
        
        [self.contentView addSubview:self.textfield];
        self.textfield.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(200);
        self.textfield.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}
@end
