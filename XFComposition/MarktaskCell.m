//
//  MarktaskCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarktaskCell.h"
@interface MarktaskCell()
@property (nonatomic,strong)UILabel *titieLabel;
@property (nonatomic,strong)UILabel *TextLabel;

@end
@implementation MarktaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *lable1 = [[UILabel alloc]init];
        self.titieLabel = [[UILabel alloc]init];
        self.textLabel = [[UILabel alloc]init];
        self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
      
        lable1.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 25).heightIs(10).widthIs(10);
        lable1.backgroundColor = [UIColor colorWithHexString:@"7DCDF3"];
        lable1.layer.cornerRadius = 5;
        lable1.layer.masksToBounds = YES;
        
        self.titieLabel.sd_layout.leftSpaceToView(lable1, 10).topSpaceToView(self.contentView, 20).heightIs(30).widthIs(0);
        [self.titieLabel setSingleLineAutoResizeWithMaxWidth:WidthFrame-60];
        self.titieLabel.font = [UIFont systemFontOfSize:18];
        
        self.TextLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.titieLabel, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.TextLabel.font = [UIFont systemFontOfSize:12];
        self.TextLabel.textColor = [UIColor colorWithHexString:@"8A8D8D"];
        
        self.bt.sd_layout.leftSpaceToView(self.contentView, WidthFrame/3).topSpaceToView(self.TextLabel, 10).widthIs(WidthFrame/3).heightIs(30);
        [self.bt setBackgroundColor:[UIColor colorWithHexString:@"338ED0"]];
        [self.bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.bt.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.bt setTitle:@"作品批阅" forState:UIControlStateNormal];
        [self.bt addTarget:self action:@selector(piyue:) forControlEvents:UIControlEventTouchUpInside];
        self.bt.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        [self setupAutoHeightWithBottomView:self.bt bottomMargin:10];
        
        UIButton * firstbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        firstbtn.sd_layout.leftSpaceToView(self.contentView, WidthFrame/3).topSpaceToView(self.TextLabel, 10).widthIs(WidthFrame/3).heightIs(30);
        [firstbtn setBackgroundColor:[UIColor colorWithHexString:@"338ED0"]];
        [firstbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        firstbtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [firstbtn setTitle:@"添加标准" forState:UIControlStateNormal];
        [firstbtn addTarget:self action:@selector(piyue:) forControlEvents:UIControlEventTouchUpInside];
        firstbtn.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secondBtn.sd_layout.leftSpaceToView(self.contentView, WidthFrame/3).topSpaceToView(self.TextLabel, 10).widthIs(WidthFrame/3).heightIs(30);
        [secondBtn setBackgroundColor:[UIColor colorWithHexString:@"338ED0"]];
        [secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        secondBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [secondBtn setTitle:@"查看标准" forState:UIControlStateNormal];
        [secondBtn addTarget:self action:@selector(piyue:) forControlEvents:UIControlEventTouchUpInside];
        secondBtn.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        [self.contentView sd_addSubviews:@[lable1,self.titieLabel,self.TextLabel,self.bt]];
        
        
    }
    return self;
}
-(void)piyue:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(markTask :)]) {
        [self.delegate markTask:bt];
    }
}
-(void)setModel:(GetTeacherNeedActiveModel *)model{
    _model = model;
    self.titieLabel.text = _model.ActiveName;
    
    NSString *str1 = _model.ActiveInfo.stringByRemovingPercentEncoding  ;
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    self.TextLabel.attributedText = attributeStr;
//    self.TextLabel.text = [NSString stringWithFormat:@"活动简介：%@",[self htmlEntityDecode:[_model.ActiveInfo stringByRemovingPercentEncoding]]];
    
}

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    string = [string stringByReplacingOccurrencesOfString:@"{}" withString:@""];
    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}
@end
