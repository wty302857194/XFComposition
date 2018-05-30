//
//  VolunteerActiveiTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/27.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "VolunteerActiveiTableViewCell.h"
#import "VolunteerModel.h"

@implementation VolunteerActiveiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(VolunteerModel *)model {
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.activepic?:@""]] placeholderImage:[UIImage imageNamed:@"xf_Norecord"]];
    
    self.titleLab.text = model.activename?:@"";
    self.timeLab.text = [NSString stringWithFormat:@"活动时间：%@-%@",[self stringFromDateString:model.activestarttime?:@""],[self stringFromDateString:model.activeendtime?:@""]];
    self.detailLab.text = [self decoderUrlEncodeStr:model.activeinfo?:@""];
    
    self.numLab.text = [NSString stringWithFormat:@"最小申请批阅数：%@",model.activeAppmin?:@""];
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
@end
