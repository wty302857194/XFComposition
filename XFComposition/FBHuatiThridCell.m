//
//  FBHuatiThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/2.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "FBHuatiThridCell.h"

@implementation FBHuatiThridCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, WidthFrame-40, HeightFrame/2)];
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textView.layer.cornerRadius = 6;
        self.textView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.textView];
    }
    return self;
    
}

@end
