//
//  BookDetailFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookDetailFourCell.h"
@interface BookDetailFourCell()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
@implementation BookDetailFourCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *yuanLabel = [[UILabel alloc]init];
        self.label1 = [[UILabel alloc]init];
        UIImageView *img1 = [[UIImageView alloc]init];
        self.label2 = [[UILabel alloc]init];
        UIImageView *img2 = [[UIImageView alloc]init];
        self.label3 = [[UILabel alloc]init];
        
        [self.contentView sd_addSubviews:@[yuanLabel,self.label1,img1,self.label2,img2,self.label3]];
        
        yuanLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).heightIs(10).widthIs(10);
        yuanLabel.layer.cornerRadius = 5;
        yuanLabel.layer.masksToBounds = YES;
        yuanLabel.backgroundColor = [UIColor colorWithHexString:@"F3A640"];
        
        self.label1.sd_layout.leftSpaceToView(yuanLabel, 10).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:WidthFrame/4];
        self.label1.font = [UIFont systemFontOfSize:12];
        img1.sd_layout.leftSpaceToView(self.contentView, WidthFrame/3).topSpaceToView(self.contentView, 10).heightIs(15).widthIs(15);
        img1.image = [UIImage imageNamed:@"ic_book_details_xuexiao"];
        
        self.label2.sd_layout.leftSpaceToView(img1, 2).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:WidthFrame/4];
        self.label2.font = [UIFont systemFontOfSize:12];
        img2.sd_layout.leftSpaceToView(self.contentView, WidthFrame/3*2).topSpaceToView(self.contentView, 10).heightIs(15).widthIs(15);
        img2.image = [UIImage imageNamed:@"ic_book_ren"];
        
        self.label3.sd_layout.leftSpaceToView(img2, 2).topSpaceToView(self.contentView, 10).heightIs(20).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:WidthFrame/4];
        self.label3.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}
-(void)layoutSubviews{
    self.label1.text = self.model.bookname;
    self.label2.text = self.model.deptname;
    self.label3.text = self.model.username;
}

-(void)setModel:(GetBookDongTaiModel *)model{
    _model = model;

}

@end
