//
//  PerCenterCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PerCenterCell.h"

@implementation PerCenterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.label5 = [[UILabel alloc]init];
        [self.contentView sd_addSubviews:@[self.label1,self.label2,self.label3,self.label4,self.label5]];
        
        self.label1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, self.contentView.size.height - 15).widthIs(30).heightIs(30);
        self.label1.layer.cornerRadius = 15;
        self.label1.layer.masksToBounds = YES;
        self.label1.font = [UIFont systemFontOfSize:14];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.textColor = [UIColor whiteColor];
        self.label1.numberOfLines = 2;
        
        self.label2.sd_layout.leftSpaceToView(self.label1, 10).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:18];
        
        self.label3.sd_layout.leftSpaceToView(self.label1, 10).topSpaceToView(self.label2, 10).heightIs(30).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:14];
        
        self.label4.sd_layout.leftSpaceToView(self.label1, 10).topSpaceToView(self.label3, 10).heightIs(30).widthIs(0);
        [self.label4 setSingleLineAutoResizeWithMaxWidth:0];
        self.label4.textColor = [UIColor lightGrayColor];
        self.label4.font = [UIFont systemFontOfSize:14];
        
        self.label5.sd_layout.rightSpaceToView(self.contentView, 20).topEqualToView(self.label4).heightIs(20).widthIs(0);
        self.label5.textColor = [UIColor lightGrayColor];
        [self.label5 setSingleLineAutoResizeWithMaxWidth:0];
        self.label5.font = [UIFont systemFontOfSize:12];
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100 -0.5, kScreenWidth, 0.5)];
        image.backgroundColor = RGB_COLOR(229, 229, 229);
        [self.contentView addSubview:image];
        
    }
    return self;
}
-(void)setModel:(GetMessageListModel *)model{
    _model = model;
    if ([_model.ReadFlag integerValue] == 0) {
        self.label1.text = @"未读";
        self.label1.backgroundColor = [UIColor colorWithHexString:@"F5B450"];
        self.label4.text = @"您的作品已被点评";
    }else{
        self.label1.text = @"已读";
        self.label1.backgroundColor = [UIColor colorWithHexString:@"3691CE"];
        self.label4.text = @"您的作品已被点评";
    }
    if ([_model.MesType integerValue] == 1) {
        self.label2.text = @"普通消息";
    }else if ([_model.MesType integerValue] == 2){
        self.label2.text = @"班级消息";
    
    }else if ([_model.MesType integerValue] == 3){
        
        self.label2.text = @"系统消息";
    }else if ([_model.MesType integerValue] == 4){
        
        self.label2.text = @"学校通知";
    }
    self.label3.text =[NSString stringWithFormat:@"%@",_model.Title];
    
    self.label5.text = _model.DateTime;
}
@end
