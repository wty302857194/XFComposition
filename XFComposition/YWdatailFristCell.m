//
//  YWdatailFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "YWdatailFristCell.h"

@implementation YWdatailFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc]init];
        UILabel *label1 = [[UILabel alloc]init];
        UILabel *label2 = [[UILabel alloc]init];
        UILabel *label3 = [[UILabel alloc]init];
//        [self.contentView addSubview:self.label];
        [self.contentView sd_addSubviews:@[self.label,label1,label2,label3]];
        self.label.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.label.font = [UIFont systemFontOfSize:14];
        
        label3.sd_layout.leftSpaceToView(self.contentView, WidthFrame/2-15).topSpaceToView(self.label, 30).heightIs(30).widthIs(30);
        label3.layer.cornerRadius = 4;
        label3.layer.masksToBounds = YES;
        label3.text = @"完";
        label3.font = [UIFont systemFontOfSize:18];
        label3.textColor = [UIColor whiteColor];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.backgroundColor = [UIColor colorWithHexString:@"378BFB"];
        
        label2.sd_layout.leftSpaceToView(label3, 15).topSpaceToView(self.label, 30+15).heightIs(1).widthIs(50);
        label2.backgroundColor = [UIColor colorWithHexString:@"378BFB"];
        label1.sd_layout.rightSpaceToView(label3, 15).topSpaceToView(self.label, 30+15).heightIs(1).widthIs(50);
        label1.backgroundColor = [UIColor colorWithHexString:@"378BFB"];
        [self setupAutoHeightWithBottomView:label3 bottomMargin:20];
        
        
    }
    return self;
}
-(void)setModel1:(GetDajiaListModel *)model1{
    _model1 = model1;
    NSString * str1 = [_model1.NewsContent stringByRemovingPercentEncoding];
    
    //1.将字符串转化为标准HTML字符串
    str1 = [self htmlEntityDecode:str1];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    
    //3.使用label加载html字符串
    self.label.attributedText = attributeStr;
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
