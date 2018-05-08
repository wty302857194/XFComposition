//
//  MyWritingDetailCell.m
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "MyWritingDetailCell.h"

@interface MyWritingDetailCell ()
@property (strong, nonatomic) IBOutlet UIImageView *originPicImg;
@property (strong, nonatomic) IBOutlet UIImageView *editPicImg;
@property (strong, nonatomic) IBOutlet UILabel *originLabel;
@property (strong, nonatomic) IBOutlet UILabel *editLabel;

@end


@implementation MyWritingDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)reloadCellData:(id)cellData{
    
    if ([cellData isKindOfClass:[MyWritingDetailModel class]]) {
        MyWritingDetailModel *model = (MyWritingDetailModel *)cellData;
        [self.originPicImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.PicUrl]]];
        [self.editPicImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.FixPicUrl]]];
        
        if ([model.FixPicUrl isEqualToString:@""] || [model.FixPicUrl isEqualToString:nil]) {
            self.editLabel.text = @"暂无批阅图片";
        }else{
            self.editLabel.text = @"批阅图片";
        }
    }
}
+(CGFloat)cellHeight:(id)cellData{
    if ([cellData isKindOfClass:[MyWritingDetailModel class]]) {
        MyWritingDetailModel *model = (MyWritingDetailModel *)cellData;
        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@",HTurl,model.PicUrl]];// 获取的图片地址
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
        CGFloat height = 140;
        if (image) {
            height = 140*image.size.height/image.size.width;
        }
        
        return 25+height+15+21;        
    }
    return 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
