//
//  MenuTableViewCell.m
//  HuiBlockmenu
//
//  Created by 周凤喜 on 2017/7/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MenuTableViewCell.h"
@interface MenuTableViewCell()

@end
@implementation MenuTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle=UITableViewCellSelectionStyleNone;

        _label = [[UILabel alloc]init];
        [self.contentView addSubview:_label];
        _label.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 3).rightSpaceToView(self.contentView, 15).bottomSpaceToView(self.contentView, 3);
        _label.font = [UIFont systemFontOfSize:12];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.layer.cornerRadius = 4;
        _label.layer.masksToBounds = YES;
        
        
        UIImageView *imge = [[UIImageView alloc]init];
        
        [self.contentView addSubview:imge];
        imge.sd_layout.bottomSpaceToView(self.contentView, .5).rightSpaceToView(self.contentView,0).leftSpaceToView(self.contentView,0).heightIs(0.5);
        imge.backgroundColor = hexColor(e5e5e5);
        
    }
    return self;
}

-(void)setStr:(NSString *)str{
    _str =str ;
    _label.text = str;

}
@end
