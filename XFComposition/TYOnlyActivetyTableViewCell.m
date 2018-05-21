//
//  TYOnlyActivetyTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/5/3.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "TYOnlyActivetyTableViewCell.h"
#import "VolunteerModel.h"

@implementation TYOnlyActivetyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(VolunteerModel *)model {
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.activepic?:@""]] placeholderImage:[UIImage imageNamed:@"icon_02"]];
    
    self.titleLab.text = model.activename?:@"";
    self.timeLab.text = [NSString stringWithFormat:@"活动时间：%@-%@",[self stringFromDateString:model.activestarttime?:@""],[self stringFromDateString:model.activeendtime?:@""]];
    self.detailLab.text = [self decoderUrlEncodeStr:model.activeinfo?:@""];
    
    self.numLab.text = [NSString stringWithFormat:@"初审通过：%@ 作品限制：%@",model.activeAppmin?:@"",model.activeLimit?:@""];
}
- (NSString *)stringFromDateString:(NSString *)str
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date2 = [formatter dateFromString:str];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    return [formatter stringFromDate:date2];
}
- (NSString *)decoderUrlEncodeStr: (NSString *) input{
    NSArray *arr = [input componentsSeparatedByString:@";"];
    NSString *newStr = arr.lastObject;
    
    NSMutableString *outputStr = [NSMutableString stringWithString:newStr];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    NSString *string = [outputStr stringByRemovingPercentEncoding];
    if ([string containsString:@"<p>"]) {
        string = [string stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    }
    if ([string containsString:@"</p>"]) {
        string = [string stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    }
    
    if ([string containsString:@"</span>"]) {
        string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    }
    if ([string containsString:@">"]) {
        string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    }
    
    
    return string;
}
-(NSAttributedString *)filterHTML:(NSString *)html
{
    NSAttributedString  * attStr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType}
                                                         documentAttributes:nil
                                                                      error:nil];
    return attStr;
}
@end
