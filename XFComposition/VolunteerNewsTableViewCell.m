//
//  VolunteerNewsTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "VolunteerNewsTableViewCell.h"
#import "VolunteerModel.h"

@implementation VolunteerNewsTableViewCell

- (void)setModel:(VolunteerNewsListModel *)model
{
    _model = model;
    self.titleLab.text = [self decoderUrlEncodeStr:model.NewsTitle?:@""];
    self.numLab.text = [NSString stringWithFormat:@"浏览数：%@",model.Click?:@""];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date2 = [formatter dateFromString:model.AddTime];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSString *dateTime=[formatter stringFromDate:date2];
    NSLog(@"%@",dateTime);
    
    self.timeLab.text = [NSString stringWithFormat:@"%@",dateTime];
    
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[model.NewContent?:@"" dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    
//    self.contentLab.attributedText=attrStr;
////    self.contentLab.text = [self filterHTML:model.NewContent?:@""];
    
}
- (NSString *)decoderUrlEncodeStr: (NSString *) input{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0,[outputStr length])];
    NSString *string = [outputStr stringByRemovingPercentEncoding];
    if ([string containsString:@"<p>"]) {
        string = [string stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    }
    if ([string containsString:@"</p>"]) {
        string = [string stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    }
    return string;
}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}
@end
