//
//  MarktaskCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MarktaskCell.h"
@interface MarktaskCell()
@property (nonatomic,strong)IBOutlet UILabel *titieLabel;
@property (nonatomic,strong)IBOutlet  UILabel *TextLabel;
- (IBAction)button_action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *firstBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;

@end
@implementation MarktaskCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _firstBtn.layer.cornerRadius = 6;
    _firstBtn.layer.masksToBounds = YES;
    _secondBtn.layer.cornerRadius = 6;
    _secondBtn.layer.masksToBounds = YES;
    _thirdBtn.layer.cornerRadius = 6;
    _thirdBtn.layer.masksToBounds = YES;
    
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
- (IBAction)button_action:(id)sender {
    
    UIButton * btn = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(markTask :)]) {
        [self.delegate markTask:btn];
    }
}
@end
