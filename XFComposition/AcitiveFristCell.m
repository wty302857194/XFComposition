//
//  AcitiveFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "AcitiveFristCell.h"
@interface AcitiveFristCell()
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;
@property (nonatomic,strong)UIButton *bt1;
@property (nonatomic,strong)UIButton *bt2;

@end
@implementation AcitiveFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imgView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        self.label3 = [[UILabel alloc]init];
        self.label4 = [[UILabel alloc]init];
        self.bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView sd_addSubviews:@[self.imgView,self.label1,self.label2,self.label3,self.bt1,self.bt2]];
        
        self.imgView.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).widthIs(120).heightIs(80);
        [self.imgView addSubview:self.label4];
        self.label4.sd_layout.leftSpaceToView(self.imgView, 0).topSpaceToView(self.imgView, 60).widthIs(120).heightIs(20);
        self.label4.backgroundColor = [UIColor colorWithHexString:@"5A5A5A" alpha:0.8];
        self.label4.font = [UIFont systemFontOfSize:8];
        self.label4.textAlignment = NSTextAlignmentRight;
        self.label4.textColor = [UIColor whiteColor];
        
        
        self.bt1.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 20).widthIs(80).heightIs(30);
        self.bt1.layer.masksToBounds = YES;
        self.bt1.layer.cornerRadius = 4;
        [self.bt1 setTitle:@"查看活动详情" forState:UIControlStateNormal];
        [self.bt1 setTitleColor:[UIColor colorWithHexString:@"F3A832"] forState:UIControlStateNormal];
        self.bt1.layer.borderColor = [[UIColor colorWithHexString:@"F3A832"] CGColor];
        self.bt1.layer.borderWidth = 1;
        self.bt1.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        self.label1.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.contentView, 20).rightSpaceToView(self.bt1, 20).autoHeightRatio(0);
        self.label1.font = [UIFont systemFontOfSize:16];
        
        self.label2.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label1, 20).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.label2.font = [UIFont systemFontOfSize:14];
        
        self.label3.sd_layout.leftSpaceToView(self.imgView, 20).topSpaceToView(self.label2, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
        self.label3.font = [UIFont systemFontOfSize:14];
        
        
//        if (self.label3.origin.y + self.label3.size.height >self.imgView.origin.y +self.imgView.size.height) {
            self.bt2.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.label3, 20).rightSpaceToView(self.contentView, 20).heightIs(30);
//        }else{
//            self.bt2.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.imgView, 20).rightSpaceToView(self.contentView, 20).heightIs(30);
//        }
        self.bt2.layer.masksToBounds = YES;
        self.bt2.layer.cornerRadius = 4;
        [self.bt2 setTitle:@"查看活动详情" forState:UIControlStateNormal];
        [self.bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bt2 setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
        self.bt2.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setupAutoHeightWithBottomView:self.bt2 bottomMargin:20];
        
    }
    return self;
}

-(void)setModel:(VolunteerModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,_model.activepic];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
    self.label4.text = [NSString stringWithFormat:@"初次审核通过：0 作品限制：0"];
    self.label1.text = _model.activename;
    self.label2.text = [NSString stringWithFormat:@"活动时间：%@~%@",[_model.activestarttime substringToIndex:10],[_model.activeendtime substringToIndex:10]];
//    NSString *str2 = [self htmlEntityDecode:[_model.activeinfo stringByRemovingPercentEncoding]];
//    self.label3.text = [NSString stringWithFormat:@"活动详情：%@",str2];
    NSString * str1 = [_model.activeinfo stringByRemovingPercentEncoding];
    
    //1.将字符串转化为标准HTML字符串
    str1 = [self htmlEntityDecode:str1];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];
    self.label3.attributedText = attributeStr;
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
