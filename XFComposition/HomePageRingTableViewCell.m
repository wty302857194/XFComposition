//
//  HomePageRingTableViewCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePageRingTableViewCell.h"

@implementation HomePageRingTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, WidthFrame/2-30, 90)];
        backView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        backView.layer.cornerRadius=2;
        backView.clipsToBounds =YES;
        [self.contentView addSubview:backView];
        
        UIView *topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 50)];
        topBackView.backgroundColor = UIColorFromRGBA(3, 168, 158, 1.0f);
        [backView addSubview:topBackView];
        
        self.imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        self.imgView1.backgroundColor = [UIColor redColor];
        [topBackView addSubview:self.imgView1];
        
        
        UILabel *lable = [[UILabel alloc]init];
        [backView addSubview:lable];
        lable.sd_layout.topSpaceToView(topBackView, 5).leftSpaceToView(backView, 0).heightIs(15);
        [lable setSingleLineAutoResizeWithMaxWidth:0];
        lable.text = @"圈子简介:";
        lable.font = [UIFont systemFontOfSize:9];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable.frame), CGRectGetMaxY(topBackView.frame)+5, WidthFrame/3-10, 30)];
        [backView addSubview:self.textView];
        self.textView.backgroundColor = [UIColor clearColor];
        [self.textView setEditable:NO];
        self.textView.sd_layout.topSpaceToView(topBackView, 0).leftSpaceToView(lable, 0).heightIs(30);
        //        [textView setSingleLineAutoResizeWithMaxWidth:0];
        self.textView.text = @"文明阅读，快乐写作，\n互相交流，互相学习。";
        self.textView.font = [UIFont systemFontOfSize:9];
        
        UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(WidthFrame/2+10, 0, WidthFrame/2-30, 90)];
        backView2.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        backView2.layer.cornerRadius=2;
        backView2.clipsToBounds =YES;
        [self.contentView addSubview:backView2];
        UIView *topBackView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame/2-30, 50)];
        topBackView2.backgroundColor = UIColorFromRGBA(3, 168, 158, 1.0f);
        [backView2 addSubview:topBackView2];
        
        self.imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        self.imgView2.backgroundColor = [UIColor redColor];
        [backView2 addSubview:self.imgView2];
        UILabel *lable2 = [[UILabel alloc]init];
        [backView2 addSubview:lable2];
        lable2.sd_layout.topSpaceToView(topBackView2, 5).leftSpaceToView(backView2, 0).heightIs(15);
        [lable2 setSingleLineAutoResizeWithMaxWidth:0];
        lable2.text = @"圈子简介:";
        lable2.font = [UIFont systemFontOfSize:9];
        
        self.textView2 = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable2.frame), CGRectGetMaxY(topBackView2.frame)+5, WidthFrame/3-10, 30)];
        [backView2 addSubview:self.textView2];
        self.textView2.backgroundColor = [UIColor clearColor];
        [self.textView2 setEditable:NO];
        self.textView2.sd_layout.topSpaceToView(topBackView2, 0).leftSpaceToView(lable2, 0).heightIs(30);
        self.textView2.text = @"文明阅读，快乐写作，\n互相交流，互相学习。";
        self.textView2.font = [UIFont systemFontOfSize:9];
        
    }
    return  self;
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
