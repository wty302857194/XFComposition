//
//  WritringFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WritringFristCell.h"
@interface WritringFristCell()<UITextViewDelegate>

@end

@implementation WritringFristCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bookView = [[BookTextView alloc]init];
        [self.contentView addSubview:self.bookView];

        
        self.bookView.backgroundColor = [UIColor lightGrayColor];
        self.bookView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.bookView.sd_layout.topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).widthIs(WidthFrame).heightIs(200);
        // 设置段落样式
        self.bookView.paragraphAttributes = [ParagraphAttributes qingKeBengYue];
        
        // 设置富文本
        self.bookView.attributes          = @[[ConfigAttributedString foregroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f]
                                                                                range:NSMakeRange(0, 9)],
                                              [ConfigAttributedString font:[UIFont fontWithName:QingKeBengYue size:22.f]
                                                                     range:NSMakeRange(0, 9)]];
        
        // 加载图片
        ExclusionView *exclusionView = [[ExclusionView alloc] initWithFrame:CGRectMake(150.f, 195, 120, 120)];
        self.bookView.exclusionViews = @[exclusionView];
        UIImageView *imageView       = [[UIImageView alloc] initWithFrame:exclusionView.bounds];
//        imageView.image              = [UIImage imageNamed:@"demo"];
        [exclusionView addSubview:imageView];
        
        
        // 构建view
        [self.bookView buildWidgetView];
        
        
        // 延时0.01s执行
        [self performSelector:@selector(event)
                   withObject:nil
                   afterDelay:0.01];
    


        [self setupAutoHeightWithBottomView:self.bookView bottomMargin:0];
    }
    return self;
}
- (void)event {
    [self.bookView moveToTextPercent:0.00];
}
-(void)setModel:(CommwritelistModel *)model{
//    _model = model;
//    if ([model.BlogContent isEqualToString:@""] ) {
//        return;
//    }
//    self.bookView.textString = model.BlogContent;

}
- (CGSize)cjSizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *dic = @{NSFontAttributeName:font};  //指定字号
    CGRect rect = [string boundingRectWithSize:maxSize/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size;
}
@end
