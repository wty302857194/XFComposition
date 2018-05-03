//
//  CommentFrsitCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CommentFrsitCell.h"
@interface CommentFrsitCell()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *cotentLabel;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
@implementation CommentFrsitCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.timeLabel = [[UILabel alloc]init];
        self.cotentLabel = [[UILabel alloc]init];
        UIImageView *img1 = [[UIImageView alloc]init];
        
        UIImageView *img2 = [[UIImageView alloc]init];
        UIImageView *img3 = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        UILabel *jgLabel1 = [[UILabel alloc]init];
        UILabel *jgLabel2 = [[UILabel alloc]init];
//        UILabel *dipLabel = [[UILabel alloc]init];
        [self.contentView sd_addSubviews:@[self.imgView,self.titleLabel,self.timeLabel,self.cotentLabel,img1,img2,img3,self.label1,self.label2,self.label3,jgLabel1,jgLabel2]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 5).widthIs(40).heightIs(40);
        self.imgView.layer.masksToBounds= YES;
        self.imgView.layer.cornerRadius = 20;
        
        self.titleLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.contentView, 10).heightIs(30).widthIs(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.timeLabel.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 14).heightIs(20).widthIs(0);
        [self.timeLabel setSingleLineAutoResizeWithMaxWidth:0];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        self.cotentLabel.sd_layout.leftSpaceToView(self.imgView, 10).topSpaceToView(self.titleLabel, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.cotentLabel.font = [UIFont systemFontOfSize:12];
        
        img1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.cotentLabel, 20).widthIs(20).heightIs(20);
        img1.backgroundColor = [UIColor lightGrayColor];
        self.label1.sd_layout.leftSpaceToView(img1, 0).topSpaceToView(self.cotentLabel, 23).heightIs(20).widthIs(0);
        [self.label1 setSingleLineAutoResizeWithMaxWidth:0];
        self.label1.font = [UIFont systemFontOfSize:12];
        self.label1.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        jgLabel1.sd_layout.leftSpaceToView(self.label1, 0).topSpaceToView(self.cotentLabel, 20).widthIs(1).heightIs(20);
        jgLabel1.backgroundColor = [UIColor lightGrayColor];
        
        img2.sd_layout.leftSpaceToView(jgLabel1, 10).topSpaceToView(self.cotentLabel, 20).widthIs(20).heightIs(20);
        img2.backgroundColor = [UIColor lightGrayColor];
        self.label2.sd_layout.leftSpaceToView(img2, 5).topSpaceToView(self.cotentLabel, 23).heightIs(20).widthIs(0);
        [self.label2 setSingleLineAutoResizeWithMaxWidth:0];
        self.label2.font = [UIFont systemFontOfSize:12];
        self.label2.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        jgLabel2.sd_layout.leftSpaceToView(self.label2, 10).topSpaceToView(self.cotentLabel, 20).widthIs(1).heightIs(20);
        jgLabel2.backgroundColor = [UIColor lightGrayColor];
        
        img3.sd_layout.leftSpaceToView(jgLabel2, 10).topSpaceToView(self.cotentLabel, 20).widthIs(20).heightIs(20);
        img3.backgroundColor = [UIColor lightGrayColor];
        
        self.label3.sd_layout.leftSpaceToView(img3, 5).topSpaceToView(self.cotentLabel, 23).heightIs(20).widthIs(0);
        [self.label3 setSingleLineAutoResizeWithMaxWidth:0];
        self.label3.font = [UIFont systemFontOfSize:12];
        self.label3.textColor = [UIColor colorWithHexString:@"6C6E6E"];
        
        [self setupAutoHeightWithBottomView:self.label1 bottomMargin:20];
    }
    return self;
}
-(void)setModel:(GetBookBjInfoModel *)model{
//    NSLog(@"---%@",[_model.content stringByRemovingPercentEncoding]);
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.userpic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.titleLabel.text = _model.title;
    self.timeLabel.text = _model.addtime;
    if ([_model.content isEqualToString:@""]) {
        self.cotentLabel.text = @"暂无";
    }else{
        NSString * str1 = [_model.content stringByRemovingPercentEncoding];
        
        //1.将字符串转化为标准HTML字符串
        str1 = [self htmlEntityDecode:str1];
        //2.将HTML字符串转换为attributeString
        NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
        
        //3.使用label加载html字符串
        self.cotentLabel.attributedText = attributeStr;
        

    }
    
    self.label1.text = [NSString stringWithFormat:@"《%@》",_model.bookname];
    self.label2.text = _model.username;
    self.label3.text = [NSString stringWithFormat:@"浏览（%@）",_model.viewtimes];
}
//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}


- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

@end
