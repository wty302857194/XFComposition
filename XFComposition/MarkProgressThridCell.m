//
//  MarkProgressThridCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarkProgressThridCell.h"

@implementation MarkProgressThridCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, WidthFrame-40, HeightFrame-244)];
        self.textView.layer.borderWidth = 0.5;
        self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.textView.layer.cornerRadius = 6;
        self.textView.layer.masksToBounds = YES;

        [self.contentView addSubview:self.textView];
    }
    return self;
    
}

@end
